'use strict'

describe 'Service: geo', () ->

  # load the service's module
  beforeEach module 'TEMAPApp'

  # instantiate service
  geo = {}
  beforeEach inject (_geo_) ->
    geo = _geo_

  it 'should do something', () ->
    expect(!!geo).toBe true;
