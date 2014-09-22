'use strict'

describe 'Controller: ObjektTypCtrl', () ->

  # load the controller's module
  beforeEach module 'TEMAPApp'

  ObjektTypCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    ObjektTypCtrl = $controller 'ObjektTypCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', () ->
    expect(scope.awesomeThings.length).toBe 3;
