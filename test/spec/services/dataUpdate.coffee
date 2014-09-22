'use strict'

describe 'Service: dataUpdate', () ->

  # load the service's module
  beforeEach module 'TEMAPApp'

  # instantiate service
  dataUpdate = {}
  beforeEach inject (_dataUpdate_) ->
    dataUpdate = _dataUpdate_

  it 'should do something', () ->
    expect(!!dataUpdate).toBe true;
