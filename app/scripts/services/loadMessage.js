// Generated by CoffeeScript 1.6.1
(function() {
  'use strict';
  angular.module('TEMAPApp').factory('loadMessage', function() {
    var exists, queue;
    queue = [];
    exists = function(msg) {
      var found, item, _i, _len;
      found = null;
      for (_i = 0, _len = queue.length; _i < _len; _i++) {
        item = queue[_i];
        if (item.msg === msg) {
          found = item;
          break;
        }
      }
      return found;
    };
    return {
      add: function(msg) {
        var item;
        item = exists(msg);
        if (item == null) {
          return queue.push({
            msg: msg,
            count: 1
          });
        } else {
          return item.count++;
        }
      },
      remove: function(msg) {
        var index, item, value, _ref, _results;
        item = exists(msg);
        if (item != null) {
          if (item.count > 1) {
            return item.count--;
          } else {
            _results = [];
            for (index in queue) {
              value = queue[index];
              if ((_ref = value.msg) === msg) {
                _results.push(queue.splice(index, 1));
              }
            }
            return _results;
          }
        }
      },
      getCurrent: function() {
        if (queue.length > 0) {
          return queue[0].msg + '...';
        } else {
          return '';
        }
      }
    };
  });

}).call(this);
