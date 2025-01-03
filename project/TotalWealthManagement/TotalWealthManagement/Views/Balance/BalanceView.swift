import SwiftUI
import Charts

struct BalanceView: View {
    let dismiss: (() -> ())?
    
    // Income inputs
    @AppStorage("monthlySalary") private var monthlySalary: Double = 8000
    @AppStorage("retirementAge") private var retirementAge: Double = 65
    @AppStorage("payRaise") private var payRaise: Double = 3.0
    
    // Expense inputs
    @AppStorage("monthlyExpense") private var monthlyExpense: Double = 5000
    @AppStorage("expectedAge") private var expectedAge: Double = 85
    @AppStorage("inflation") private var inflation: Double = 2.0
    
    // Shared input
    @AppStorage("currentAge") private var currentAge: Double = 30
    
    @State private var showingExpenseSheet = false
    @State private var showingIncomeSheet = false
    
    private var yearlyData: [BalanceData] {
        var data: [BalanceData] = []
        let years = Int(expectedAge - currentAge)
        var currentSalary = monthlySalary * 12
        var currentExpense = monthlyExpense * 12
        var cumulativeBalance: Double = 0
        
        for year in 0...years {
            let age = Int(currentAge) + year
            let yearlyIncome = age <= Int(retirementAge) ? currentSalary : 0
            let yearlyBalance = yearlyIncome - currentExpense
            cumulativeBalance += yearlyBalance
            
            data.append(BalanceData(
                age: age,
                yearlyIncome: yearlyIncome,
                yearlyExpense: currentExpense,
                yearlyBalance: yearlyBalance,
                cumulativeBalance: cumulativeBalance
            ))
            
            currentSalary *= (1 + payRaise/100)
            currentExpense *= (1 + inflation/100)
        }
        return data
    }
    
    private var totalBalance: Double {
        yearlyData.map(\.yearlyBalance).reduce(0, +)
    }
    
    enum BalanceType: String, Plottable {
        case income = "Income"
        case expense = "Expense"
        case balance = "Balance"
        case cumulativeBalance = "CumulativeBalance"
    }
    
    private var chartData: [(type: BalanceType, age: Int, amount: Double)] {
        yearlyData.flatMap { data in [
            (type: .income, age: data.age, amount: data.yearlyIncome),
            (type: .expense, age: data.age, amount: data.yearlyExpense),
            (type: .balance, age: data.age, amount: data.yearlyBalance),
//            (type: .cumulativeBalance, age: data.age, amount: data.cumulativeBalance)
        ]}
    }
    
    var body: some View {
        List {
            Section {
                VStack {
//                    Chart(yearlyData) { data in
////                        LineMark(
////                            x: .value("Age", data.age),
////                            y: .value("Balance", data.yearlyBalance)
////                        )
////                        .foregroundStyle(.green)
//                        
//                        LineMark(
//                            x: .value("Age", data.age),
//                            y: .value("Income", data.yearlyIncome)
//                        )
//                        .foregroundStyle(.blue)
//                        
//                        LineMark(
//                            x: .value("Age", data.age),
//                            y: .value("Expense", data.yearlyExpense)
//                        )
//                        .foregroundStyle(.red)
//                        
////                        AreaMark(
////                            x: .value("Age", data.age),
////                            y: .value("Cumulative", data.cumulativeBalance)
////                        )
////                        .foregroundStyle(.green.opacity(0.1))
//                    }
                    Chart(chartData, id: \.age) { dataPoint in
                        LineMark(
                            x: .value("Age", dataPoint.age),
                            y: .value("Amount", dataPoint.amount)
                        )
                        .foregroundStyle(by: .value("Type", dataPoint.type))
                    }
                    .chartForegroundStyleScale([
                        BalanceType.income: Color.green,
                        BalanceType.expense: Color.red,
                        BalanceType.balance: Color.blue,
                        BalanceType.cumulativeBalance: Color.yellow
                    ])
                    .frame(height: 200)
                    .padding()
                    
                    Text("Lifetime Balance")
                        .font(.headline)
                    Text(formatCurrency(totalBalance))
                        .font(.title2)
                        .foregroundColor(totalBalance >= 0 ? .blue : .red)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.cardBackground))
                        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
                )
            }
            
