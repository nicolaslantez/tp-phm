import java.util.List
import java.util.Map

interface RepoGeneral<T> {
	
	Map<String, Class> guardarEn
	
	val static baseDeDatos = null
	
	def List<T> searchByExample(T t) 
	
	def void saveOrUpdate(T t)
	
	def void delete(T t)
	
	def abstract Class<T> getEntityType()
}