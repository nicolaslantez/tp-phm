package stubs

import interfacesExternas.CGPService
import interfacesExternas.CentroDTO
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

import static extension poi.utils.POIUtils.*

@Accessors
class StubCGPService implements CGPService {
	List<CentroDTO> centros = newArrayList
	
	override getCGPsByCalleOBarrio(String string) {
		centros.filter[domicilio.comienzaCon(string) || zonasIncluidas.contains(string)].toList
	}
}
