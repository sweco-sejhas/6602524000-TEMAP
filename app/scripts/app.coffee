'use strict'

TEMAPApp = angular.module 'TEMAPApp', ['ui.bootstrap','infinite-scroll']
window.TEMAPApp = TEMAPApp

TEMAPApp.factory 'ObjectType', (geo)->
  selected:null
    

###
Code used to generate random items in/around Trelleborg
(->
  center = 
    lat:55.38573
    lon:13.15462

  buffer = 0.01

  items = []
  for i in [0..500] by 1
    items.push 
      n:'nat-' + i
      la:parseFloat( (center.lat + (Math.random()*buffer*(Math.round(Math.random()) * 2 - 1))).toFixed(5) )
      lo:parseFloat( (center.lon + (Math.random()*buffer*(Math.round(Math.random()) * 2 - 1))).toFixed(5) )

  1  
)()###
