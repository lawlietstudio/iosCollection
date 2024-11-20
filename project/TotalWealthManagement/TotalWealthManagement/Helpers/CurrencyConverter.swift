import SwiftData
import Foundation

@Observable
class CurrencyConverter {
    static let shared = CurrencyConverter()
    
    func convert(_ amount: Double?, from fromCurrency: String, to toCurrency: String, using rates: [CurrencyRate]) -> Double {
        guard let amount = amount else { return 0 }
        
        // If same currency, return original amount
        if fromCurrency == toCurrency {
            return amount
        }
        
        let fromRate = rates.first(where: { $0.currency == fromCurrency })?.rate ?? 1.0
        let toRate = rates.first(where: { $0.currency == toCurrency })?.rate ?? 1.0
        
        return amount * (toRate / fromRate)
    }
    
    func formatAmount(_ amount: Double, currency: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return formatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
    }
} 
