import RIBs
import RxSwift
import UIKit

protocol BasePresentableListener: class {}

final class BaseViewController: UITabBarController, BasePresentable, BaseViewControllable {
    weak var listener: BasePresentableListener?

    func set(viewControllers: [ViewControllable]) {
        self.viewControllers = viewControllers.map { $0.uiviewController }
    }
}
