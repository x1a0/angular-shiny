(function() {
  var shiny;

  shiny = angular.module("shiny", []);

  shiny.directive("shiny", function() {
    return {
      restrict: "A",
      link: function($scope, $elem, $attrs) {
        var center, duration, event, radius, shine, strength, type, width, _ref, _ref1, _ref2, _ref3, _ref4, _ref5;
        width = $elem.width();
        event = (_ref = $attrs.shinyOn) != null ? _ref : "mouseover";
        type = (_ref1 = $attrs.shinyType) != null ? _ref1 : null;
        duration = (_ref2 = $attrs.shinyDuration) != null ? _ref2 : 1000;
        strength = (_ref3 = $attrs.shinyStrength) != null ? _ref3 : Math.round(width / 20);
        center = (_ref4 = $attrs.shinyCenter) != null ? _ref4 : (function() {
          switch (type) {
            case "middle":
              return "50%  50%";
            case "left":
              return "0    50%";
            case "right":
              return "100% 50%";
            default:
              return "0    50%";
          }
        })();
        radius = (_ref5 = $attrs.shinyRadius) != null ? _ref5 : (function() {
          switch (type) {
            case "middle":
              return Math.round(width / 2);
            default:
              return width;
          }
        })();
        shine = function() {
          return $({
            r: 0
          }).animate({
            r: radius
          }, {
            step: function(r) {
              var mask;
              mask = "radial, " + center + ", " + r + ", " + center + ", " + (r + parseInt(strength)) + ", from(rgb(0, 0, 0)), color-stop(0.5, rgba(0, 0, 0, 0.2)), to(rgb(0, 0, 0))";
              return $($elem[0]).css("-webkit-mask", "-webkit-gradient(" + mask + ")");
            },
            duration: parseInt(duration),
            complete: function() {
              return $($elem[0]).css("-webkit-mask", "");
            }
          });
        };
        return $elem.bind(event, function() {
          return shine();
        });
      }
    };
  });

}).call(this);
