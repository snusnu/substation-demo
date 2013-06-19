require 'multi_json'
require 'mustache'
require 'sinatra/base'

require 'demo'

require 'demo/web/processors'
require 'demo/web/sanitizers'
require 'demo/web/presenters'
require 'demo/web/serializers'
require 'demo/web/views'

class Demo
  module Web

    ENV = Substation::Environment.build do
      register :evaluate,  Substation::Processor::Evaluator
      register :call,      Substation::Processor::Pivot
      register :wrap,      Substation::Processor::Wrapper
      register :render,    Renderer
    end

    require 'demo/web/actions'
    require 'demo/web/actions/html'
    require 'demo/web/actions/json'

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

      post '/person' do
        result   = json(:create_person, json_data)
        location = result.success? ? '/people' : '/person/new'
        json_redirect(location, result.output)
      end

      get '/person/:id' do
        html(:load_person)
      end

      get '/person/:id/json' do
        json(:load_person).output
      end

      private

      def html(action)
        Web::HTML.call(action, params).output
      end

      def json(action, data = Undefined)
        Web::JSON.call(action, data.equal?(Undefined) ? params : data)
      end

      def json_data
        request.body.rewind
        MultiJson.load(request.body.read)
      end

      def json_redirect(location, data)
        MultiJson.dump(:location => location, :resource => data)
      end

    end
  end
end
