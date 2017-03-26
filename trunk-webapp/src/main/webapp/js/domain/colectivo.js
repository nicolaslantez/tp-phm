function Colectivo() {
    this.ubicacion = [];
    this.nroCuadras = 1;
}

Colectivo.prototype = new POI();

Colectivo.prototype.distancia = function(unPoint) {
    var min = _.min(this.ubicacion, function(parada) {
        return parada.distance(unPoint);
    });

    return Math.round(min.distance(unPoint) * 10);
}

Colectivo.prototype.estaDisponible = function() {
    return true;
}

Colectivo.fromJSON = function(jsonColectivo) {
    var colectivo = angular.extend(new Colectivo(), jsonColectivo);
    colectivo.ubicacion = _.map(angular.extend([], jsonColectivo.paradas), Point.asPoint);
    return colectivo;
};
