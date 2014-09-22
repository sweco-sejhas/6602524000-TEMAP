'use strict'

describe 'Service: loadMessage', () ->

  # load the service's module
  beforeEach module 'TEMAPApp'

  # instantiate service
  loadMessage = {}
  beforeEach inject (_loadMessage_) ->
    loadMessage = _loadMessage_

  it 'should do something', () ->
    expect(!!loadMessage).toBe true;
