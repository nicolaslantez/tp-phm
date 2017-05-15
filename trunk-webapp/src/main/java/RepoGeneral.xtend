import java.util.List

interface RepoGeneral<T> {
	
	def List<T> searchByExample(T t) 
	
	def void saveOrUpdate(T t)
	
	def void delete(T t)
	
	def abstract Class<T> getEntityType()
}