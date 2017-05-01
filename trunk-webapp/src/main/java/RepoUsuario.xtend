import busqueda.Usuario
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class RepoUsuario extends RepoDefault<Usuario> {
	
	static RepoUsuario repoUsuarios
	Usuario usuarioActivo

	def static RepoUsuario getInstance() {
		if (repoUsuarios == null) {
			repoUsuarios = new RepoUsuario()
		}
		return repoUsuarios
	}


	override getEntityType() {
		typeof(Usuario)
	}
	
	def createWhenNew(Usuario usuario) {
		if (searchByExample(usuario).isEmpty) {
			this.create(usuario)
		}
	}
	
	override searchByExample(Usuario usuario) {
		ds.createQuery(entityType)
			.field("nombre").equal(usuario.nombre)
			.asList
	}
	
	def Usuario searchByName(String nombre) {
		ds.createQuery(entityType)
			.field("nombre").equal(nombre)
			as Usuario
	}
	

	
	override defineUpdateOperations(Usuario usuario) {
		ds.createUpdateOperations(entityType)
			.set("nombre", usuario.nombre)
			.set("contrasenia", usuario.contrasenia)
			.set("ubicacion", usuario.ubicacion)
			.set("listaFavoritos", usuario.listaFavoritos)
	}

}