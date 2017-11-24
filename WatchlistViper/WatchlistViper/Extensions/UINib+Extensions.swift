import UIKit

enum NibIdentifier: String {
    case currencyListCell = "CurrencyListTableViewCell"
    case currencyEditCell = "CurrencyEditTableViewCell"
}

extension UINib {
    convenience init(nibName name: NibIdentifier, bundle: Bundle?) {
        self.init(nibName: name.rawValue, bundle: bundle)
    }
}
