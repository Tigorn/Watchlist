import Foundation
import Domain

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

    static var btcTickerData: Data {
        return fixtureData(fileName: "btc_ticker")
    }

    static var btcTicker: Currency {
        guard let object = try? JSONDecoder().decode(Currency.self, from: btcTickerData) else {
            fatalError("Could not decode data.")
        }
        
        return object
    }
}
