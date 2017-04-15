import busqueda.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.hibernate.Criteria
import org.hibernate.FetchMode
import org.hibernate.HibernateException
import org.hibernate.criterion.Restrictions

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

	override addQueryByExample(Criteria criteria, Usuario usuario) {
		if (usuario.nombre != null) {
			criteria.add(Restrictions.eq("nombre", usuario.nombre))
		}
	}

	def Usuario searchByName(String nombre) {
		val session = openSession
		try {
			session.createCriteria(Usuario)
				.setFetchMode("usuarios", FetchMode.JOIN)
				.add(Restrictions.eq("nombre", nombre)).
				uniqueResult as Usuario
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}

}
