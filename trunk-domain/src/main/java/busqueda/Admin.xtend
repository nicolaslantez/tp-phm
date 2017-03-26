package busqueda

import java.util.List
import observers.proceso.ProcesoObserver
import org.eclipse.xtend.lib.annotations.Accessors
import proceso.Proceso

@Accessors
class Admin {
	List<ProcesoObserver> funciones = newArrayList
	List<String> mailsRecibidos = newArrayList

	def boolean recibioMail(String string) {
		mailsRecibidos.contains(string)
	}

	def void recibirMail(String mail) {
		mailsRecibidos.add(mail)
	}

	def void ejecutar(Proceso proceso) {
		proceso.ejecutar(this)
		if(!proceso.finalizoOK) funciones.forEach[ejecutar(proceso,this)]
	}

	def void addFuncion(ProcesoObserver observer) {
		funciones.add(observer)
	}
}
