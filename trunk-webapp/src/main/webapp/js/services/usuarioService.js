app.service("usuarioService", function($http) {
    var self = this;

    this.findAll = function(callback) {
        $http.get('/usuarios').then(callback);
    };

    this.putFavorito = function(usuario, poi) {
        $http.put('/usuario/' + usuario.nombre + '/favoritos', poi.id).then(self.getUsuarios());
    };

    this.logIn = function(usuario) {
        this.usuarioActivo = usuario;
    };

    this.putLog = function(usuario, estado) {
        $http.put('/usuario/' + usuario.nombre + '/estado', estado).then(self.getUsuarios());
    };

    this.getUsuarios = function() {
        this.findAll(function(response) {
            self.usuarios = _.map(response.data, asUsuario);
        });
    };

    this.getUsuarioByNombre = function(nombre) {
        var usuario = _.find(this.usuarios, function(usuario) {
            return usuario.nombre == nombre;
        });

        if (!usuario)
            throw "Ese usuario no existe";

        return usuario;
    };

    self.getUsuarios();
});


function asUsuario(jsonUsuario) {
    return Usuario.asUsuario(jsonUsuario);
};
