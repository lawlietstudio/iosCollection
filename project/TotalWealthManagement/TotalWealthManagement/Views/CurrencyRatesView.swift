import SwiftUI
import SwiftUICore
import _SwiftData_SwiftUI

struct CurrencyRatesView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query private var rates: [CurrencyRate]
    @State private var showingAddSheet = false

    var body: some View {
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
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
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
        .sheet(isPresented: $showingAddSheet) {
            AddRateView()
        }
    }

    private func deleteRates(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(rates[index])
        }
    }
}
