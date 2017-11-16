import Quick
import Nimble
@testable import LocalService

class LocalDefaultsServiceTests: QuickSpec {
    override func spec() {
        describe("LocalDefaultsService") {
            let suiteName = "LocalDefaultsService"
            var localService: LocalDefaultsService!
            var userDefaults: UserDefaults!

            beforeEach {
                UserDefaults.standard.removePersistentDomain(forName: suiteName)
                localService = LocalDefaultsService()
                userDefaults = UserDefaults(suiteName: suiteName)
                localService.userDefaults = userDefaults
            }

            it("sets default currencies flag") {
                expect(localService.didSetDefaultCurrencies).to(beFalse())
                localService.didSetDefaultCurrencies = true
                expect(localService.didSetDefaultCurrencies).to(beTrue())
            }
        }
    }
}
