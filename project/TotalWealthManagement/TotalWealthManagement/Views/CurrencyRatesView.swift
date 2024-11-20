import SwiftUICore
import SwiftUI
import _SwiftData_SwiftUI

struct CurrencyRatesView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query private var rates: [CurrencyRate]
    @State private var showingAddSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(rates) { rate in
                    HStack {
                        Text(rate.currency)
                        Spacer()
                        Text(rate.rate, format: .number)
                    }
                }
                .onDelete(perform: deleteRates)
            }
            .navigationTitle("Currency Rates")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddSheet = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    private func deleteRates(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(rates[index])
        }
    }
} 
