@testable import FoundationComponents
import Nimble
import Quick

class CollectionExtensionsTests: QuickSpec {
    override func spec() {
        describe("Safe Access") {
            it("returns nil if array is empty") {
                let array = [Int]()
                expect(array[safe: 0]).to(beNil())
            }

            it("returns value if index is safe") {
                let array = [1, 2, 3]
                expect(array[safe: 1]).to(equal(2))
            }

            it("returns nil if index above bounds") {
                let array = [1, 2, 3]
                expect(array[safe: 4]).to(beNil())
            }

            it("returns nil if index below bounds") {
                let array = [1, 2, 3]
                expect(array[safe: -1]).to(beNil())
            }
        }
    }
}
