function Opinion(usuario, calificacion, comentario) {
    this.usuarioOpinador = usuario;
    this.calificacion = calificacion;
    this.comentario = comentario;
}

Opinion.prototype.validar = function() {
    if (this.calificacion == null && this.comentario == "")
        throw "Debe ingresar un comentario y una calificación";

    if (this.comentario == "")
        throw "Debe ingresar un comentario";

    if (this.calificacion == null)
        throw "Debe ingresar una calificación";
}

Opinion.asOpinion = function(jsonOpinion) {
    return angular.extend(new Opinion(), jsonOpinion);
}
