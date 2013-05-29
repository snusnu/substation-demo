var PeopleController = function ($scope, $http) {

  $scope.update = function() {
    $http.post("/person", $scope.person)
      .success(function (data) {
        window.location.replace(data.location)
        $scope.person = data.resource;
      });
  };
};
