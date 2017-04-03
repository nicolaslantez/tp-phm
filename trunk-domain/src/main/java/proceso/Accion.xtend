package proceso

import busqueda.Usuario
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
abstract class Accion {
	String nombreObserver

	def void ejecutar(Set<Usuario> usuarios)

	def void undo(Set<Usuario> usuarios)
}

/*class AgregarObserver extends Accion {
	override ejecutar(Set<Usuario> usuarios) {
		usuarios.forEach[addObserver(nombreObserver)]
	}

	override undo(Set<Usuario> usuarios) {
		usuarios.forEach[removeObserver(nombreObserver)]
	}

}

class QuitarObserver extends Accion {
	override ejecutar(Set<Usuario> usuarios) {
		usuarios.forEach[removeObserver(nombreObserver)]
	}

	override undo(Set<Usuario> usuarios) {
		usuarios.forEach[addObserver(nombreObserver)]
	}

}
*/