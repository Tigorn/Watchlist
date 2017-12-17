import Domain
import UIKit

protocol CurrencyListDataSourceProtocol: class {
    func set(currencies: [Currency])
}

class CurrencyListDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    fileprivate var currencies = [Currency]()

    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return currencies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .currencyListCell) as! CurrencyListTableViewCell
        let currency = currencies[indexPath.row]
        cell.set(name: currency.symbol)
        cell.set(volume: currency.volume)
        cell.set(priceChange: currency.priceChange)
        cell.set(percentChange: currency.percentChange)
        cell.set(lastPrice: currency.lastPrice)
        return cell
    }
}

extension CurrencyListDataSource: CurrencyListDataSourceProtocol {
    func set(currencies: [Currency]) {
        self.currencies = currencies
    }
}
