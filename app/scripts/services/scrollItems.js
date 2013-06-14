// Generated by CoffeeScript 1.6.1
(function() {
  'use strict';
  angular.module('TEMAPApp').factory('scrollItems', function() {
    var baseItems, end, items, merge, mergeSort, numberItems, start;
    items = [];
    numberItems = 50;
    start = 0;
    end = numberItems;
    baseItems = null;
    merge = function(prop, left, right) {
      var result;
      result = [];
      while (left.length > 0 && right.length > 0) {
        if (left[0][prop] <= right[0][prop]) {
          result.push(left.shift());
        } else {
          result.push(right.shift());
        }
      }
      while (left.length > 0) {
        result.push(left.shift());
      }
      while (right.length > 0) {
        result.push(right.shift());
      }
      return result;
    };
    mergeSort = function(arr, prop, cb) {
      var cbcount, left, leftCb, middle, right, rightCb, sortedLeft, sortedRight;
      if (arr.length < 2) {
        cb(arr);
        return;
      }
      cbcount = 0;
      middle = Math.floor(arr.length / 2);
      left = arr.slice(0, middle);
      right = arr.slice(middle, arr.length);
      sortedLeft = null;
      sortedRight = null;
      leftCb = function(result) {
        sortedLeft = result;
        if (sortedRight !== null) {
          return cb(merge(prop, sortedLeft, sortedRight));
        }
      };
      rightCb = function(result) {
        sortedRight = result;
        if (sortedLeft !== null) {
          return cb(merge(prop, sortedLeft, sortedRight));
        }
      };
      return setTimeout(function() {
        mergeSort(left, prop, leftCb);
        return mergeSort(right, prop, rightCb);
      }, 0);
    };
    return {
      positionUnavailable: true,
      totalSize: 0,
      currentItems: [],
      bottomPadSize: 0,
      topPadSize: 0,
      offset: 0,
      geoSort: false,
      getBaseItems: function() {
        return baseItems;
      },
      executeNameSort: function(cb) {
        var sorted;
        sorted = baseItems.slice(0);
        return mergeSort(sorted, 'n', cb);
      },
      executeGeoSort: function(cb) {
        var sorted;
        sorted = baseItems.slice(0);
        return mergeSort(sorted, 'dist', cb);
      },
      estimateDistance: function() {
        var item, _i, _len, _results;
        _results = [];
        for (_i = 0, _len = baseItems.length; _i < _len; _i++) {
          item = baseItems[_i];
          _results.push(item.dist = (Math.pow(item.la - this.pos.latitude, 2)) + (Math.pow(item.lo - this.pos.longitude, 2)));
        }
        return _results;
      },
      toggleGeoSort: function(cb, state) {
        if (state == null) {
          state = !this.geoSort;
        }
        this.geoSort = state;
        if (this.geoSort) {
          this.estimateDistance();
          return this.executeGeoSort(cb);
        } else {
          return this.executeNameSort(cb);
        }
      },
      setLocation: function(pos) {
        this.positionUnavailable = false;
        return this.pos = pos;
      },
      setItems: function(arr) {
        items = arr;
        end = numberItems;
        this.currentItems = items.slice(0, +end + 1 || 9e9);
        return $(window).scrollTop(0);
      },
      setBaseItems: function(arr) {
        baseItems = arr;
        return this.setItems(baseItems);
      },
      loadMore: function(ev) {
        return this.currentItems = items.slice(0, +(end += numberItems) + 1 || 9e9);
      }
    };
  });

}).call(this);
