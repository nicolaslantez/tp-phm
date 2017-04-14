package poi

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
@Entity
class Opinion {
	
	new(int calif, String coment, String user, Long  _poi){
		this.calificacion = calif
		this.comentario = coment
		this.usuarioOpinador = user
		this.idPoi = _poi
	}
	
	new(){}

	@Id
	@GeneratedValue
	private Long id
	
	@Column ( length = 1)
	int calificacion
	
	@Column ( length  = 250) 
	String comentario
	
	@Column ( length = 50 )
	String usuarioOpinador
	
//	@ManyToOne(fetch = FetchType.EAGER)
		@Column
		Long idPoi
}
