//
//  AssetsView.swift
//  TotalWealthManagement
//
//  Created by mark on 2024-11-17.
//

import SwiftUI
import Charts
import SwiftData

struct AssetsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var assets: [Asset]
    @Query private var rates: [CurrencyRate]
    @State private var showingAddSheet = false
    @State private var selectedCurrency: String = "USD"
    @State private var showingRatesSheet = false
    @State private var isHidden = false
    @State private var randomizedAssets: [Asset] = []
    
    private let assetCategories = [
        ("Stocks", 1000.0...50000.0),
        ("Real Estate", 100000.0...1000000.0),
        ("Crypto", 100.0...10000.0),
        ("Gold", 5000.0...50000.0),
        ("Cash", 1000.0...20000.0),
        ("Bonds", 10000.0...100000.0),
        ("ETFs", 5000.0...50000.0),
        ("Art", 10000.0...200000.0),
        ("Collectibles", 1000.0...30000.0),
        ("P2P Lending", 1000.0...10000.0),
        ("Startups", 10000.0...500000.0),
        ("Commodities", 5000.0...100000.0),
        ("NFTs", 100.0...5000.0),
        ("Mutual Funds", 10000.0...100000.0),
        ("Silver", 1000.0...20000.0)
    ]
    
    private func randomColor() -> String {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        return "\(red),\(green),\(blue)"
    }
    
    private var displayedAssets: [Asset] {
        if isHidden {
            return randomizedAssets
        }
        return assets
    }
    
    private func generateRandomAssets() {
        let shuffledCategories = assetCategories.shuffled().prefix(10)
        randomizedAssets = shuffledCategories.map { category in
            let (name, range) = category
            return Asset(
                name: name,
                amount: Double.random(in: range),
                currency: rates.randomElement()?.currency ?? "USD",
                color: randomColor()
            )
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Group {
                    // Currency Picker Section
                    Section {
                        Picker("Display Currency", selection: $selectedCurrency) {
                            ForEach(rates, id: \.self) { currencyRate in
                                Text(currencyRate.currency).tag(currencyRate.currency)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal, 16)
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                    .listSectionSeparator(.hidden)

                    // Pie Chart Section
                    if !assets.isEmpty {
                        Section {
                            VStack {
                                Chart(displayedAssets) { asset in
                                    SectorMark(
                                        angle: .value("Amount", convertedAmount(for: asset))
                                    )
                                    .foregroundStyle(by: .value("Asset", asset.name))
                                }
                                .chartForegroundStyleScale(domain: displayedAssets.map { $0.name },
                                                          range: displayedAssets.map { $0.displayColor })
                                .frame(height: 200)
                                .padding()
                                
                                // Total amount in selected currency
                                Text("Total: \(totalAmount, format: .currency(code: selectedCurrency))")
                                    .font(.headline)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(.cardBackground))
                                    .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
                            )
                        }
                        .padding([.top, .horizontal], 16)
                        .padding(.bottom, 8)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                        .listSectionSeparator(.hidden)
                    }
                    
                    // Assets Section
                    Section {
                        ForEach(displayedAssets) { asset in
                            AssetRow(
                                asset: asset,
                                selectedCurrency: selectedCurrency,
                                rates: rates
                            )
                            .listRowInsets(EdgeInsets())
                            .listRowBackground(Color.clear)
                            .listSectionSeparator(.hidden)
                            .listRowSeparator(.hidden)
                        }
                        .onDelete(perform: deleteAsset)
                    }
                    .listSectionSpacing(16)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color(.systemGroupedBackground))
            .listStyle(.plain)
            .environment(\.defaultMinListRowHeight, 1)
            .listRowSpacing(0)
            .listSectionSeparator(.hidden)
            .listRowSeparator(.hidden)
            .navigationTitle("Assets")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if !isHidden {
                            generateRandomAssets()
                        }
                        isHidden.toggle()
                    }) {
                        Image(systemName: isHidden ? "eye.slash.fill" : "eye.fill")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(isHidden ? .gray : .blue)
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingRatesSheet = true
                    }) {
                        Image(systemName: "coloncurrencysign")
                            .font(.system(size: 16, weight: .semibold))
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddSheet = true
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 16, weight: .semibold))
                    }
                }
                
                // Add Edit button for deletion
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                NavigationStack {
                    AssetFormView()
                }
            }
            .sheet(isPresented: $showingRatesSheet) {
                NavigationStack {
                    CurrencyRatesView()
                }
            }
        }
    }
    
    private func deleteAsset(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(assets[index])
        }
    }
    
    private func convertedAmount(for asset: Asset) -> Double {
        CurrencyConverter.shared.convert(
            asset.amount,
            from: asset.currency,
            to: selectedCurrency,
            using: rates
        )
    }
    
    private func formattedAmount(for asset: Asset) -> String {
        let converted = convertedAmount(for: asset)
        return CurrencyConverter.shared.formatAmount(converted, currency: selectedCurrency)
    }
    
    private var totalAmount: Double {
        displayedAssets.reduce(0) { total, asset in
            total + convertedAmount(for: asset)
        }
    }
    
    private func deleteAsset(_ asset: Asset) {
        modelContext.delete(asset)
    }
}

struct AssetRow: View {
    let asset: Asset
    let selectedCurrency: String
    let rates: [CurrencyRate]
    @State private var showingEditSheet = false
    
    var body: some View {
        HStack {
            Circle()
                .fill(asset.displayColor)
                .frame(width: 12, height: 12)
            
            Text(asset.name)
            Spacer()
            VStack(alignment: .trailing) {
                Text(CurrencyConverter.shared.formatAmount(
                    CurrencyConverter.shared.convert(
                        asset.amount,
                        from: asset.currency,
                        to: selectedCurrency,
                        using: rates
                    ),
                    currency: selectedCurrency
                ))
                
                if asset.currency != selectedCurrency {
                    Text(CurrencyConverter.shared.formatAmount(asset.amount ?? 0, currency: asset.currency))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.cardBackground))
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
        .padding(.horizontal)
        .padding(.vertical, 6)
        .onTapGesture {
            showingEditSheet = true
        }
        .sheet(isPresented: $showingEditSheet) {
            NavigationStack {
                AssetFormView(asset: asset)
            }
        }
    }
}

#Preview {
    AssetsView()
}
