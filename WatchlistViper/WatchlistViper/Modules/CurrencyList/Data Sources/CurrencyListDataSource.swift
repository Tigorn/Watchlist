import Domain
import UIKit
import UIComponents

protocol CurrencyListDataSourceInputProtocol: class {
    func set(data: CurrencyListCurrencyDisplayData)
}

class CurrencyListDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    fileprivate var data: CurrencyListCurrencyDisplayData?

    func numberOfSections(in _: UITableView) -> Int {
        return data?.sectionCount ?? 0
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.itemCount(inSection: section) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = TableViewCellIdentifier.currencyListCell

        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? UITableViewCell & CurrencyListTableViewCellProtocol else {
            fatalError("Failed to dequeue cell with identifier: \(identifier.rawValue)")
        }

        if let item = data?.itemAt(indexPath: indexPath) {
            cell.set(item: item)
        }

        return cell
    }
}

extension CurrencyListDataSource: CurrencyListDataSourceInputProtocol {
    func set(data: CurrencyListCurrencyDisplayData) {
        self.data = data
    }
}
