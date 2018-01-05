import RIBs
import RxSwift
import UIKit
import SnapKit
import UIComponents

protocol ListPresentableListener: class {
    func refreshCurrencyList()
    func editCurrencySymbolList()
    func addCurrencySymbol()
}

final class ListViewController: UIViewController, ListPresentable {
    weak var listener: ListPresentableListener?

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        addTableViewConstraints()
        addActivityIndicatorConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCurrencySymbol))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editCurrencySymbolList))
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicator.startAnimating()
        refresh()
    }

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()

    //MARK: - ListPresentable

    func requestFailed() {
        endRefreshUI()
    }

    func show(data: CurrencyListCurrencyDisplayData) {
        endRefreshUI()
        self.data = data
        tableView.reloadData()
    }

    //MARK: - Private

    private var data = CurrencyListCurrencyDisplayData()
    private let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.refreshControl = self.refreshControl
        return tableView
    }()

    private func endRefreshUI() {
        activityIndicator.stopAnimating()
        refreshControl.endRefreshing()
    }

    private func addTableViewConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }

    private func addActivityIndicatorConstraints() {
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { maker in
            maker.center.equalToSuperview()
        }
    }

    @objc private func refresh() {
        listener?.refreshCurrencyList()
    }

    @objc private func addCurrencySymbol() {
        listener?.addCurrencySymbol()
    }

    @objc private func editCurrencySymbolList() {
        listener?.editCurrencySymbolList()
    }

    private func registerCells() {
        let currencyListNib = UINib(nibName: .currencyListCell)
        tableView.register(currencyListNib, forCellReuseIdentifier: .currencyListCell)
    }
}

extension ListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.sectionCount
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.itemCount(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = TableViewCellIdentifier.currencyListCell

        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? UITableViewCell & CurrencyListTableViewCellProtocol else {
            fatalError("Failed to dequeue cell with identifier: \(identifier.rawValue)")
        }

        if let item = data.itemAt(indexPath: indexPath) {
            cell.set(item: item)
        }

        return cell
    }
}
