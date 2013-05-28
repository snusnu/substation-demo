class Demo
  module Web

    module Views

      def self.page(body)
        <<-HTML
        <!doctype html>
        <html ng-app>
          <head>
            <script src="http://code.angularjs.org/1.0.6/angular.min.js"></script>
            <script src="/js/script.js"></script>
          </head>
          <body>
            #{body}
          </body>
        </html>
        HTML
      end

      class Person

        NEW = Views.page(<<-HTML)
          <div ng-controller="PeopleController">
            <form novalidate class="simple-form">
              Name: <input type="text" ng-model="person.name" /><br />
              <button ng-click="update(person)">SAVE</button>
            </form>
          </div>
        HTML

        SHOW = Views.page("Hey {{name}}")

        LIST = Views.page(<<-HTML)
          TODO: list people
        HTML

      end
    end
  end
end
