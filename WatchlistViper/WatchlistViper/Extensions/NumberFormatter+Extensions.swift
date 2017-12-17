import UIKit

public extension NumberFormatter {
    func string(from number: Double?) -> String {
        guard let number = number,
            let string = string(from: NSNumber(value: number)) else {
            return String.emDash
        }
        return string
    }

    func string(from number: Int?) -> String {
        guard let number = number,
            let string = string(from: NSNumber(value: number)) else {
            return String.emDash
        }
        return string
    }
}
