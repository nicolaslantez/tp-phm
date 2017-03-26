var app = angular.module('poiApp', ['ui.router']);

app.filter('siNo', function() {
    return function(unBoolean) {
        return unBoolean ? 'Si' : 'No';
    }
});
