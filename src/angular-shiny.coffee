shiny = angular.module "shiny", []

shiny.directive "shiny", ->

  restrict: "A"

  link: ($scope, $elem, $attrs) ->
    width = $elem.width()

    event    = $attrs.shinyOn       ? "mouseover"
    type     = $attrs.shinyType     ? null
    duration = $attrs.shinyDuration ? 1000
    strength = $attrs.shinyStrength ? Math.round(width / 20)

    center = $attrs.shinyCenter ? (->
      switch type
        when "middle" then "50%  50%"
        when "left"   then "0    50%"
        when "right"  then "100% 50%"
        else               "0    50%" # default to left
    )()

    radius = $attrs.shinyRadius ? (->
      switch type
        when "middle" then Math.round(width / 2)
        else          width
    )()

    shine = ->
      $({r: 0}).animate {r: radius}, {
        step: (r) ->
          mask = "radial, #{center}, #{r}, #{center}, #{r + parseInt(strength)}, from(rgb(0, 0, 0)), color-stop(0.5, rgba(0, 0, 0, 0.2)), to(rgb(0, 0, 0))"
          $($elem[0]).css("-webkit-mask", "-webkit-gradient(#{mask})")

        duration: parseInt(duration)
        complete: -> $($elem[0]).css("-webkit-mask", "")
      }

    $elem.bind event, -> shine()
