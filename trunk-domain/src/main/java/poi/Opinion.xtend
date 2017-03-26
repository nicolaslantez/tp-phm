package poi

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class Opinion {
	int calificacion
	String comentario
	String usuarioOpinador
}
