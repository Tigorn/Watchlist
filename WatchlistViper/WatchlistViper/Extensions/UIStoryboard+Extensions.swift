import UIKit

enum UIViewControllerIdentifier: String {
    case currencyListViewController = "CurrencyListViewController"
    case currencyEditViewController = "CurrencyEditViewController"
    case loadingViewController = "LoadingViewController"
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

    static var bootstrap: UIStoryboard {
        return UIStoryboard(name: "Bootstrap", bundle: Bundle.viper)
    }
}
