import UIKit

enum UIViewControllerIdentifier: String {
    case currencyListViewController = "CurrencyListViewController"
    case currencyEditViewController = "CurrencyEditViewController"
}

extension UIStoryboard {
    func instantiateViewController(withIdentifier identifier: UIViewControllerIdentifier) -> UIViewController {
        return instantiateViewController(withIdentifier: identifier.rawValue)
    }

    static var list: UIStoryboard {
        return UIStoryboard(name: "List", bundle: Bundle.viper)
    }

    static var edit: UIStoryboard {
        return UIStoryboard(name: "Edit", bundle: Bundle.viper)
    }
}
