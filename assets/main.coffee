global = @
requirejs(
  [
    "jquery"
    "backbone"
    "app/app"
  ]
  (
    jQuery
    Backbone
    App
  )->
    jQuery ->
      jQuery.ajaxSetup(
        headers:
          "X-CSRF-TOKEN": jQuery("meta[csrf_token]").attr("csrf_token")
      )
      global.app = new App(
        regions:
          layout: "body"
      )
      Object.freeze(global.app)

      global.app.start()
)
