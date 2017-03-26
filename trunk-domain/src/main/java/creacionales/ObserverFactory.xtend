package creacionales

import java.util.Map
import observers.busqueda.ActivarMetricas
import observers.busqueda.BusquedaObserver
import observers.busqueda.InfoResultados
import observers.busqueda.NotificarDemora

final class ObserverFactory {
	static ActivarMetricas activarMetricas = new ActivarMetricas
	static InfoResultados infoResultados = new InfoResultados
	static NotificarDemora notificarDemora = new NotificarDemora

	static Map<String, BusquedaObserver> observerBusqueda = newHashMap("Info" -> infoResultados,
		"Metricas" -> activarMetricas, "Notificar Demora" -> notificarDemora)
	
	private new(){}
	
	def static BusquedaObserver toObserver(String string) {
		observerBusqueda.get(string)
	}

	def static void setTiempoMaximo(double numero) {
		notificarDemora.tiempoMaximo = numero
	}
}
