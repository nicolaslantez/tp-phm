function BusquedaController(usuarioService, poiService) {
	this.usuario = usuarioService.usuarioActivo;
	this.textoBusqueda = "";

    this.buscar = function() {
        this.filtro = this.textoBusqueda;
    };

    this.pois = function() {
    	return poiService.pois;
    }
};