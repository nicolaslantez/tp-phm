import org.uqbar.arena.Application
import org.uqbar.arena.windows.Window
import windows.LoginWindow

class POIApplication extends Application {

	new(POIBootstrap bootstrap) {
		super(bootstrap)
	}

	static def void main(String[] args) {
		new POIApplication(new POIBootstrap).start()
	}

	override protected Window<?> createMainWindow() {
		new LoginWindow(this)
	}
}
