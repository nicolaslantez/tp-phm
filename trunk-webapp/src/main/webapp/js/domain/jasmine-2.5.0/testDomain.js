describe("Suite de POIs", function() {
    var linea343;
    var cgp15;
    var bancoNacion;
    var maninHnos;
    var coco;
    var opinion;
    var opinion2;

    beforeEach(function() {
        linea343 = new Colectivo();
        linea343.ubicacion.push(new Point(1, 1));
        linea343.ubicacion.push(new Point(1, 2));

        cgp15 = new CGP();
        cgp15.ubicacion.add(new Point(1, 2));
        cgp15.ubicacion.add(new Point(3, 2));
        cgp15.ubicacion.add(new Point(2, 0));
        cgp15.horario.addDias([1, 2, 3, 4, 5], 0, 0, 23, 59);

        bancoNacion = new Banco();
        bancoNacion.ubicacion = new Point(1, 1);

        maninHnos = new Local();
        maninHnos.nroCuadras = 7
        maninHnos.ubicacion = new Point(3, 3)
        maninHnos.horario.addDias([1, 2, 3, 4, 5], 0, 0, 23, 59)
        maninHnos.listaOpiniones = [];

        coco = new Usuario();
        coco.listaFavoritos = [cgp15];

        opinion = new Opinion(coco , 4 , "Estuvo bien" );

        opinion2 = new Opinion(coco, 2,"Deja mucho que desear" );
    });

    describe("Colectivo", function() {

        it("Siempre está disponible", function() {
            expect(linea343.estaDisponible()).toBe(true);
        });

        it("Point está cerca", function() {
            expect(linea343.estaCerca(new Point(1, 1))).toBe(true);
        });

    });

    describe("CGP", function() {

        it("Ahora está disponible", function() {
            expect(cgp15.estaDisponible()).toBe(true);
        });

        it("Point está dentro de la Comuna", function() {
            expect(cgp15.estaCerca(new Point(2, 2))).toBe(true);
        });

    });

    describe("Banco", function() {
    
        it("Ahora está disponible", function() {
            expect(bancoNacion.estaDisponible()).toBe(false);
        });

        it("Point está cerca", function() {
            expect(bancoNacion.estaCerca(new Point(1, 1))).toBe(true);
        });

    });

    describe("Local", function() {

        it("Ahora está disponible", function() {
            expect(maninHnos.estaDisponible()).toBe(true);
        });

        it("Point está cerca", function() {
            expect(maninHnos.estaCerca(new Point(3, 3))).toBe(true);
        });

    });

    describe("Usuario", function() {

        it("Agrega POI a listaFavoritos", function() {
            coco.addFavorito(linea343);

            expect(coco.esFavorito(linea343)).toBe(true);
            expect(coco.listaFavoritos.length).toBe(2);
        });

        it("No agrega varias veces el mismo POI", function() {
            coco.addFavorito(cgp15);
            coco.addFavorito(cgp15);
            coco.addFavorito(cgp15);

            expect(coco.listaFavoritos.length).toBe(1);
        });

        it("Elimina POI de listaFavoritos", function() {
            expect(coco.esFavorito(cgp15)).toBe(true);

            coco.removeFavorito(cgp15);
            expect(coco.esFavorito(cgp15)).toBe(false);
        });

        it("Se registra que ya opinó", function() {
            expect(maninHnos.usuarioYaOpino(coco)).toBe(false);

            maninHnos.addOpinion(opinion);
            expect(maninHnos.usuarioYaOpino(coco)).toBe(true);
        });

        it("Solo opina una vez sobre un POI", function() {
            expect(maninHnos.listaOpiniones.length).toBe(0);

            maninHnos.addOpinion(opinion);
            expect(maninHnos.listaOpiniones.length).toBe(1);

            try {
                maninHnos.addOpinion(opinion2);
            } catch (e) { 
                expect(e).toBe("Usted ya opino");
            }
        });
    });
});
