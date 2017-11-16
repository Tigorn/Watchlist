import UIKit

class CurrencyListTableViewCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!

    private static let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = ""
        return numberFormatter
    }()

    func set(name: String?) {
        nameLabel.text = name
    }

    func set(percentChange: Double?) {

    }

    func set(priceChange: Double?) {
        
    }

    func set(volume: Double?) {

    }

    func set(lastPrice: Double?) {
        priceLabel.text = CurrencyListTableViewCell.numberFormatter.string(from: lastPrice)
    }
}
