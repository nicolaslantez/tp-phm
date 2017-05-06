package busqueda

import org.joda.time.LocalTime
import org.uqbar.commons.utils.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Id
import org.mongodb.morphia.annotations.Property
import org.bson.types.ObjectId
import org.mongodb.morphia.annotations.Embedded

@Observable
@Accessors
@Entity(value="Log")
class Log {
	
	@Id ObjectId id
	
	@Property("fechaLogin")
	var LocalTime fecha
	
	@Embedded
	@Property("Usuario")
	var Usuario usuario
	
	@Property("Estado")
	var Boolean estado
}