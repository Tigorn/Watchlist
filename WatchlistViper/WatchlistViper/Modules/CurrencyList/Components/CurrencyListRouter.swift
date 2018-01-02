import UIKit

protocol CurrencyListRouterProtocol: class {
    func routeToEdit(from view: UIViewController)
}

class CurrencyListRouter: CurrencyListRouterProtocol {
    func routeToEdit(from view: UIViewController) {
        let destination = CurrencyEditBuilder().makeModule()
        view.show(destination, sender: nil)
    }
}
