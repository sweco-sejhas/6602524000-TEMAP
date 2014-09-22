'use strict'

describe 'Service: infiniteScroll', () ->

  # load the service's module
  beforeEach module 'TEMAPApp'

  # instantiate service
  infiniteScroll = {}
  beforeEach inject (_infiniteScroll_) ->
    infiniteScroll = _infiniteScroll_

  it 'should do something', () ->
    expect(!!infiniteScroll).toBe true;
