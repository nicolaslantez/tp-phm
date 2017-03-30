package windows

import models.BusquedaModel
import models.LoginModel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.PasswordField
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import utils.DefaultButton

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import static extension utils.WindowUtils.*

class LoginWindow extends Dialog<LoginModel> {

	new(WindowOwner owner) {
		super(owner, new LoginModel)
		title= "Login"
		taskDescription = "Ingrese usuario y contraseña"
		iconImage = getIcono("login")
	}

	override protected createFormPanel(Panel mainPanel) {
		new Label(mainPanel).text = "Usuario"
		new TextBox(mainPanel) => [
			value <=> "nombreUsuario"
			fontSize = 12
		]

		new Label(mainPanel).text = "Contraseña"
		new PasswordField(mainPanel) => [
			value <=> "contrasenia"
			fontSize = 12
		]
	}

	override protected addActions(Panel actionsPanel) {
		new DefaultButton(actionsPanel) => [
			caption = "OK"
			onClick[
				modelObject.validarAcceso
				close
				new BusquedaWindow(this, new BusquedaModel(modelObject.usuario)).open
			]
			setAsDefault
		]

		new DefaultButton(actionsPanel) => [
			caption = "Cancelar"
			onClick[cancel]
		]
	}
}
