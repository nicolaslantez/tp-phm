package creacionales

import busqueda.Admin
import busqueda.Busqueda
import busqueda.Metricas
import busqueda.Repositorio
import busqueda.Usuario
import interfacesExternas.BancoService
import interfacesExternas.CGPService
import interfacesExternas.RESTService
import java.util.List
import java.util.Set
import org.eclipse.xtend.lib.annotations.Accessors
import proceso.ResultadoProceso
import interfacesExternas.GPSService

@Accessors
class ServiceLocator {
	Admin adminDeBusquedas
	Metricas metricas
	Repositorio repositorio = new Repositorio
	GPSService gps
	
	List<ResultadoProceso> informes = newArrayList
	Set<Usuario> usuarios = newHashSet
		
	BancoService servicioBanco
	CGPService servicioCGP
	RESTService servicioREST
	Busqueda servicioBusqueda = new Busqueda

	static ServiceLocator instance

	private new() {}

	def static getInstance() {
		if (instance == null)
			instance = new ServiceLocator
		instance
	}
}
