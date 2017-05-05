package poi

import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Entity
import org.uqbar.commons.utils.Observable
import org.bson.types.ObjectId

@Observable
@Accessors
@Entity(value="Opinion")
class Opinion {
	
	new(int calif, String coment, String user, Long  _poi){
		this.calificacion = calif
		this.comentario = coment
		this.usuarioOpinador = user
		this.idPoi = _poi
	}
	
	new(){}
	
	@Id ObjectId id
	
	int calificacion
	
	String comentario
	
	String usuarioOpinador
	
	Long idPoi
}
