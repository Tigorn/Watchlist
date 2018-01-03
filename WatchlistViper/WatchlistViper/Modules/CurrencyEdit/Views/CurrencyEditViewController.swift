import UIKit
import UIComponents

protocol CurrencyEditViewOutputProtocol: class {
    func getCurrencies()
}

protocol CurrencyEditViewInputProtocol: class {
    func set(data: CurrencyEditListData)
}

class CurrencyEditViewController: UIViewController {
    var listener: CurrencyEditViewOutputProtocol?
    var dataSource: (CurrencyEditDataSourceInputProtocol & UITableViewDelegate & UITableViewDataSource)?

    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
            tableView.dataSource = dataSource
            tableView.delegate = dataSource
            tableView.setEditing(true, animated: true)
            registerCells()
        }
    }

    func registerCells() {
        let currencyListNib = UINib(nibName: .currencyEditCell)
        tableView.register(currencyListNib, forCellReuseIdentifier: .currencyEditCell)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        listener?.getCurrencies()
    }
}

extension CurrencyEditViewController: CurrencyEditViewInputProtocol {
    func set(data: CurrencyEditListData) {
        dataSource?.set(data: data)
        tableView.reloadData()
    }
}

extension CurrencyEditViewController: CurrencyEditDataSourceOutputProtocol {
    func delete(rowAt indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
