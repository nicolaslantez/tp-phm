package interfacesExternas

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

interface CGPService {
	def List<CentroDTO> getCGPsByCalleOBarrio(String calleOBarrio)
}

@Accessors
class CentroDTO {
	int numeroComuna
	double coordenadaX
	double coordenadaY
	String zonasIncluidas
	String nombreDirector
	String domicilio
	String telefono
	List<ServicioDTO> serviciosDTO
}

@Accessors
class ServicioDTO {
	String nombreServicio
	List<RangoServicioDTO> rangosServicioDTO
}

@Accessors
class RangoServicioDTO {
	int numeroDia
	int horarioDesde
	int minutosDesde
	int horarioHasta
	int minutosHasta
}
