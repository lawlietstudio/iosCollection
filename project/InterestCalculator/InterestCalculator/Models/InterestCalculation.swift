import Foundation

enum InterestType {
    case simple
    case compound
}

struct InterestCalculation: Identifiable {
    let id = UUID()
    let name: String
    let principal: Double
    let rate: Double
    let period: Int
    let interestType: InterestType
    
    var totalInterest: Double {
        switch interestType {
        case .simple:
            return principal * (rate / 100) * Double(period)
        case .compound:
            return (principal * pow(1 + (rate / 100), Double(period))) - principal
        }
    }
    
    var totalAmount: Double {
        principal + totalInterest
    }
    
    func amountForYear(_ year: Int) -> Double {
        guard year <= period else { return 0 }
        
        switch interestType {
        case .simple:
            let interest = principal * (rate / 100) * Double(year)
            return principal + interest
        case .compound:
            return principal * pow(1 + (rate / 100), Double(year))
        }
    }
} 
