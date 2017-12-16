import UIKit

protocol CurrencyListRouterProtocol: class {
    func showEdit(from view: UIViewController)
}

class CurrencyListRouter: CurrencyListRouterProtocol {
    func showEdit(from view: UIViewController) {
        let destination = CurrencyEditBuilder().makeModule()
        view.show(destination, sender: nil)
    }
}
