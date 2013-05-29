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
          <style type="text/css">
            .css-form input.ng-invalid.ng-dirty {
              background-color: #FA787E;
            }
            .css-form input.ng-valid.ng-dirty {
              background-color: #78FA89;
            }
          </style>
          <body>
            #{body}
          </body>
        </html>
        HTML
      end

      class Person

        NEW = Views.page(<<-HTML)
          <div ng-controller="PeopleController">
            <form novalidate class="css-form">
              Name: <input type="text" ng-model="person.name" required /><br />
              <button ng-click="update(person)">SAVE</button>
            </form>
          </div>
        HTML

        SHOW = Views.page("Hey {{name}}")

        LIST = Views.page(<<-HTML)
          <ul>
          {{#people}}
            <li>{{name}}</li>
          {{/people}}
          </ul>
        HTML

      end
    end
  end
end
