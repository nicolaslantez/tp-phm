package windows

import java.util.Map
import models.DetallePOIModel
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import poi.Opinion
import utils.LabeledCheckBox
import utils.LabeledProperty

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*


@Accessors
class POIWindow extends Dialog<DetallePOIModel> {
	Map<String, String> mapaPropiedades

	new(WindowOwner owner, DetallePOIModel model) {
		super(owner, model)
		title = model.poi.nombre
		taskDescription = "Vea información detallada y comente sobre este POI"
	}

	override protected createFormPanel(Panel panel) {
		createDetallePanel(panel)
		createCalculatedPanel(panel)
		createOpinionPanel(panel)
	}

	def void createDetallePanel(Panel panel) {
		mapaPropiedades.forEach [ nombrePropiedad, variablePropiedad |
			new LabeledProperty(panel) => [
				nombre = nombrePropiedad + ":"
				propiedad = "poi." + variablePropiedad
			]
		]
	}

	def void createCalculatedPanel(Panel panel) {
		new LabeledProperty(panel) => [
			nombre = "Distancia (en km):"
			propiedad = "distancia"
		]
		val nuevoPanel = new Panel(panel).layout = new HorizontalLayout

		new LabeledCheckBox(nuevoPanel) => [
			nombre = "Favorito:"
			value = "esFavorito"
		]
		new LabeledProperty(nuevoPanel) => [
			nombre = "Calificación:"
			propiedad = "calificacionGeneral"
		]
	}

	def void createOpinionPanel(Panel panel) {
		new Label(panel).text = "Opine sobre este POI:"

		val panelNuevaOpinion = new Panel(panel).layout = new HorizontalLayout
		new TextBox(panelNuevaOpinion) => [
			value <=> "textoEscrito"
			height = 50
			width = 220
		]

		val panelDerecho = new Panel(panelNuevaOpinion).layout = new VerticalLayout
		new Selector(panelDerecho) => [
			items <=> "calificacionesDisponibles"
			value <=> "calificacionElegida"
		]

		new Button(panelDerecho) => [
			bindCaptionToProperty("yaOpino")
			onClick[
				modelObject.validarOpinion
				modelObject.assignOpinion
				modelObject.addOpinion
			]
			setAsDefault
		]

		new Label(panel).text = "Opiniones de otros usuarios:"
		new Table(panel, Opinion) => [
			items <=> "poi.listaOpiniones"
			numberVisibleRows = 4

			new Column(it) => [
				title = "Usuario"
				bindContentsToProperty("usuarioOpinador")
				fixedSize = 60
			]

			new Column(it) => [
				title = "Comentario"
				bindContentsToProperty("comentario")
				fixedSize = 135
			]

			new Column(it) => [
				title = "Calificación"
				bindContentsToProperty("calificacion")
				fixedSize = 80
			]
		]
	}
}
