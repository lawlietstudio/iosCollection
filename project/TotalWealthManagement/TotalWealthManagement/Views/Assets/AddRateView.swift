import SwiftUI
import SwiftData

struct AddRateView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedCurrency = "USD"
    @State private var rate: Double?
    
    private let availableCurrencies = Locale.commonISOCurrencyCodes.sorted()
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Currency", selection: $selectedCurrency) {
                    ForEach(availableCurrencies, id: \.self) { code in
                        HStack {
                            Text(code)
                            Text(Locale.current.localizedString(forCurrencyCode: code) ?? "")
                                .foregroundColor(.secondary)
                        }
                        .tag(code)
                    }
                }
                
                LabeledContent {
                    TextField("Rate", value: $rate, format: .number)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                } label: {
                    Text("Rate")
                }
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
