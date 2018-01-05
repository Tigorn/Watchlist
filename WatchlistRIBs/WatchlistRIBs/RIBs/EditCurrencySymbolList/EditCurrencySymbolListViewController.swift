import RIBs
import RxSwift
import UIKit

protocol EditCurrencySymbolListPresentableListener: class {
    func movingFromParent()
}

final class EditCurrencySymbolListViewController: UIViewController, EditCurrencySymbolListPresentable, EditCurrencySymbolListViewControllable {

    weak var listener: EditCurrencySymbolListPresentableListener?

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isMovingFromParentViewController {
            listener?.movingFromParent()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow
    }
}
