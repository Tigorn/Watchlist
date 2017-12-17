import UIKit

class CurrencyListTableViewCell: UITableViewCell {
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var priceLabel: UILabel!

    private static let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = ""
        return numberFormatter
    }()

    func set(name: String?) {
        nameLabel.text = name
    }

    func set(percentChange _: Double?) {
    }

    func set(priceChange _: Double?) {
    }

    func set(volume _: Double?) {
    }

    func set(lastPrice: Double?) {
        priceLabel.text = CurrencyListTableViewCell.numberFormatter.string(from: lastPrice)
    }
}
