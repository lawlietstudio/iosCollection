import SwiftUICore
import SwiftUI

struct AddCalculationView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var calculations: [InterestCalculation]
    
    @State private var name = ""
    @State private var principal = ""
    @State private var rate = ""
    @State private var period = ""
    @State private var interestType: InterestType = .compound
    
    private var principalValue: Double? { Double(principal) }
    private var rateValue: Double? { Double(rate) }
    private var periodValue: Int? { Int(period) }
    
    private var previewCalculation: InterestCalculation? {
        guard let principal = principalValue,
              let rate = rateValue,
              let period = periodValue else {
            return nil
        }
        
        return InterestCalculation(
            name: name.isEmpty ? "Preview" : name,
            principal: principal,
            rate: rate,
            period: period,
            interestType: interestType
        )
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Details") {
                    TextField("Name", text: $name)
                    TextField("Principal Amount", text: $principal)
                        .keyboardType(.decimalPad)
                    TextField("Interest Rate (%)", text: $rate)
                        .keyboardType(.decimalPad)
                    TextField("Period (Years)", text: $period)
                        .keyboardType(.numberPad)
                    
                    Picker("Interest Type", selection: $interestType) {
                        Text("Compound").tag(InterestType.compound)
                        Text("Simple").tag(InterestType.simple)
                    }
                }
                
                if let calculation = previewCalculation {
                    Section("Preview") {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Principal: $\(calculation.principal, specifier: "%.2f")")
                            Text("Total Interest: $\(calculation.totalInterest, specifier: "%.2f")")
                            Text("Total Amount: $\(calculation.totalAmount, specifier: "%.2f")")
                        }
                    }
                }
            }
            .navigationTitle("Add Calculation")
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                },
                trailing: Button("Save") {
                    saveCalculation()
                }
                .disabled(previewCalculation == nil)
            )
        }
    }
    
    private func saveCalculation() {
        guard let calculation = previewCalculation else { return }
        calculations.append(calculation)
        dismiss()
    }
} 
