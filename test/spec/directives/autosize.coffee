'use strict'

describe 'Directive: autosize', () ->
  beforeEach module 'TEMAPApp'

  element = {}

  it 'should make hidden element visible', inject ($rootScope, $compile) ->
    element = angular.element '<autosize></autosize>'
    element = $compile(element) $rootScope
    expect(element.text()).toBe 'this is the autosize directive'
