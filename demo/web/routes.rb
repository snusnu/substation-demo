require 'multi_json'
require 'mustache'
require 'sinatra/base'

require 'demo'

require 'demo/web/processors'
require 'demo/web/sanitizers'
require 'demo/web/presenters'
require 'demo/web/serializers'
require 'demo/web/views'
require 'demo/web/actions'
require 'demo/web/actions/html'
require 'demo/web/actions/json'

class Demo
  module Web

    ACTIONS = {

      :HTML => {
        :list_people   => Actions::Html::LIST_PEOPLE,
        :new_person    => Actions::Html::NEW_PERSON,
        :load_person   => Actions::Html::LOAD_PERSON,
      },

      :JSON => {
        :load_person   => Actions::Json::LOAD_PERSON,
        :create_person => Actions::Json::CREATE_PERSON,
      }

    }.freeze

    HTML = Demo.new(Substation::Dispatcher.coerce(ACTIONS[:HTML], Demo::ENV))
    JSON = Demo.new(Substation::Dispatcher.coerce(ACTIONS[:JSON], Demo::ENV))

    class App < Sinatra::Base

      ROOT = Pathname(File.expand_path('../../..', __FILE__))

      set :root, ROOT

      enable :methodoverride

      # ----------------- ROUTES --------------------

      get '/people' do
        html(:list_people)
      end

      get '/person/new' do
        html(:new_person)
      end

      get '/person/:id' do
        html(:load_person, params[:id])
      end

      post '/person' do
        result = json(:create_person)
        if result.success?
          person = result.output
          redirect("/person/#{person.id}")
        else
          result.output
        end
      end

      private

      def html(action, data = nil)
        Web::HTML.call(action, data).output
      end

      def json(action)
        Web::JSON.call(action, json_data)
      end

      def json_data
        request.body.rewind
        MultiJson.load(request.body.read)
      end

    end
  end
end
