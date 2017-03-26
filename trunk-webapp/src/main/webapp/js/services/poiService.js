app.service("poiService", function($http) {
    var self = this;

    this.findAll = function(callback) {
        $http.get('/pois').then(callback);
    };

    this.putOpinion = function(poi, opinion) {
        $http.put('/poi/' + poi.id + '/opiniones', opinion).then(self.getPois());
    };

    this.getPois = function() {
        this.findAll(function(response) {
            self.pois = _.map(response.data, asPOI);
        });
    };

    this.getPoiById = function(id) {
        return _.find(self.pois, function(poi) {
            return poi.id == id;
        });
    };

    self.getPois();
});

function asPOI(jsonPOI) {
    var poi;
    var tipoPOI = eval(jsonPOI.tipo);
    poi = tipoPOI.fromJSON(jsonPOI);
    poi.listaOpiniones = _.map(jsonPOI.listaOpiniones, Opinion.asOpinion);
    return poi;
};
