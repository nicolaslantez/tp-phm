function Horario() {
    this.listaDias = [];

    this.estaDisponible = function() {
        return this.listaDias.some(r => r.estaDisponible());
    }
}

Horario.asHorario = function(jsonHorario) {
    var horario = new Horario();
    var listaString = angular.extend([], jsonHorario)
    horario.listaDias = _.map(listaString, Rango.asRango);
    return horario;
}

// ----- Rango Horario -----

function Rango() {
    this.momentoAbre;
    this.momentoCierra;

    this.estaDisponible = function() {
        return moment().isBetween(this.momentoAbre, this.momentoCierra);
    }

    this.toString = function() {
        return this.momentoAbre.format('ddd: HH:mm') + this.momentoCierra.format(' - HH:mm');
    }
}

Rango.asRango = function(jsonRango) {
    var rango = new Rango();
    rango.momentoAbre = moment(jsonRango.abre);
    rango.momentoCierra = moment(jsonRango.cierra);
    return rango;
}
