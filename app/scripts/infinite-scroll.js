// Generated by CoffeeScript 1.6.1
(function() {
  'use strict';
  var mod;

  mod = angular.module('infinite-scroll', []);

  mod.directive('infiniteScroll', [
    '$rootScope', '$window', '$timeout', '$parse', function($rootScope, $window, $timeout, $parse) {
      return {
        link: function(scope, elem, attrs) {
          var checkWhenEnabled, elemOffset, firstLoad, handler, prevScrollTop, scrollDistance, scrollEnabled;
          $window = angular.element($window);
          scrollDistance = 0;
          if (attrs.infiniteScrollDistance !== null) {
            scope.$watch(attrs.infiniteScrollDistance, function(value) {
              return scrollDistance = parseInt(value, 10);
            });
          }
          prevScrollTop = 0;
          elemOffset = 0;
          firstLoad = true;
          scrollEnabled = true;
          checkWhenEnabled = false;
          if (attrs.infiniteScrollDisabled !== null) {
            scope.$watch(attrs.infiniteScrollDisabled, function(value) {
              scrollEnabled = !value;
              if (scrollEnabled && checkWhenEnabled) {
                checkWhenEnabled = false;
                return handler();
              }
            });
          }
          handler = function() {
            var direction, elementBottom, elementTop, ev, fn, shouldScroll, windowBottom, windowTop;
            direction = 1;
            if (($window.scrollTop() - prevScrollTop) < 0) {
              direction = -1;
            }
            prevScrollTop = $window.scrollTop();
            windowBottom = $window.height() + $window.scrollTop();
            windowTop = $window.scrollTop();
            elementBottom = elem.offset().top + elem.height();
            elementTop = elem.offset().top;
            shouldScroll = false;
            if (elementBottom <= windowBottom) {
              shouldScroll = true;
            }
            if (elementTop - elemOffset >= windowTop) {
              shouldScroll = true;
            }
            if (firstLoad) {
              if ($window.scrollTop() === 0) {
                elemOffset = elem.offset().top;
              }
              fn = $parse(attrs.infiniteScroll);
              scope.$apply(function() {
                return fn(scope, {
                  $event: {
                    type: 'setup',
                    elemHeight: elem.height()
                  }
                });
              });
              return firstLoad = false;
            } else if (shouldScroll && scrollEnabled) {
              ev = {
                type: 'scroll',
                elemHeight: elem.height(),
                direction: direction
              };
              if ($rootScope.$$phase) {
                return scope.$eval(attrs.infiniteScroll({
                  $event: ev
                }));
              } else {
                fn = $parse(attrs.infiniteScroll);
                return scope.$apply(function() {
                  return fn(scope, {
                    $event: ev
                  });
                });
              }
            } else if (shouldScroll) {
              return checkWhenEnabled = true;
            }
          };
          $window.on('scroll', handler);
          scope.$on('$destroy', function() {
            return $window.off('scroll', handler);
          });
          return $timeout(function() {
            if (attrs.infiniteScrollImmediateCheck) {
              if (scope.$eval(attrs.infiniteScrollImmediateCheck)) {
                return handler();
              }
            } else {
              return handler();
            }
          }, 0);
        }
      };
    }
  ]);

}).call(this);
