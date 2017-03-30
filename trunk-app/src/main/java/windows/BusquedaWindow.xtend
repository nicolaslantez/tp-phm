package windows

import models.BusquedaModel
import models.DetallePOIModel
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import poi.Banco
import poi.CGP
import poi.Colectivo
import poi.Local
import utils.DefaultButton

import static utils.WindowUtils.*
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class BusquedaWindow extends SimpleWindow<BusquedaModel> {

	new(WindowOwner owner, BusquedaModel model) {
		super(owner, model)
		title = "Búsqueda de Puntos de Interés"
		taskDescription = "Escriba los valores a buscar en nuestro servicio"
		iconImage = getIcono("búsqueda")
	}

	override createFormPanel(Panel mainPanel) {
		val busquedaPanel = new Panel(mainPanel).layout = new HorizontalLayout

		new TextBox(busquedaPanel) => [
			value <=> "valorBusqueda"
			fontSize = 12
			width = 230
		]

		new DefaultButton(busquedaPanel) => [
			caption = "Buscar"
			onClick[modelObject.buscar]
			setAsDefault
		]

		new Label(mainPanel) => [
			text = "Resultado"
			fontSize = 10
		]

		new Table(mainPanel, DetallePOIModel) => [
			value <=> "poiSeleccionado"
			items <=> "resultados"
			numberVisibleRows = 5

			new Column(it) => [
				title = "Nombre"
				bindContentsToProperty("poi.nombre")
				fixedSize = 100
			]

			new Column(it) => [
				title = "Domicilio"
				bindContentsToProperty("poi.domicilio")
				fixedSize = 110
			]

			new Column(it) => [
				title = "Favorito"
				bindContentsToProperty("esFavorito").transformer = [boolean esFavorito|if(esFavorito) "Si " else "No"]
				fixedSize = 55
			]

			new Column(it) => [
				title = "Cerca"
				bindContentsToProperty("estaCerca").transformer = [boolean estaCerca|if(estaCerca) "Si " else "No"]
				fixedSize = 45
			]
		]

	}

	override protected addActions(Panel actionsPanel) {
		new DefaultButton(actionsPanel) => [
			caption = "Ver Detalle"
			onClick[
				modelObject.validar
				getVentana(modelObject.poiSeleccionado.poi).open
			]
		]

		new DefaultButton(actionsPanel) => [
			caption = "Salir"
			onClick[close new LoginWindow(this).open]
		]

	}

	def dispatch getVentana(Banco banco) {
		new POIWindowConfig(this, modelObject.poiSeleccionado) => [
			icono = "banco"
			propiedades = newLinkedHashMap(
				"Nombre" -> "compania",
				"Dirección" -> "domicilio",
				"Barrio" -> "barrio",
				"Servicios" -> "listaServicios"
			)
		]
	}

	def dispatch getVentana(CGP cgp) {
		new POIWindowConfig(this, modelObject.poiSeleccionado) => [
			icono = "cgp"
			propiedades = newLinkedHashMap(
				"Comuna" -> "nroComuna",
				"Dirección" -> "domicilio",
				"Servicios" -> "listaServicios"
			)
		]
	}

	def dispatch getVentana(Colectivo colectivo) {
		new POIWindowConfig(this, modelObject.poiSeleccionado) => [
			icono = "colectivo"
			propiedades = newLinkedHashMap(
				"Número de Línea" -> "nroLinea",
				"Cantidad de Paradas" -> "cantidadDeParadas"
			)
		]
	}

	def dispatch getVentana(Local local) {
		new POIWindowConfig(this, modelObject.poiSeleccionado) => [
			icono = "local"
			propiedades = newLinkedHashMap(
				"Nombre" -> "nombre",
				"Direccion" -> "domicilio",
				"Rubro" -> "rubro.nombre"
			)
		]
	}
}
