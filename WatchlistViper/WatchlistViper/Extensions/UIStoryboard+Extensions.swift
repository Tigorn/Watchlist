import UIKit

enum UIViewControllerIdentifier: String {
    case currencyListViewController = "CurrencyListViewController"
}

extension UIStoryboard {
    func instantiateViewController(withIdentifier identifier: UIViewControllerIdentifier) -> UIViewController {
        return instantiateViewController(withIdentifier: identifier.rawValue)
    }

    static var list: UIStoryboard {
        return UIStoryboard(name: "List", bundle: Bundle.viper)
    }
}
