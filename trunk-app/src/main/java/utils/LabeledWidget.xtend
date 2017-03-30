package utils

import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Container
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Widget

abstract class LabeledWidget extends Panel{
	Label nombre

	new(Container container) {
		super(container)
		layout = new ColumnLayout(2)
		nombre = new Label(this)
		createWidget(this)
	}
	
	def void setNombre(String string){
		nombre.text = string
	}
	
	def Widget createWidget(LabeledWidget widget)
}