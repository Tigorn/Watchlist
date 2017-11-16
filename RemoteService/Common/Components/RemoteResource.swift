import Foundation

struct RemoteResource {
    let statusCode: Int?
    let data: Data?
    var error: Error?

    init() {
        self.init(statusCode: nil, data: nil, error: nil)
    }

    init(statusCode: Int?, data: Data?, error: Error?) {
        self.statusCode = statusCode
        self.data = data
        self.error = error
    }

    var isStatusCodeValid: Bool {
        guard let statusCode = statusCode else {
            return false
        }
        
        return statusCode >= 200 && statusCode < 300
    }

    var isErrorCancelled: Bool {
        guard let code = error?._code else {
            return false
        }

        return code == NSURLErrorCancelled
    }
}
