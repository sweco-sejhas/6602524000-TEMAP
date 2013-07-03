
  L.AnchorIcon = L.Icon.extend({
	  options: {
		  /*
		  iconUrl: (String) (required)
		  iconRetinaUrl: (String) (optional, used for retina devices if detected)
		  iconSize: (Point) (can be set through CSS)
		  iconAnchor: (Point) (centered by default, can be set in CSS with negative margins)
		  popupAnchor: (Point) (if not specified, popup opens in the anchor point)
		  shadowUrl: (Point) (no shadow by default)
		  shadowRetinaUrl: (String) (optional, used for retina devices if detected)
		  shadowSize: (Point)
		  shadowAnchor: (Point)
		  */
		  className: ''
	  },

	  _createIcon: function (name, oldIcon) {
		  var src = this._getIconUrl(name);

		  if (!src) {
			  if (name === 'icon') {
				  throw new Error('iconUrl not set in Icon options (see the docs).');
			  }
			  return null;
		  }

		  var img;
		  if (!oldIcon || oldIcon.tagName !== 'IMG') {
			  img = this._createImg(src);
		  } else {
			  img = this._createImg(src, oldIcon);
		  }
		  this._setIconStyles(img, name);

      var anchor = document.createElement('a');
      anchor.className = 'leaflet-marker-icon';
      anchor.href = this.options['href'];
      anchor.target = '_blank';
      anchor.appendChild(img);

		  return anchor;
	  },

	  _setIconStyles: function (img, name) {
		  var options = this.options,
		      size = L.point(options[name + 'Size']),
		      anchor;

		  if (name === 'shadow') {
			  anchor = L.point(options.shadowAnchor || options.iconAnchor);
		  } else {
			  anchor = L.point(options.iconAnchor);
		  }

		  if (!anchor && size) {
			  anchor = size.divideBy(2, true);
		  }

		  img.className = 'leaflet-marker-' + name + ' ' + options.className;

		  if (anchor) {
			  img.style.marginLeft = (-anchor.x) + 'px';
			  img.style.marginTop  = (-anchor.y) + 'px';
		  }

		  if (size) {
			  img.style.width  = size.x + 'px';
			  img.style.height = size.y + 'px';
		  }
	  },

	  _createImg: function (src, el) {

		  if (!L.Browser.ie6) {
			  if (!el) {
				  el = document.createElement('img');
			  }
			  el.src = src;
		  } else {
			  if (!el) {
				  el = document.createElement('div');
			  }
			  el.style.filter =
			          'progid:DXImageTransform.Microsoft.AlphaImageLoader(src="' + src + '")';
		  }
		  return el;
	  },

	  _getIconUrl: function (name) {
		  if (L.Browser.retina && this.options[name + 'RetinaUrl']) {
			  return this.options[name + 'RetinaUrl'];
		  }
		  return this.options[name + 'Url'];
	  }
  });

  L.icon = function (options) {
	  return new L.Icon(options);
  };
