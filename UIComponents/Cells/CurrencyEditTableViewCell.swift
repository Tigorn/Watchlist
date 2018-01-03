import UIKit

public protocol CurrencyEditTableViewCellProtocol {
    func set(item: CurrencyEditListItem)
}

public class CurrencyEditTableViewCell: UITableViewCell, CurrencyEditTableViewCellProtocol {
    @IBOutlet private var nameLabel: UILabel!

    public func set(item: CurrencyEditListItem) {
        nameLabel.text = item.name
    }
}
