function Point(x, y) {

    this.x = x;
    this.y = y

}

Point.prototype.latitude = function() {
    return this.x;
}

Point.prototype.longitude = function() {
    return this.y;
}

Point.prototype.distance = function(anotherPoint) {

    var earthRadius = 6371;

    var deltaLatitude = toRadian(anotherPoint.latitude() - this.latitude());

    var deltaLongitude = toRadian(anotherPoint.longitude() - this.longitude());

    var a = Math.sin(deltaLatitude / 2) * Math.sin(deltaLatitude / 2) + Math.cos(toRadian(this.latitude())) *
        Math.cos(toRadian(anotherPoint.latitude())) * Math.sin(deltaLongitude / 2) * Math.sin(deltaLongitude / 2);

    var distanceAngular = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

    return earthRadius * distanceAngular;
}

Point.asPoint = function(jsonPoint) {
    return angular.extend(new Point(), jsonPoint);
}

function toRadian(angle) {
    return Math.PI * angle / 180.0;
}



function Polygon(points) {
    this.surface = points || [];
}

Polygon.prototype.add = function(point) {
    this.surface.push(point);
}

Polygon.prototype.isInside = function(point) {

    var N = this.surface.length;
    var j = N - 1;
    var oddNodes = false;
    var x = point.longitude();
    var y = point.latitude();

    for (i = 0; i < N; i++) {

        var verticeIY = this.surface[i].latitude();
        var verticeIX = this.surface[i].longitude();
        var verticeJY = this.surface[j].latitude();
        var verticeJX = this.surface[j].longitude();

        if ((verticeIY < y && verticeJY >= y || verticeJY < y && verticeIY >= y) &&
            (verticeIX <= x || verticeJX <= x)) {
            if (verticeIX + (y - verticeIY) / (verticeJY - verticeIY) * (verticeJX - verticeIX) < x) {
                oddNodes = !oddNodes;
            }
        }

        j = i;

    }

    return oddNodes;
}

Polygon.asPolygon = function(jsonPolygon) {
    var polygon = new Polygon();
    polygon.surface = _.map( angular.extend( [], jsonPolygon.surface),Point.asPoint);
    return polygon;
}