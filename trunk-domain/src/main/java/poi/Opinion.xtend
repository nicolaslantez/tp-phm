package poi

import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import org.bson.types.ObjectId

@Observable
@Accessors
@Entity
@org.mongodb.morphia.annotations.Entity(value = "Opiniones")
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
	
	@org.mongodb.morphia.annotations.Id ObjectId identificador
	
	@org.mongodb.morphia.annotations.Property
	@Column ( length = 1)
	int calificacion
	
	@org.mongodb.morphia.annotations.Property
	@Column ( length  = 250) 
	String comentario
	
	@org.mongodb.morphia.annotations.Property
	@Column ( length = 50 )
	String usuarioOpinador
	
	@org.mongodb.morphia.annotations.Property
	@Column
	Long idPoi
}
