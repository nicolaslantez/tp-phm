//package adapters
//
//import creacionales.CGPBuilder
//import creacionales.HorarioBuilder
//import creacionales.ServicioBuilder
//import interfacesExternas.CentroDTO
//import interfacesExternas.RangoServicioDTO
//import interfacesExternas.ServicioDTO
//import java.util.List
//import poi.CGP
//import poi.utils.Horario
//import poi.utils.Servicio
//
//final class AdapterCGP {
//		
//	private new(){}
//	
//	def static List<CGP> toListaCGPs(List<CentroDTO> listaCentros){
//		listaCentros.map[toCGP]
//	}
//	
//	def static CGP toCGP(CentroDTO centro) {
//		new CGPBuilder()
//			.servicios(centro.serviciosDTO.map[toServicio].toSet)
//			.comuna(centro.numeroComuna)
//			.domicilio(centro.domicilio)
//			.build
//	}
//
//	def static Servicio toServicio(ServicioDTO servicioDTO) {
//		new ServicioBuilder()
//			.nombre(servicioDTO.nombreServicio)
//			.horario(servicioDTO.rangosServicioDTO.toHorario)
//			.build
//	}
//
//	def static Horario toHorario(List<RangoServicioDTO> rangosDTO) {
//		var horarioCGP = new HorarioBuilder
//		for (rango : rangosDTO)
//			horarioCGP.dia(rango.numeroDia,
//					 	   rango.horarioDesde, 
//						   rango.minutosDesde, 
//					 	   rango.horarioHasta,
//					 	   rango.minutosHasta)
//		horarioCGP.build
//	}
//}
