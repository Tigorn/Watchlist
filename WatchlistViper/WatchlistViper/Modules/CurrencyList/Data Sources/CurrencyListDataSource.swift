import UIKit
import Domain

class CurrencyListDataSource: NSObject, UITableViewDataSource, UITableViewDelegate, CurrencyListDataSourceProtocol {
    private var currencies = [Currency]()

    func set(currencies: [Currency]) {
        self.currencies = currencies
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
