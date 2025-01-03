import SwiftUI
import Charts

struct ExpenseView: View {
    @State private var monthlyExpense: Double = 5000
    @State private var currentAge: Double = 30
    @State private var expectedAge: Double = 85
    @State private var inflation: Double = 2.0
    
    @AppStorage("monthlyExpense") var storedMonthlyExpense: Double = 8000
    @AppStorage("currentAge") var storedCurrentAge: Double = 30
    @AppStorage("expectedAge") var storedExpectedAge: Double = 65
    @AppStorage("inflation") var storedInflation: Double = 3.0
    
    private var yearlyData: [ExpenseData] {
        var data: [ExpenseData] = []
        let years = Int(expectedAge - currentAge)
        var currentExpense = monthlyExpense * 12
        
        for year in 0...years {
            let age = Int(currentAge) + year
            data.append(ExpenseData(
                age: age,
                yearlyExpense: currentExpense,
                monthlyExpense: currentExpense / 12, 
                cumulativeExpense: (data.last?.cumulativeExpense ?? 0) + currentExpense
            ))
            currentExpense *= (1 + inflation/100)
        }
        return data
    }
    
    private var totalExpense: Double {
        yearlyData.map(\.yearlyExpense).reduce(0, +)
    }
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading) {
                    Text("Current Age: \(Int(currentAge))")
                    Slider(value: $currentAge, in: 0...expectedAge, step: 1)
                        .onAppear {
                            currentAge = storedCurrentAge
                        }
                        .onChange(of: currentAge) { oldValue, newValue in
                            storedCurrentAge = newValue
                        }
                }
                
                VStack(alignment: .leading) {
                    Text("Expected Age: \(Int(expectedAge))")
                    Slider(value: $expectedAge, in: max(1, currentAge)...120, step: 1)
                        .onAppear {
                            expectedAge = storedExpectedAge
                        }
                        .onChange(of: expectedAge) { oldValue, newValue in
                            storedExpectedAge = newValue
                        }
                }
                
                VStack(alignment: .leading) {
                    Text("Monthly Expense: $\(Int(monthlyExpense))")
                    Slider(value: $monthlyExpense, in: 1000...20000, step: 100)
                        .onAppear {
                            monthlyExpense = storedMonthlyExpense
                        }
                        .onChange(of: monthlyExpense) { oldValue, newValue in
                            storedMonthlyExpense = newValue
                        }
                }
                
                VStack(alignment: .leading) {
                    Text("Inflation Rate: \(String(format: "%.1f", inflation))%")
                    Slider(value: $inflation, in: 0...10, step: 0.1)
                        .onAppear {
                            inflation = storedInflation
                        }
                        .onChange(of: inflation) { oldValue, newValue in
                            storedInflation = newValue
                        }
                }
            }
            
            Section("Expense Chart") {
                Chart(yearlyData) { data in
                    LineMark(
                        x: .value("Age", data.age),
                        y: .value("Yearly Expense", data.yearlyExpense)
                    )
                    .foregroundStyle(.blue)
                    
                    AreaMark(
                        x: .value("Age", data.age),
                        y: .value("Yearly Expense", data.yearlyExpense)
                    )
                    .foregroundStyle(.blue.opacity(0.1))
                }
                .frame(height: 200)
                .padding()
                
                Text("Total Lifetime Expense")
                    .font(.headline)
                Text(formatCurrency(totalExpense))
                    .font(.title2)
                    .foregroundColor(.blue)
            }
            
            Section("Yearly Breakdown") {
                ForEach(yearlyData) { data in
                    HStack {
                        Text("Age \(data.age)")
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("Yearly \(formatCurrency(data.yearlyExpense))")
                                .font(.subheadline)
                            Text("Monthly \(formatCurrency(data.monthlyExpense))")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .navigationTitle("Expense Projection")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func formatCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter.string(from: NSNumber(value: value)) ?? "$0"
    }
}

struct ExpenseData: Identifiable {
    let id = UUID()
    let age: Int
    let yearlyExpense: Double
    let monthlyExpense: Double
    let cumulativeExpense: Double
}

#Preview {
    NavigationStack {
        ExpenseView()
    }
} 
