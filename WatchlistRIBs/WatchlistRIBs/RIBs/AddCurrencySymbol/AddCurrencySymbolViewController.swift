import RIBs
import RxSwift
import UIKit

protocol AddCurrencySymbolPresentableListener: class {
    func movingFromParent()
}

final class AddCurrencySymbolViewController: UIViewController, AddCurrencySymbolPresentable, AddCurrencySymbolViewControllable {

    weak var listener: AddCurrencySymbolPresentableListener?

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isMovingFromParentViewController {
            listener?.movingFromParent()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
    }
}
