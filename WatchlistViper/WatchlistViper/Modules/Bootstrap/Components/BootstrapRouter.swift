import UIKit

protocol BootstrapRouterInputProtocol: class {
    func setRootviewController(window: UIWindow)
    func makeWindowKeyAndVisible(window: UIWindow)
    func showLoading(from viewController: UIViewController)
    func dismissLoading()
}

class BootstrapRouter {
    var presentedViewController: UIViewController?
    var builder: BootstrapBuilderProtocol?
}

extension BootstrapRouter: BootstrapRouterInputProtocol {
    func setRootviewController(window: UIWindow) {
        if let rootViewController = builder?.makeRootViewController() {
            window.rootViewController = rootViewController
        }
    }

    func makeWindowKeyAndVisible(window: UIWindow) {
        window.makeKeyAndVisible()
    }

    func dismissLoading() {
        presentedViewController?.dismiss(animated: true, completion: nil)
    }

    func showLoading(from viewController: UIViewController) {
        if let loadingViewController = builder?.makeLoadingViewController() {
            viewController.present(loadingViewController, animated: false, completion: nil)
            presentedViewController = loadingViewController
        }
    }
}
