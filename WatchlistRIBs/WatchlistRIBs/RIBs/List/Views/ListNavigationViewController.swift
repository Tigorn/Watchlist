import UIKit
import RIBs

class ListNavigationViewController: UINavigationController, ListViewControllable {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        tabBarItem.title = "List".localized
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - ListViewControllable

    func show(viewController: ViewControllable) {
        DispatchQueue.main.async {
            self.pushViewController(viewController.uiviewController, animated: true)
        }
    }
}
