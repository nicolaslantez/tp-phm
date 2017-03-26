package interfacesExternas

import busqueda.Usuario
import org.uqbar.geodds.Point

interface GPSService {
	def Point getUbicacion(Usuario usuario)
	
	def void  addUsuario(Usuario usuario, Point punto)
}