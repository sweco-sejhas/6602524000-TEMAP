'use strict'

describe 'Service: mergeSort', () ->

  # load the service's module
  beforeEach module 'TEMAPApp'

  # instantiate service
  mergeSort = {}
  beforeEach inject (_mergeSort_) ->
    mergeSort = _mergeSort_

  it 'should do something', () ->
    expect(!!mergeSort).toBe true;
