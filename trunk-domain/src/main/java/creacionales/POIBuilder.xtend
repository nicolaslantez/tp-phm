package creacionales

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
class POIBuilder {
	def banco() {
		new BancoBuilder
	}

	def cgp() {
		new CGPBuilder
	}

	def colectivo() {
		new ColectivoBuilder
	}

	def local() {
		new LocalBuilder
	}
}
