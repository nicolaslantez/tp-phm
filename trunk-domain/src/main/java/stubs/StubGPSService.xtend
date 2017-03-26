package stubs

import interfacesExternas.GPSService
import busqueda.Usuario
import org.uqbar.geodds.Point
import java.util.Map

class StubGPSService implements GPSService{
	Map<Usuario,Point> mapaUbicaciones = newHashMap
	
	override getUbicacion(Usuario usuario) {
		mapaUbicaciones.get(usuario)
	}
	
	override addUsuario(Usuario usuario, Point punto){
		mapaUbicaciones.put(usuario, punto)
	}
	
}