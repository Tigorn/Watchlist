import UIKit

public struct Currency: Decodable {
    public let symbol: String
    public let lastPrice: Double?
    public let priceChange: Double?
    public let percentChange: Double?
    public let volume: Double?
    public let high: Double?
    public let low: Double?

    public init() {
        symbol = ""
        lastPrice = nil
        priceChange = nil
        percentChange = nil
        volume = nil
        high = nil
        low = nil
    }

    public init(symbol: String,
                name _: String? = nil,
                lastPrice: Double? = nil,
                priceChange: Double? = nil,
                percentChange: Double? = nil,
                volume: Double? = nil,
                high: Double? = nil,
                low: Double? = nil) {
        self.symbol = symbol
        self.lastPrice = lastPrice
        self.priceChange = priceChange
        self.percentChange = percentChange
        self.volume = volume
        self.high = high
        self.low = low
    }

    public init(from decoder: Decoder) throws {
        do {
            var container = try decoder.unkeyedContainer()

            symbol = try container.decode(String.self)
            try (0 ..< 4).forEach { _ in _ = try container.decode(Double.self) }
            priceChange = try container.decode(Double.self)
            percentChange = try container.decode(Double.self)
            lastPrice = try container.decode(Double.self)
            volume = try container.decode(Double.self)
            high = try container.decode(Double.self)
            low = try container.decode(Double.self)
        } catch {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: ""))
        }
    }
}
