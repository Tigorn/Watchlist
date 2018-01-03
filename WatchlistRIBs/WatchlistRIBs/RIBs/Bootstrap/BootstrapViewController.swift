import RIBs
import RxSwift
import SnapKit
import UIKit

protocol BootstrapPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class BootstrapViewController: UIViewController, BootstrapPresentable, BootstrapViewControllable {

    weak var listener: BootstrapPresentableListener?

    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        addActivityIndicatorConstraints()
        activityIndicator.startAnimating()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        activityIndicator.stopAnimating()
    }

    // MARK: - Private

    private func addActivityIndicatorConstraints() {
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { maker in
            maker.center.equalTo(self.view.snp.center)
        }
    }
}
