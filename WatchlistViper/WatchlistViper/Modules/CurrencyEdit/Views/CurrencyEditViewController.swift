import UIKit

class CurrencyEditViewController: UIViewController {
    var presenter: CurrencyEditPresenterProtocol?
    
    lazy var dataSource: CurrencyEditDataSourceInputProtocol & UITableViewDelegate & UITableViewDataSource = {
        let dataSource = CurrencyEditDataSource()
        dataSource.outputHandler = self
        return dataSource
    }()

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
            tableView.dataSource = dataSource
            tableView.delegate = dataSource
            tableView.setEditing(true, animated: true)
            registerCells()
        }
    }

    func registerCells() {
        let currencyListNib = UINib(nibName: .currencyEditCell, bundle: Bundle.viper)
        tableView.register(currencyListNib, forCellReuseIdentifier: .currencyEditCell)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getCurrencies()
    }
}

extension CurrencyEditViewController: CurrencyEditViewProtocol {
    func set(currencySymbols: [String]) {
        dataSource.set(currencySymbols: currencySymbols)
        tableView.reloadData()
    }
}

extension CurrencyEditViewController: CurrencyEditDataSourceOutputProtocol {
    func delete(rowAt indexPath: IndexPath) {
        //TODO
    }

    func moveRowAt(sourceIndexPath: IndexPath, destinationIndexPath: IndexPath) {
        //TODO
    }
}
