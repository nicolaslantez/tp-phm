app.config(function($stateProvider, $urlRouterProvider) {

    $urlRouterProvider.otherwise("/");

    $stateProvider

    .state('login', {
        url: "/",
        templateUrl: "partials/login.html",
        controller: "userController as login"
    })

    .state('busqueda', {
        url: "/busqueda",
        templateUrl: "partials/busqueda.html",
        controller: "busquedaController as busqueda"
    })

    .state('detalle', {
        url: "/detalle/:id",
        params : { id : null},
        templateUrl: "partials/detalle_poi.html",
        controller: "detalleController as detalle"
    })
 
});