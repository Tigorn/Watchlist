import UIKit

protocol CurrencyEditDataSourceInputProtocol: class {
    func set(currencySymbols: [String])
}

protocol CurrencyEditDataSourceOutputProtocol: class {
    func moveRowAt(sourceIndexPath: IndexPath, destinationIndexPath: IndexPath)
    func delete(rowAt indexPath: IndexPath)
}

class CurrencyEditDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    private var currencySymbols = [String]()
    weak var listener: CurrencyEditDataSourceOutputProtocol?

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return currencySymbols.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: .currencyEditCell) as? CurrencyEditTableViewCell else {
            fatalError("Failed to dequeue cell with identifier: \(TableViewCellIdentifier.currencyEditCell.rawValue)")
        }

        let symbol = currencySymbols[indexPath.row]
        cell.set(name: symbol)
        return cell
    }

    func tableView(_: UITableView, canMoveRowAt _: IndexPath) -> Bool {
        return true
    }

    func tableView(_: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        listener?.moveRowAt(sourceIndexPath: sourceIndexPath, destinationIndexPath: destinationIndexPath)
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
    func set(currencySymbols: [String]) {
        self.currencySymbols = currencySymbols
    }
}
