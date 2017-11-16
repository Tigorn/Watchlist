import Foundation

class Fixtures {
    private static func fixtureData(fileName: String) -> Data {
        let path = Bundle(for: Fixtures.self).path(forResource: fileName, ofType: "json")!
        let url = URL(fileURLWithPath: path)
        var data = Data()
        if let tryData = try? Data(contentsOf: url, options: []) {
            data = tryData
        }
        return data
    }

    static var btcTicker: Data {
        return fixtureData(fileName: "btc_ticker")
    }
}
