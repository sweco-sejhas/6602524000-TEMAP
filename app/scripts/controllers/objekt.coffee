'use strict'

angular.module('TEMAPApp')
  .controller 'ObjektCtrl', ($scope, ObjectType, scrollItems) ->
    $scope.ObjectType = ObjectType
    $scope.scrollItems = scrollItems
