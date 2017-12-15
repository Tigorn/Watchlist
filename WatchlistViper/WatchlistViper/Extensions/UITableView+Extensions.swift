import UIKit

enum TableViewCellIdentifier: String {
    case currencyListCell = "CurrencyListTableViewCell"
    case currencyEditCell = "CurrencyEditTableViewCell"
}

extension UITableView {
    func dequeueReusableCell(withIdentifier identifier: TableViewCellIdentifier) -> UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: identifier.rawValue) else {
            fatalError("TableView has no registered cell with identifier: \(identifier.rawValue)")
        }

        return cell
    }

    func register(_ nib: UINib?, forCellReuseIdentifier identifier: TableViewCellIdentifier) {
        register(nib, forCellReuseIdentifier: identifier.rawValue)
    }
}
