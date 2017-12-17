import UIKit

class CurrencyEditTableViewCell: UITableViewCell {
    @IBOutlet private var nameLabel: UILabel!

    func set(name: String) {
        nameLabel.text = name
    }
}
