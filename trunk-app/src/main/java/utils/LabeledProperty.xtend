package utils

import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Container

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class LabeledProperty extends LabeledWidget {
	Label property

	new(Container container) {
		super(container)
	}

	def void setPropiedad(String string) {
		property.value <=> string
	}

	override createWidget(LabeledWidget widget) {
		property = new Label(widget)
		this
	}
}
