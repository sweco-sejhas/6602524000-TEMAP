'use strict';

describe('Directive: autosize', function () {
  beforeEach(module('appApp'));

  var element;

  it('should make hidden element visible', inject(function ($rootScope, $compile) {
    element = angular.element('<autosize></autosize>');
    element = $compile(element)($rootScope);
    expect(element.text()).toBe('this is the autosize directive');
  }));
});
