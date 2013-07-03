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
      
      executeNameSort:(cb)->
        setTimeout ->
          cb(data.getDataArray())      
         ,0
      
      executeGeoSort:(cb)->
        sorted = baseItems[..]
        
        ###max = Number.MAX_VALUE
        count = 0
        
        result = []
        
        for item in sorted
          if item.dist < max
            max = item.dist
            
          if count < 100
            result.push item
          else if item.dist < max
            result.push item

        ###
        #mergeSort.sort sorted, 'dist', cb

        ###setTimeout ->
          cb (Heap.nsmallest sorted,50,comp),
         ,0###
        #mergeSort.sort (Heap.nsmallest sorted,50,comp), 'dist', cb

        setTimeout ->
          cb sorted
         ,0
      
      estimateDistance:->
        for item in baseItems
          item.dist = (Math.pow (item.la - this.pos.latitude), 2) + (Math.pow (item.lo - this.pos.longitude), 2)
      
      toggleGeoSort: (cb, state = !this.geoSort) ->
        this.geoSort = state
        if this.geoSort
          this.setItems items
        else
          this.setItems baseItems[...]
          
        ###if this.geoSort
          this.estimateDistance()
          this.executeGeoSort(cb)
        else
          this.executeNameSort(cb)###
        
      setLocation: (pos) ->
        this.positionUnavailable = false
        this.pos = pos
        if baseItems?
          this.estimateDistance()
        
      setItems: (arr)->
        items = arr
        if this.geoSort
          
          count = 0
          currItems = []
          
          for i in [items.length-1..0]
            item = items[i]
            if count < numberItems
              count++
              Heap.insort currItems, item,null,null,comp
              items.splice i,1
              
            else if item.dist < currItems[currItems.length-1].dist
              Heap.insort currItems, item,null,null,comp
              currItems.pop()
              items.splice i,1
              
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
        this.currentItems = items[0..end+=numberItems]
    }
