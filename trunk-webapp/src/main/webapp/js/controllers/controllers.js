app.controller('userController', function($state, usuarioService) {
    return new UserController($state, usuarioService);
});

app.controller('busquedaController', function(usuarioService, poiService) {
    return new BusquedaController(usuarioService, poiService);
});

app.controller('detalleController', function($stateParams, usuarioService, poiService) {
    return new DetalleController($stateParams, usuarioService, poiService);
});
