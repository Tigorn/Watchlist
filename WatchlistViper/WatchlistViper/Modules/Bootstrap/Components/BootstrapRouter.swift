import UIKit

protocol BootstrapRouterProtocol: class {
    func rootViewController() -> UIViewController
}

class BootstrapRouter: BootstrapRouterProtocol {
    func rootViewController() -> UIViewController {
        let tabBarController = UITabBarController()
        let currencyListViewController = UINavigationController(rootViewController: CurrencyListBuilder().makeModule())
        tabBarController.viewControllers = [currencyListViewController]
        return tabBarController
    }
}
