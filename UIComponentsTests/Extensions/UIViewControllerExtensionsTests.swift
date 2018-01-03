import Nimble
import Quick
@testable import UIComponents

class UIViewControllerExtensionsTests: QuickSpec {
    override func spec() {
        describe("UIViewControllerExtensions") {
            describe("display") {
                var parent: UIViewController!
                var child: UIViewController!

                beforeEach {
                    parent = UIViewController()
                    child = UIViewController()
                }
                it("adds a child view controller to parent") {
                    parent.display(childViewController: child)
                    expect(child.view.superview).to(equal(parent.view))
                    expect(child.parent).to(equal(parent))
                }

                it("adds a child view controller to a specific view") {
                    let parentView = UIView()
                    parent.view.addSubview(parentView)
                    parent.display(childViewController: child, in: parentView)
                    expect(child.view.superview).to(equal(parentView))
                }

                it("adds a child view a an index") {
                    parent.view.addSubview(UIView())
                    parent.display(childViewController: child, atIndex: 0)
                    expect(child.view).to(equal(parent.view.subviews.first))
                }
            }

            it("removes a childViewController") {
                let parent = UIViewController()
                let child = UIViewController()
                parent.display(childViewController: child)
                parent.remove(childViewController: child)
                expect(child.view.superview).to(beNil())
                expect(child.parent).to(beNil())
            }
        }
    }
}
