package busqueda

import creacionales.ServiceLocator
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import poi.Banco
import poi.CGP
import poi.POI

import static extension adapters.AdapterBanco.*
import static extension adapters.AdapterCGP.*
import interfacesExternas.CentroDTO

@Observable
@Accessors
class Repositorio {
	List<POI> listaPois = newArrayList

	def boolean esValido(POI poi) {
		!listaPois.contains(poi)
	}

	def void crear(POI poi) {
		if (poi.esValido)
			listaPois.add(poi)
	}

	def void borrar(POI poi) {
		listaPois.remove(poi)
	}

	def void actualizar(POI poi) {
		if (listaPois.contains(poi)) {
			val posicion = listaPois.indexOf(poi)
			listaPois.remove(poi)
			listaPois.add(posicion, poi)
		} else
			throw new Exception("El objeto no existe!")
	}

	def POI buscarPorID(int idBuscado) {
		listaPois.get(idBuscado)
	}

	def List<POI> buscar(String valor) {
		( buscarLista(valor) + buscarServicioBanco(valor) + buscarServicioCGP(valor) ).toList
	}

	def POI buscarUnPOI(String string) {
		val resultados = buscarLista(string)
		if(resultados.size() == 1) resultados.get(0)
	}

	def List<POI> buscarLista(String string) {
		listaPois.filter[coincideBusqueda(string)].toList
	}

	def List<Banco> buscarServicioBanco(String valor) {
		try {
			val json = ServiceLocator.instance.servicioBanco.getSucursalesBancosByNombreBanco(valor)
			json.toListaBancos
		} catch (Exception e)
			newArrayList
	}

	def List<CGP> buscarServicioCGP(String valor) {
		try {
			val listaDTO = ServiceLocator.instance.servicioCGP.getCGPsByCalleOBarrio(valor)
			listaDTO.toListaCGPs
		} catch (Exception e)
			newArrayList
	}
	
}
