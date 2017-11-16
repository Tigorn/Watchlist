import Quick
import Nimble
@testable import RemoteService

class CommandTests: QuickSpec {
    override func spec() {
        describe("Command") {
            it("executes its command") {
                var value = false
                let command = Command {
                    value = true
                }
                command.execute()
                expect(value).toEventually(beTrue())
            }
        }
    }
}
