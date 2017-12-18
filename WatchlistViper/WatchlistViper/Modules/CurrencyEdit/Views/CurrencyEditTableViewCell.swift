import UIKit

protocol CurrencyEditTableViewCellProtocol {
    func set(item: CurrencyEditListItem)
}

class CurrencyEditTableViewCell: UITableViewCell, CurrencyEditTableViewCellProtocol {
    @IBOutlet private var nameLabel: UILabel!

    func set(item: CurrencyEditListItem) {
        nameLabel.text = item.name
    }
}
