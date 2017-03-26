package adapters

import java.util.List
import poi.Local

final class AdapterLocal {

	private new() {}

	def static List<Local> toListaLocales(List<String> listaStrings) {
		listaStrings.map[toLocal]
	}

	def static Local toLocal(String string) {
		val localAux = new Local

		val partes = string.split(";").iterator

		localAux.nombre = partes.next

		val palabras = partes.next.split(" ").iterator
		palabras.forEach[s|localAux.palabrasClave.add(s)]

		localAux
	}
}
