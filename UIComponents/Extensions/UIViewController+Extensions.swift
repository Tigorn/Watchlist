import UIKit

extension UIViewController {
    public func display(childViewController viewController: UIViewController, in view: UIView? = nil, atIndex index: Int? = nil) {
        addChildViewController(viewController)
        let parentView: UIView = view ?? self.view
        viewController.view.frame = parentView.bounds
        if let index = index {
            parentView.insertSubview(viewController.view, at: index)
        } else {
            parentView.addSubview(viewController.view)
        }
        viewController.didMove(toParentViewController: self)
    }

    public func remove(childViewController viewController: UIViewController) {
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }
}
