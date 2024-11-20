import SwiftData

@Model
final class CurrencyRate {
    var currency: String
    var rate: Double
    
    init(currency: String, rate: Double) {
        self.currency = currency
        self.rate = rate
    }
} 
