import RIBs
import RxSwift
import UIComponents
import UIKit

protocol RootPresentableListener: class {
    func viewDidLoad()
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {
    weak var listener: RootPresentableListener?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        listener?.viewDidLoad()
    }

    func add(childViewController: ViewControllable, atIndex index: Int?) {
        display(childViewController: childViewController.uiviewController, in: nil, atIndex: index)
    }

    func remove(childViewController: ViewControllable) {
        remove(childViewController: childViewController.uiviewController)
    }
}
