function CGP() {
    this.nroComuna;
    this.limites = new Polygon();
    this.listaServicios;
}

CGP.prototype = new POI();

CGP.prototype.estaDisponible = function() {
    return this.listaServicios.some(s => s.horario.estaDisponible());
}

CGP.prototype.estaCerca = function(unPoint) {
    return this.limites.isInside(unPoint);
}

CGP.fromJSON = function(jsonCGP) {
    var cgp = angular.extend(new CGP(), jsonCGP);
    cgp.ubicacion = Point.asPoint(jsonCGP.ubicacion);
    cgp.limites = Polygon.asPolygon(jsonCGP.limites);
    cgp.listaServicios = _.map(jsonCGP.servicios, Servicio.asServicio);
    return cgp;
};

// ----- Servicios -----

function Servicio() {
    this.nombre;
    this.horario;
}

Servicio.prototype.estaDisponible = function() {
    return this.horario.estaDisponible();
}

Servicio.asServicio = function(jsonServicio) {
    var servicio = new Servicio
    servicio.nombre = jsonServicio.nombre
    servicio.horario = Horario.asHorario(jsonServicio.horario);
    return servicio;
}
