package busqueda

import java.util.Date
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Id
import org.mongodb.morphia.annotations.Property
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
@Entity(value="Log")
class Log {
	
	@Id ObjectId id
	
	@Property("fechaLogin")
	Date fecha
	
	//@Property("Usuario")
	Usuario usuario
	
	@Property("Estado")
	Boolean estado
}