            Section {
                Grid {
                    GridRow {
                        Text("Age").bold()
                        Text("Cash Flow").bold()
                        Text("Cumulative").bold()
                    }
                    .padding(.vertical, 5)
                    
                    ForEach(yearlyData) { data in
                        GridRow {
                            Text("\(data.age)")
                            
                            VStack(alignment: .trailing, spacing: 2) {
                                Text(formatCurrency(data.yearlyIncome))
                                    .foregroundColor(.green)
                                Text(formatCurrency(data.yearlyExpense))
                                    .foregroundColor(.red)
                                Text(formatCurrency(data.yearlyBalance))
                                    .foregroundColor(data.yearlyBalance >= 0 ? .blue : .red)
                                    .fontWeight(.semibold)
                            }
                            
                            Text(formatCurrency(data.cumulativeBalance))
                                .foregroundColor(data.cumulativeBalance >= 0 ? .blue : .red)
                        }
                        .font(.caption)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.cardBackground))
                        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
                )
                .padding(.vertical, 5)
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color(.systemGroupedBackground))
        .listStyle(.plain)
        .environment(\.defaultMinListRowHeight, 1)
        .listRowSpacing(0)
        .listSectionSeparator(.hidden)
        .listRowSeparator(.hidden)
        .sheet(isPresented: $showingExpenseSheet) {
            NavigationStack {
                ExpenseView()

            }
            .presentationDetents([
                .large,                   // Large height (full-screen)
                .fraction(0.4),
                .medium,        // Medium height (default ~50%)
                .fraction(0.6),
                .fraction(0.7),
                .fraction(0.8)
            ], selection: .constant(.medium))
            .presentationDragIndicator(.visible) // Optional: Show a drag indicator
        }
        .sheet(isPresented: $showingIncomeSheet) {
            NavigationStack {
                IncomeView()
            }
            .presentationDetents([
                .large,                   // Large height (full-screen)
                .fraction(0.4),
                .medium,        // Medium height (default ~50%)
                .fraction(0.6),
                .fraction(0.7),
                .fraction(0.8)
            ], selection: .constant(.medium))
            .presentationDragIndicator(.visible) // Optional: Show a drag indicator
        }
        .safeAreaInset(edge: .top, spacing: 16) {
            ZStack {
                Color.clear
                    .background(Color(.cardBackground))
                //                        .blur(radius: 10)
                
                HStack {
                    HStack {
                        Image(systemName: "line.3.horizontal")
                            .foregroundStyle(.blue)
                            .font(.system(size: 16, weight: .semibold))
                            .onTapGesture {
                                dismiss?()
                            }
                    }
                    
                    Text(TabState.balance.rawValue)
                        .font(.title3.weight(.bold))
                    
                    Spacer()
                    
                    HStack(spacing: 16) {
                        Button(action: {
                            showingExpenseSheet = true
                        }) {
                            Image(systemName: "arrow.down.square.fill")
                                .font(.system(size: 16, weight: .semibold))
                        }
                        
                        Button(action: {
                            showingIncomeSheet = true
                        }) {
                            Image(systemName: "arrow.up.square.fill")
                                .font(.system(size: 16, weight: .semibold))
                        }
                    }
                }
            }
            .safeAreaPadding(.horizontal)
            .frame(height: 40)
        }
    }
    
    private func formatCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        return formatter.string(from: NSNumber(value: value)) ?? "$0"
    }
}

struct BalanceData: Identifiable {
    let id = UUID()
    let age: Int
    let yearlyIncome: Double
    let yearlyExpense: Double
    let yearlyBalance: Double
    let cumulativeBalance: Double
}
