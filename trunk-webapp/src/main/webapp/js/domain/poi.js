function POI() {
    this.ubicacion;
    this.nroCuadras = 5;
    this.nombre = "";
    this.domicilio = "";
    this.listaOpiniones = [];
}

POI.prototype = {
    distancia: function(unPoint) {
        return Math.round(this.ubicacion.distance(unPoint) * 10);
    },

    estaCerca: function(unPoint) {
        return this.distancia(unPoint) <= this.nroCuadras;
    },

    estaDisponible: function() {
        return this.horario.estaDisponible();
    },

    addOpinion: function(unaOpinion) {
        var opinion = this.getOpinionByUser(unaOpinion.usuarioOpinador)
        if (opinion)
            this.listaOpiniones.splice(this.listaOpiniones.indexOf(opinion), 1);
        this.listaOpiniones.push(unaOpinion);
    },

    getOpinionByUser: function(unUsuario) {
        return _.find(this.listaOpiniones, function(opinion) {
            return opinion.usuarioOpinador == unUsuario;
        })
    },

    usuarioYaOpino: function(usuario) {
        return this.listaOpiniones.map(o => o.usuarioOpinador).includes(usuario.nombre);
    },

    tieneOpiniones: function() {
        return this.listaOpiniones.length > 0;
    },

    calificacionPromedio: function() {
        if (this.tieneOpiniones()) {
            var promedio = this.listaOpiniones.reduce(function(aux, unaOpinion) {
                return aux + unaOpinion.calificacion;
            }, 0) / this.listaOpiniones.length;

            return Math.round(promedio * 10) / 10;
        } else return 0;
    }
}
