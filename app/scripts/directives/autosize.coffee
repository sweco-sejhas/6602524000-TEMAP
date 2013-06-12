'use strict';

TEMAPApp.directive 'autosize', ($window) ->
  ($scope, element, attrs) ->
    selectors = attrs.autosize.split ','
    elems = []
    
    for selector in selectors
      elems.push ($ selector)
    
    resizor = ->
      $scope.$apply ->
          height = 0
          for el in elems
            if el.is ':visible'
              height += el.outerHeight true
              
          element.height ($window.innerHeight - height)
          
    angular.element($window).bind 'resize', resizor
    element.bind '$destroy', ->
      angular.element($window).unbind 'resize', resizor
      
    setTimeout ()->
      resizor()
    ,0
