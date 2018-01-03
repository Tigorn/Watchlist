import UIKit

public enum NibIdentifier: String {
    case currencyListCell = "CurrencyListTableViewCell"
    case currencyEditCell = "CurrencyEditTableViewCell"
}

extension UINib {
    public convenience init(nibName name: NibIdentifier) {
        self.init(nibName: name.rawValue, bundle: Bundle.UIComponents)
    }
}
