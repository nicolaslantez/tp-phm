import java.util.List
import org.apache.commons.collections15.Predicate
import org.uqbar.commons.model.CollectionBasedRepo
import poi.POI

class RepoPOI extends CollectionBasedRepo<POI> {
	static RepoPOI repoPois

	def static RepoPOI getInstance() {
		if (repoPois == null)
			repoPois = new RepoPOI
		repoPois
	}

	private new() {}

	def List<POI> search(String string) {
		repoPois.allInstances.filter[coincideBusqueda(string)].toList
	}

	override protected Predicate<POI> getCriterio(POI example) { }

	override getEntityType() {typeof(POI) }

	override createExample() {}

}
