function DetalleController($stateParams, usuarioService, poiService) {
    this.usuario = usuarioService.usuarioActivo;
    this.poi = poiService.getPoiById($stateParams.id);
    this.textoComentario = "";
    this.calificacionMinima = 1;
    this.calificacionMaxima = 5;

    this.getOpinion = function() {
        return new Opinion(this.usuario.nombre, this.calificacion, this.textoComentario);
    };

    this.addOpinion = function() {
        this.errorMessage = "";
        try {
            this.getOpinion().validar();
            this.poi.addOpinion(this.getOpinion());
            poiService.putOpinion(this.poi,this.getOpinion());
            this.textoComentario = "";
            this.calificacion = null;
        } catch (exception) {
            this.errorMessage = exception;
        }
    };

    this.changeFavorito = function() {
        if (this.esFavorito())
            this.usuario.removeFavorito(this.poi);
        else
            this.usuario.addFavorito(this.poi);
      
        usuarioService.putFavorito(this.usuario,this.poi);
    };

    this.esFavorito = function() {
        return this.usuario.esFavorito(this.poi);
    };
};
