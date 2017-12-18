import UIKit

protocol CurrencyListTableViewCellProtocol: class {
    func set(item: CurrencyListCurrencyDisplayItem)
}

class CurrencyListTableViewCell: UITableViewCell {
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var priceLabel: UILabel!

    private static let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = ""
        return numberFormatter
    }()

    override func prepareForReuse() {
        nameLabel.text = nil
        priceLabel.text = nil
    }
}

extension CurrencyListTableViewCell: CurrencyListTableViewCellProtocol {
    func set(item: CurrencyListCurrencyDisplayItem) {
        nameLabel.text = item.name
        priceLabel.text = CurrencyListTableViewCell.numberFormatter.string(from: item.lastPrice)
    }
}
