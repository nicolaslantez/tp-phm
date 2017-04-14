package poi.utils;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Pure;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.uqbar.geodds.NumberUtils;

/**
 * Define una zona conformada por vÃ©rtices (un conjunto de puntos)<br>
 * <br>
 * <b>Importante:</b> cuando se define una zona no hay que definir el vÃ©rtice
 * final igual al inicial<br>
 * <br>
 * 
 * @author DDS
 */
@Entity
@Accessors
@SuppressWarnings("all")
public class Poligono {
	@Id
	@GeneratedValue
	private Long id;
	
	@OneToMany(cascade=CascadeType.ALL)
	@LazyCollection(LazyCollectionOption.FALSE)
	protected List<Punto> surface;

	/**
	 * Constructor default, obliga luego a agregar los puntos manualmente
	 * mediante el mensaje add(Point point). <br>
	 * <br>
	 * Para trabajar con un polÃ­gono inmutable, no debe usarse este constructor
	 * ni el add posterior.<br>
	 */
	public Poligono() {
		ArrayList<Punto> _arrayList = new ArrayList<Punto>();
		this.surface = _arrayList;
	}

	public boolean add(final Punto point) {
		return this.surface.add(point);
	}

	/**
	 * Constructor que le pasa un conjunto de puntos que definen el polÃ­gono
	 */
	public Poligono(final List<Punto> points) {
		this.surface = points;
	}

	/**
	 * Convierte un punto a un polÃ­gono conformado inicialmente por este punto.
	 * <br>
	 * No compatible con la idea de un polÃ­gono inmutable.<br>
	 */
	public static Poligono asPolygon(final Punto point) {
		return new Poligono(
				((List<Punto>) Collections.<Punto>unmodifiableList(CollectionLiterals.<Punto>newArrayList(point))));
	}

	/**
	 * Determina si un punto estÃ¡ dentro de un polÃ­gono Para la explicaciÃ³n
	 * vÃ©ase http://erich.realtimerendering.com/ptinpoly/
	 * 
	 * @Deprecated Usar isInside
	 */
	public boolean isInsideOld(final Punto point) {
		boolean _xblockexpression = false;
		{
			int counter = 0;
			Punto point1 = this.surface.get(0);
			final int N = this.surface.size();
			for (int i = 1; (i <= N); i++) {
				{
					Punto point2 = this.surface.get((i % N));
					boolean _intersects = point.intersects(point1, point2);
					if (_intersects) {
						counter++;
					}
					point1 = point2;
				}
			}
			_xblockexpression = NumberUtils.even(counter);
		}
		return _xblockexpression;
	}

	/**
	 * FunciÃ³n mejorada para determinar si un punto estÃ¡ en el polÃ­gono
	 */
	public boolean isInside(final Punto point) {
		boolean _xblockexpression = false;
		{
			final int N = this.surface.size();
			int j = (N - 1);
			boolean oddNodes = false;
			double x = point.longitude();
			double y = point.latitude();
			for (int i = 0; (i < N); i++) {
				{
					Punto _get = this.surface.get(i);
					final double verticeIY = _get.latitude();
					Punto _get_1 = this.surface.get(i);
					final double verticeIX = _get_1.longitude();
					Punto _get_2 = this.surface.get(j);
					final double verticeJY = _get_2.latitude();
					Punto _get_3 = this.surface.get(j);
					final double verticeJX = _get_3.longitude();
					if (((((verticeIY < y) && (verticeJY >= y)) || ((verticeJY < y) && (verticeIY >= y)))
							&& ((verticeIX <= x) || (verticeJX <= x)))) {
						if (((verticeIX
								+ (((y - verticeIY) / (verticeJY - verticeIY)) * (verticeJX - verticeIX))) < x)) {
							oddNodes = (!oddNodes);
						}
					}
					j = i;
				}
			}
			_xblockexpression = oddNodes;
		}
		return _xblockexpression;
	}

	/**
	 * Indica si un punto es alguno de los vÃ©rtices del polÃ­gono
	 */
	public boolean pointOnVertex(final Punto point) {
		return this.surface.contains(point);
	}

	@Pure
	public List<Punto> getSurface() {
		return this.surface;
	}

	public void setSurface(final List<Punto> surface) {
		this.surface = surface;
	}
}
