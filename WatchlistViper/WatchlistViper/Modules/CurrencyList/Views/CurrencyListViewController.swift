import UIKit
import Domain

class CurrencyListViewController: UIViewController {
    var presenter: CurrencyListPresenterProtocol?
    var dataSource: CurrencyListDataSourceProtocol & UITableViewDelegate & UITableViewDataSource = CurrencyListDataSource()
    
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
        presenter?.didEditAction()
    }

    func registerCells() {
        let currencyListNib = UINib(nibName: .currencyListCell, bundle: Bundle.viper)
        tableView.register(currencyListNib, forCellReuseIdentifier: .currencyListCell)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.getCurrencies()
    }

    @objc func refresh() {
        presenter?.getCurrencies()
    }
}

extension CurrencyListViewController: CurrencyListViewProtocol {
    func requestFailed() {
        tableView.refreshControl?.endRefreshing()
    }

    func show(currencies: [Currency]) {
        tableView.refreshControl?.endRefreshing()
        dataSource.set(currencies: currencies)
        tableView.reloadData()
    }
}
