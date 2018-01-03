import Quick
import Nimble
@testable import WatchlistRIBs

class ListViewControllerTests: QuickSpec {
    override func spec() {
        describe("ListViewController") {
            var viewController: ListViewController!
            var listener: MockListPresentableListener!

            beforeEach {
                listener = MockListPresentableListener()
                viewController = ListViewController()
                viewController.listener = listener
            }

            it("refreshes on viewDidAppear") {
                viewController.viewDidAppear(false)
                expect(listener.didRefresh).to(beTrue())
            }

            it("refreshes on pull to refresh") {
                viewController.refreshControl.sendActions(for: .valueChanged)
                expect(listener.didRefresh).to(beTrue())
            }
        }
    }
}

private class MockListPresentableListener: ListPresentableListener {
    var didRefresh = false

    func refresh() {
        didRefresh = true
    }
}
