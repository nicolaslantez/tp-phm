import com.fasterxml.jackson.core.type.TypeReference
import com.fasterxml.jackson.databind.ObjectMapper
import java.util.HashMap
import java.util.Map

class JSONPropertyUtils {

	def String getPropertyValue(String json, String property) {
		val properties = new ObjectMapper().readValue(json,
			new TypeReference<HashMap<String, String>>() {
			})
		(properties as Map<String, String>).get(property)
	}

}
