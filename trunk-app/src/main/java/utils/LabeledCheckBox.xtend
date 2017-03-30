package utils

import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.Container

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class LabeledCheckBox extends LabeledWidget {
	CheckBox property

	new(Container container) {
		super(container)
	}

	def void setValue(String string) {
		property.value <=> string
	}

	override createWidget(LabeledWidget widget) {
		property = new CheckBox(widget)
		this
	}
}
