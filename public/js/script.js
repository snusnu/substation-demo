var PeopleController = function ($scope, $http) {

  $scope.update = function() {
    $http.post("/person", $scope.person)
      .success(function (person) {
        $scope.person = person;
      });
  };
};
