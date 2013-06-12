'use strict';

angular.module('TEMAPApp')
  .factory 'scrollItems', () ->
    items = []
    numberItems = 60
    bufferSize = 30
    
    prevStart = 0
    end = prevStart + numberItems
    
    for i in [0..200] by 1
      items.push ('item-' + i)
      
    currentItems = items[prevStart..end]
    
    {
      totalSize:0
      currentItems:currentItems
      bottomPadSize:0
      topPadSize:0
      loadMore: (ev) ->
        if ev.type == 'setup'
          itemHeight = Math.round(ev.elemHeight/currentItems.length)
          this.bottomPadSize = itemHeight*(items.length-currentItems.length)
        else
          itemHeight = ev.elemHeight/currentItems.length
          this.totalSize = itemHeight*items.length
          
          start = prevStart + (bufferSize*ev.direction)
          start = Math.max start, 0
          
          if start + numberItems > items.length
            start = items.length - numberItems
          
          nbrShifted = Math.abs(start - prevStart)
          prevStart = start
          
          end = start+numberItems
          
          if start == 0
            this.topPadSize = 0
          else
            this.topPadSize += (itemHeight*nbrShifted*ev.direction)
          
          this.bottomPadSize = this.totalSize-this.topPadSize-(itemHeight*(end-start))
          this.currentItems = items[start..end]
    }
