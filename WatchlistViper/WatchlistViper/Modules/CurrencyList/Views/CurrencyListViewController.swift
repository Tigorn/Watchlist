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

    @IBOutlet var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.hidesWhenStopped = true
            activityIndicator.startAnimating()
        }
    }

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

    private func hideRefreshingUI() {
        tableView.refreshControl?.endRefreshing()
        activityIndicator.stopAnimating()
    }
}

extension CurrencyListViewController: CurrencyListViewInputProtocol {
    func requestFailed() {
        hideRefreshingUI()
    }

    func show(data: CurrencyListCurrencyDisplayData) {
        dataSource?.set(data: data)
        tableView.reloadData()
        hideRefreshingUI()
    }
}
