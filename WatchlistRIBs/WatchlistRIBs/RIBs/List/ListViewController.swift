import RIBs
import RxSwift
import UIKit
import SnapKit
import UIComponents

protocol ListPresentableListener: class {
    func refresh()
}

final class ListViewController: UIViewController, ListPresentable, ListViewControllable {
    weak var listener: ListPresentableListener?

    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem.title = "List".localized
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        addTableViewConstraints()
        addActivityIndicatorConstraints()
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

    private let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)

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
        listener?.refresh()
    }

    private func registerCells() {
        let currencyListNib = UINib(nibName: .currencyListCell)
        tableView.register(currencyListNib, forCellReuseIdentifier: .currencyListCell)
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.refreshControl = self.refreshControl
        return tableView
    }()
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
