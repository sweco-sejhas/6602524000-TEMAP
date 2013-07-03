'use strict';

angular.module('TEMAPApp')
  .factory 'scrollItems', (mergeSort, data) ->
    items = []
    numberItems = 50
    start = 0
    end = numberItems
    
    baseItems = null
    
    comp = (x,y) ->
      if x.dist < y.dist
        -1
      else if x.dist > y.dist
        1
      else
        0
    
    distHeap = new Heap comp
      

    {
      positionUnavailable:true
      totalSize:0
      currentItems:[]
      bottomPadSize:0
      topPadSize:0
      offset:0
      geoSort:false
      
      getBaseItems:->
        baseItems
      
      estimateDistance:->
        for item in baseItems
          item.dist = (Math.pow (item.la - this.pos.latitude), 2) + (Math.pow (item.lo - this.pos.longitude), 2)
      
      toggleGeoSort: (cb, state = !this.geoSort) ->
        this.geoSort = state
        if this.geoSort
          this.setItems items
        else
          this.setItems baseItems[...]
          
      setLocation: (pos) ->
        this.positionUnavailable = false
        this.pos = pos
        if baseItems?
          this.estimateDistance()
        
      pickNClosest: (nbr) ->
        currItems = []
        count = 0
        for i in [items.length-1..0]
            item = items[i]
            if count < nbr
              count++
              Heap.insort currItems, item,null,null,comp
              items.splice i,1
              
            else if item.dist < currItems[currItems.length-1].dist
              Heap.insort currItems, item,null,null,comp
              currItems.pop()
              items.splice i,1
              
        currItems
        
      setItems: (arr)->
        items = arr
        if this.geoSort
          currItems = this.pickNClosest numberItems
          this.currentItems = currItems
        else
          end = numberItems
          this.currentItems = items[0..end]
          
        $(window).scrollTop(0)
        
      setBaseItems: (arr)->
        baseItems = arr
        if this.pos?
          this.estimateDistance()
          
        this.setItems baseItems[...]
        
      loadMore: (ev) ->
        if this.geoSort
          Array::push.apply this.currentItems, this.pickNClosest numberItems
        else
          this.currentItems = items[0..end+=numberItems]
    }
