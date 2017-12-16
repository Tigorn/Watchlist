import UIKit
import Domain

protocol CurrencyListViewInputProtocol: class {
    func show(currencies: [Currency])
    func requestFailed()
}

protocol CurrencyListViewOutputProtocol: class {
    func getCurrencies()
    func didEditAction()
}

class CurrencyListViewController: UIViewController {
    var listener: CurrencyListViewOutputProtocol?
    var dataSource: (CurrencyListDataSourceProtocol & UITableViewDelegate & UITableViewDataSource)?
    
    @IBOutlet weak var tableView: UITableView! {
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

    @IBAction func didEditAction(_ sender: Any) {
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

    func show(currencies: [Currency]) {
        tableView.refreshControl?.endRefreshing()
        dataSource?.set(currencies: currencies)
        tableView.reloadData()
    }
}
