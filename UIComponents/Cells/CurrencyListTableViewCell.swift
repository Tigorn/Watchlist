import UIKit
//import FoundationComponents

public protocol CurrencyListTableViewCellProtocol: class {
    func set(item: CurrencyListCurrencyDisplayItem)
}

public class CurrencyListTableViewCell: UITableViewCell {
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var priceLabel: UILabel!

    private static let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = ""
        return numberFormatter
    }()

    override public func prepareForReuse() {
        nameLabel.text = nil
        priceLabel.text = nil
    }
}

extension CurrencyListTableViewCell: CurrencyListTableViewCellProtocol {
    public func set(item: CurrencyListCurrencyDisplayItem) {
        nameLabel.text = item.name
        priceLabel.text = CurrencyListTableViewCell.numberFormatter.string(from: item.lastPrice)
    }
}
