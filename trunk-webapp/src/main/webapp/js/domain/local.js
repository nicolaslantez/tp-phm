function Local() {
    this.rubro;
}

Local.prototype = new POI;

Local.fromJSON = function(jsonLocal) {
    var local = angular.extend(new Local(), jsonLocal);
    local.ubicacion = Point.asPoint(jsonLocal.ubicacion);
    local.rubro = jsonLocal.rubro.nombre;
    local.nroCuadras = jsonLocal.rubro.radio;
    local.horario = Horario.asHorario(jsonLocal.horario);
    return local;
};
