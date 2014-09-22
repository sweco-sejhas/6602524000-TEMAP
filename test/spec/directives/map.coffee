'use strict'

describe 'Directive: map', () ->
  beforeEach module 'TEMAPApp'

  element = {}

  it 'should make hidden element visible', inject ($rootScope, $compile) ->
    element = angular.element '<map></map>'
    element = $compile(element) $rootScope
    expect(element.text()).toBe 'this is the map directive'
