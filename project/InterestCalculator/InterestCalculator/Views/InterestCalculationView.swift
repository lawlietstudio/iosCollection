import SwiftUICore
import SwiftUI
import Charts

struct InterestCalculationView: View {
    @State private var calculations: [InterestCalculation] = []
    @State private var showingAddSheet = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    if !calculations.isEmpty {
                        ChartSection(calculations: calculations)
                            .frame(height: 240)
                            .padding(.horizontal, 16)
                    }
                    
                    LazyVStack(spacing: 16) {
                        ForEach(calculations) { calculation in
                            InterestCalculationRow(calculation: calculation)
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Interest Calculations")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddSheet = true
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 16, weight: .semibold))
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddCalculationView(calculations: $calculations)
            }
            .background(Color(.systemGroupedBackground))
        }
    }
}

struct ChartSection: View {
    let calculations: [InterestCalculation]
    
    private var maxPeriod: Int {
        calculations.map(\.period).max() ?? 0
    }
    
    private struct ChartData: Identifiable {
        let id = UUID()
        let year: Int
        let amount: Double
        let calculation: InterestCalculation
    }
    
    private var chartData:                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                [ChartData] {
        calculations.flatMap { calculation in
            (0...calculation.period).map { year in
                ChartData(
                    year: year,
                    amount: calculation.amountForYear(year),
                    calculation: calculation
                )
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Amount Progress")
                .font(.headline)
            
            Chart(chartData) { data in
                LineMark(
                    x: .value("Year", data.year),
                    y: .value("Amount", data.amount)
                )
                .foregroundStyle(by: .value("Calculation", data.calculation.name))
            }
            .chartXAxis {
                AxisMarks(values: .automatic(desiredCount: min(maxPeriod, 5))) { value in
                    AxisGridLine()
                    AxisValueLabel {
                        if let year = value.as(Int.self) {
                            Text("Year \(year)")
                                .font(.caption)
                        }
                    }
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading) { value in
                    AxisGridLine()
                    AxisValueLabel {
                        if let amount = value.as(Double.self) {
                            Text("$\(amount, specifier: "%.0f")")
                                .font(.caption)
                        }
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
    }
}

struct InterestCalculationRow: View {
    let calculation: InterestCalculation
    
    var body: some View {
        VStack(spacing: 16) {
            // Header
            HStack {
                Text(calculation.name)
                    .font(.headline)
                Spacer()
                Text(calculation.interestType == .compound ? "Compound" : "Simple")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color(.systemGray6))
                    )
            }
            
            // Input Details
            VStack(spacing: 8) {
                DetailRow(title: "Principal", value: String(format: "$%.2f", calculation.principal))
                DetailRow(title: "Interest Rate", value: String(format: "%.2f%%", calculation.rate))
                DetailRow(title: "Period", value: "\(calculation.period) years")
            }
            
            Divider()
            
            // Results
            VStack(spacing: 8) {
                DetailRow(
                    title: "Total Interest",
                    value: String(format: "$%.2f", calculation.totalInterest),
                    valueColor: .green
                )
                DetailRow(
                    title: "Total Amount",
                    value: String(format: "$%.2f", calculation.totalAmount),
                    valueColor: .blue,
                    isBold: true
                )
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
    }
}

struct DetailRow: View {
    let title: String
    let value: String
    var valueColor: Color = .primary
    var isBold: Bool = false
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .foregroundColor(valueColor)
                .fontWeight(isBold ? .bold : .regular)
        }
        .font(.subheadline)
    }
} 
