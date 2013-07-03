// Generated by CoffeeScript 1.6.1
(function() {
  'use strict';
  angular.module('TEMAPApp').factory('scrollItems', function(data) {
    var baseItems, end, items, numberItems, start;
    items = [];
    numberItems = 50;
    start = 0;
    end = numberItems;
    baseItems = null;
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
      getItems: function() {
        return items;
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
        return this.geoSort = state;
      },
      setLocation: function(pos) {
        this.positionUnavailable = false;
        this.pos = pos;
        if (baseItems != null) {
          return this.estimateDistance();
        }
      },
      setItems: function(arr) {
        var currItems;
        items = arr;
        if (this.geoSort) {
          currItems = data.pickNClosest(numberItems, items);
          this.currentItems = currItems;
        } else {
          end = numberItems;
          this.currentItems = items.slice(0, +end + 1 || 9e9);
        }
        return $(window).scrollTop(0);
      },
      setBaseItems: function(arr) {
        baseItems = arr;
        if (this.pos != null) {
          this.estimateDistance();
        }
        return this.setItems(baseItems.slice(0));
      },
      loadMore: function(ev) {
        if (this.geoSort) {
          return Array.prototype.push.apply(this.currentItems, data.pickNClosest(numberItems, items));
        } else {
          return this.currentItems = items.slice(0, +(end += numberItems) + 1 || 9e9);
        }
      }
    };
  });

}).call(this);
