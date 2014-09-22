'use strict'

describe 'Controller: ObjektCtrl', () ->

  # load the controller's module
  beforeEach module 'TEMAPApp'

  ObjektCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    ObjektCtrl = $controller 'ObjektCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3;
