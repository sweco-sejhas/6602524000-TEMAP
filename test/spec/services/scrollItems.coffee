'use strict'

describe 'Service: scrollItems', () ->

  # load the service's module
  beforeEach module 'TEMAPApp'

  # instantiate service
  scrollItems = {}
  beforeEach inject (_scrollItems_) ->
    scrollItems = _scrollItems_

  it 'should do something', () ->
    expect(!!scrollItems).toBe true;
