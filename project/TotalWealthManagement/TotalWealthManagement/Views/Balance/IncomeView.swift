import SwiftUI
import Charts

struct IncomeView: View {
    @State private var monthlySalary: Double = 8000
    @State private var currentAge: Double = 30
    @State private var retirementAge: Double = 65
    @State private var payRaise: Double = 3.0
    
    @AppStorage("monthlySalary") var storedMonthlySalary: Double = 8000
    @AppStorage("currentAge") var storedCurrentAge: Double = 30
    @AppStorage("retirementAge") var storedRetirementAge: Double = 65
    @AppStorage("payRaise") var storedPayRaise: Double = 3.0
    
    private var yearlyData: [IncomeData] {
        var data: [IncomeData] = []
        let years = Int(retirementAge - currentAge)
        var currentSalary = monthlySalary * 12
        
        for year in 0...years {
            let age = Int(currentAge) + year
            data.append(IncomeData(
                age: age,
                yearlyIncome: currentSalary,
                monthlyIncome: currentSalary / 12,
                cumulativeIncome: (data.last?.cumulativeIncome ?? 0) + currentSalary
            ))
            currentSalary *= (1 + payRaise/100)
        }
        return data
    }
    
    private var totalIncome: Double {
        yearlyData.map(\.yearlyIncome).reduce(0, +)
    }
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading) {
                    Text("Current Age: \(Int(currentAge))")
                    Slider(value: $currentAge, in: 0...retirementAge, step: 1)
                        .onAppear {
                            currentAge = storedCurrentAge
                        }
                        .onChange(of: currentAge) { oldValue, newValue in
                            storedCurrentAge = newValue
                        }
                }
                
                VStack(alignment: .leading) {
                    Text("Retirement Age: \(Int(retirementAge))")
                    Slider(value: $retirementAge, in: max(1, currentAge)...120, step: 1)
                        .onAppear {
                            retirementAge = storedRetirementAge
                        }
                        .onChange(of: retirementAge) { oldValue, newValue in
                            storedRetirementAge = newValue
                        }
                }
                
                VStack(alignment: .leading) {
                    Text("Monthly Salary: $\(Int(monthlySalary))")
                    Slider(value: $monthlySalary, in: 2000...50000, step: 100)
                        .onAppear {
                            monthlySalary = storedMonthlySalary
                        }
                        .onChange(of: monthlySalary) { oldValue, newValue in
                            storedMonthlySalary = newValue
                        }
                }
                
                VStack(alignment: .leading) {
                    Text("Yearly Pay Raise: \(String(format: "%.1f", payRaise))%")
                    Slider(value: $payRaise, in: 0...10, step: 0.1)
                        .onAppear {
                            payRaise = storedPayRaise
                        }
                        .onChange(of: payRaise) { oldValue, newValue in
                            storedPayRaise = newValue
                        }
                }
            }
            
            Section("Income Chart") {
                Chart(yearlyData) { data in
                    LineMark(
                        x: .value("Age", data.age),
                        y: .value("Yearly Income", data.yearlyIncome)
                    )
                    .foregroundStyle(.green)
                    
                    AreaMark(
                        x: .value("Age", data.age),
                        y: .value("Yearly Income", data.yearlyIncome)
                    )
                    .foregroundStyle(.green.opacity(0.1))
                }
                .frame(height: 200)
                .padding()
                
                Text("Total Lifetime Income")
                    .font(.headline)
                Text(formatCurrency(totalIncome))
                    .font(.title2)
                    .foregroundColor(.green)
            }
            
            Section("Yearly Breakdown") {
                ForEach(yearlyData) { data in
                    HStack {
                        Text("Age \(data.age)")
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("Yearly \(formatCurrency(data.yearlyIncome))")
                                .font(.subheadline)
                            Text("Monthly \(formatCurrency(data.monthlyIncome))")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .navigationTitle("Income Projection")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func formatCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter.string(from: NSNumber(value: value)) ?? "$0"
    }
}

struct IncomeData: Identifiable {
    let id = UUID()
    let age: Int
    let yearlyIncome: Double
    let monthlyIncome: Double
    let cumulativeIncome: Double
}

#Preview {
    NavigationStack {
        IncomeView()
    }
} 
