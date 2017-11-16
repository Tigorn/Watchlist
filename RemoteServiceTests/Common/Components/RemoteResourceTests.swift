import Quick
import Nimble
@testable import RemoteService

class RemoteResourceTests: QuickSpec {
    override func spec() {
        describe("RemoteResource") {
            var remoteResource: RemoteResource!

            beforeEach {
                remoteResource = RemoteResource(statusCode: 201, data: Data(), error: nil)
            }

            it("validates its status code") {
                expect(remoteResource.isStatusCodeValid).to(beTrue())
                remoteResource = RemoteResource(statusCode: 500, data: Data(), error: URLError.cancelled as? Error)
                expect(remoteResource.isStatusCodeValid).to(beFalse())
                remoteResource = RemoteResource()
                expect(remoteResource.isStatusCodeValid).to(beFalse())
            }
        }
    }
}
