// Function for toggling expandos on/off using CSS classes

var toggleExpando = function() {
  var expando = this.parentNode;
  if (hasClass(expando, 'wd-expando-on')) {
    removeClass(expando, 'wd-expando-on');
    addClass(expando, 'wd-expando-off');
  } else {
    removeClass(expando, 'wd-expando-off');
    addClass(expando, 'wd-expando-on');
  }
};

// Get the expandos on the page, add initial CSS class and event listener

var expandos = getElementsByClass('wd-expando');
for (var i=0; i < expandos.length; i++) {
  addClass(expandos[i], 'wd-expando-on');
  var expandoTitle = expandos[i].getElementsByTagName('h2')[0];
  addEventSimple(expandoTitle, 'click', toggleExpando);
}