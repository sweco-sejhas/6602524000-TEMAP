'use strict'

TEMAPApp = angular.module 'TEMAPApp', ['ui.bootstrap','infinite-scroll']
window.TEMAPApp = TEMAPApp

TEMAPApp.factory 'ObjectType', ->
  selected:null
    

