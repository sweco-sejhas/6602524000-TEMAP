'use strict';

angular.module('TEMAPApp')
  .factory 'mergeSort', () ->
   
   merge = (prop, left, right) ->
      result = []
      
      while left.length>0 && right.length>0
        if left[0][prop] <= right[0][prop]
          result.push left.shift()
        else
          result.push right.shift()

      while left.length > 0
        result.push left.shift()
      
      while right.length > 0
        result.push right.shift()
        
      result
    
    mergeSort = (arr, prop, cb) ->
      if arr.length < 2
        cb arr
        return
      
      cbcount = 0
      
      middle = Math.floor (arr.length/2)
      left = arr.slice 0, middle
      right = arr.slice middle, arr.length
      
      sortedLeft = null
      sortedRight = null
      
      leftCb = (result) ->
        sortedLeft = result
        if sortedRight != null
          cb(merge prop, sortedLeft, sortedRight)
        
      rightCb = (result) ->
        sortedRight = result
        if sortedLeft != null
          cb(merge prop, sortedLeft, sortedRight)
      
      setTimeout ->
        mergeSort left, prop, leftCb
        mergeSort right, prop, rightCb
      ,0
   
    # Public API here
    {
      sort: (arr, prop, cb) ->
        mergeSort arr, prop, cb
    }
