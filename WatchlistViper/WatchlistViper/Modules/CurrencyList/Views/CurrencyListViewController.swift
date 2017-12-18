import Domain
import UIKit

protocol CurrencyListViewInputProtocol: class {
    func show(data: CurrencyListCurrencyDisplayData)
    func requestFailed()
}

protocol CurrencyListViewOutputProtocol: class {
    func getCurrencies()
    func didEditAction()
}

class CurrencyListViewController: UIViewController {
    var listener: CurrencyListViewOutputProtocol?
    var dataSource: (CurrencyListDataSourceInputProtocol & UITableViewDelegate & UITableViewDataSource)?

    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.dataSource = dataSource
            tableView.delegate = dataSource
            tableView.tableFooterView = UIView()

            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
            tableView.refreshControl = refreshControl

            registerCells()
        }
    }

    @IBAction func didEditAction(_: Any) {
        listener?.didEditAction()
    }

    func registerCells() {
        let currencyListNib = UINib(nibName: .currencyListCell, bundle: Bundle.viper)
        tableView.register(currencyListNib, forCellReuseIdentifier: .currencyListCell)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        listener?.getCurrencies()
    }

    @objc func refresh() {
        listener?.getCurrencies()
    }
}

extension CurrencyListViewController: CurrencyListViewInputProtocol {
    func requestFailed() {
        tableView.refreshControl?.endRefreshing()
    }

    func show(data: CurrencyListCurrencyDisplayData) {
        tableView.refreshControl?.endRefreshing()
        dataSource?.set(data: data)
        tableView.reloadData()
    }
}
