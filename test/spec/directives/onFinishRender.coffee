'use strict'

describe 'Directive: onFinishRender', () ->
  beforeEach module 'TEMAPApp'

  element = {}

  it 'should make hidden element visible', inject ($rootScope, $compile) ->
    element = angular.element '<on-finish-render></on-finish-render>'
    element = $compile(element) $rootScope
    expect(element.text()).toBe 'this is the onFinishRender directive'
