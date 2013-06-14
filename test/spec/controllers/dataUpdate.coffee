'use strict'

describe 'Controller: DataUpdateCtrl', () ->

  # load the controller's module
  beforeEach module 'TEMAPApp'

  DataUpdateCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    DataUpdateCtrl = $controller 'DataUpdateCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3;
