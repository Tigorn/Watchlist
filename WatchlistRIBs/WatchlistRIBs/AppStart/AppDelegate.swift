import RIBs
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        launchRouter = RootBuilder(dependency: AppComponent()).build()
        launchRouter?.launchFromWindow(window)
        self.window = window
        return true
    }

    // MARK: - Private

    private var launchRouter: LaunchRouting?
}
