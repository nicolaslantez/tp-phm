package poi

import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Id
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
@Entity
class Opinion {
	
	new(int calif, String coment, String user, ObjectId  _poi){
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
		
	ObjectId idPoi
}
