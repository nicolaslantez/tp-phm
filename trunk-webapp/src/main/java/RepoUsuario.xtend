import busqueda.Usuario
import org.apache.commons.collections15.Predicate
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.CollectionBasedRepo

@Accessors
class RepoUsuario extends CollectionBasedRepo<Usuario> {
	static RepoUsuario repoUsuarios
	Usuario usuarioActivo

	def static RepoUsuario getInstance() {
		if (repoUsuarios == null) {
			repoUsuarios = new RepoUsuario
		}
		repoUsuarios
	}

	private new() {	}

	override createExample() {
		new Usuario
	}

	override getEntityType() {
		typeof(Usuario)
	}

	override protected Predicate<Usuario> getCriterio(Usuario example) {
		new Predicate<Usuario> {

			override evaluate(Usuario usuario) {
				usuario.nombre.contains(example.nombre)
			}

		}
	}

}
