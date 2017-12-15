import UIKit

class CurrencyEditTableViewCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!

    func set(name: String) {
        nameLabel.text = name
    }
}
