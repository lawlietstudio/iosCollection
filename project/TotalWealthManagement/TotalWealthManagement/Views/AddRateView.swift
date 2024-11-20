import SwiftUI
import SwiftData

struct AddRateView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedCurrency = ""
    @State private var rate: Double?
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Currency", text: $selectedCurrency)
                TextField("Rate", value: $rate, format: .number)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add Rate")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        addRate()
                    }
                    .disabled(selectedCurrency.isEmpty || rate == nil)
                }
            }
        }
    }
    
    private func addRate() {
        guard !selectedCurrency.isEmpty, let rate = rate else { return }
        
        let newRate = CurrencyRate(currency: selectedCurrency, rate: rate)
        modelContext.insert(newRate)
        dismiss()
    }
}

#Preview {
    AddRateView()
} 