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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencySymbols.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .currencyEditCell) as! CurrencyEditTableViewCell
        let symbol = currencySymbols[indexPath.row]
        cell.set(name: symbol)
        return cell
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        listener?.moveRowAt(sourceIndexPath: sourceIndexPath, destinationIndexPath: destinationIndexPath)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
