import UIKit

protocol CurrencyEditDataSourceInputProtocol: class {
    func set(data: CurrencyEditListData)
}

protocol CurrencyEditDataSourceOutputProtocol: class {
    func delete(rowAt indexPath: IndexPath)
}

class CurrencyEditDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    private var data: CurrencyEditListData?
    weak var listener: CurrencyEditDataSourceOutputProtocol?

    func numberOfSections(in _: UITableView) -> Int {
        return data?.sectionCount ?? 0
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.itemCount(inSection: section) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = TableViewCellIdentifier.currencyEditCell

        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? UITableViewCell & CurrencyEditTableViewCellProtocol else {
            fatalError("Failed to dequeue cell with identifier: \(identifier.rawValue)")
        }

        if let item = data?.itemAt(indexPath: indexPath) {
            cell.set(item: item)
        }

        return cell
    }

    func tableView(_: UITableView, canMoveRowAt _: IndexPath) -> Bool {
        return true
    }

    func tableView(_: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    }

    func tableView(_: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            listener?.delete(rowAt: indexPath)
        default:
            break
        }
    }
}

extension CurrencyEditDataSource: CurrencyEditDataSourceInputProtocol {
    func set(data: CurrencyEditListData) {
        self.data = data
    }
}
