package poi

import javax.persistence.Entity
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.Column

@Observable
@Accessors
@Entity
class Opinion {
	
	@Id
	@GeneratedValue
	private Long id
	
	@Column ( length = 1 )
	int calificacion
	
	@Column ( length  = 250 ) 
	String comentario
	
	@Column ( length = 50 )
	String usuarioOpinador
}
