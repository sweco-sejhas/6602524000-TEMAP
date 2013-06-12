'use strict'

describe 'Controller: TabCtrl', () ->

  # load the controller's module
  beforeEach module 'TEMAPApp'

  TabCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    TabCtrl = $controller 'TabCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3;
