import Quick
import Nimble
@testable import WatchlistViper

class BootstrapRouterTests: QuickSpec {
    override func spec() {
        describe("BootstrapRouter") {
            var router: BootstrapRouter!

            beforeEach {
                router = BootstrapRouter()
            }

            it("creates the rootViewController") {
                expect(router.rootViewController()).to(beAKindOf(UITabBarController.self))
            }
        }
    }
}
