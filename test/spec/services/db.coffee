'use strict'

describe 'Service: db', () ->

  # load the service's module
  beforeEach module 'TEMAPApp'

  # instantiate service
  db = {}
  beforeEach inject (_db_) ->
    db = _db_

  it 'should do something', () ->
    expect(!!db).toBe true;
