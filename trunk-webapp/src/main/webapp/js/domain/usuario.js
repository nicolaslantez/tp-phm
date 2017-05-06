function Usuario() {
    this.id;
    this.nombre = "";
    this.contrasenia = "";
    this.ubicacion;
    this.listaFavoritos = [];

    this.addFavorito = function(unPoi) {
        if (!this.esFavorito(unPoi))
            this.listaFavoritos.push(unPoi);
    }

    this.removeFavorito = function(unPoi) {
        var pos = this.listaFavoritos.indexOf(unPoi);
        this.listaFavoritos.splice(pos, 1);
    }

    this.esFavorito = function(unPoi) {
        var idFavoritos = this.listaFavoritos.map( f => f.id);
        return idFavoritos.includes(unPoi.id);
    }

    this.validarContrasenia = function(unaContrasenia) {
        return this.contrasenia == unaContrasenia        
            //throw "La contraseña no es correcta";  
    }
};

Usuario.asUsuario = function(jsonUsuario) {
    var usuario = angular.extend(new Usuario(), jsonUsuario)
    usuario.ubicacion = Point.asPoint(jsonUsuario.ubicacion);
    usuario.listaFavoritos = _.map(jsonUsuario.listaFavoritos, asPOI);
    return usuario;
};