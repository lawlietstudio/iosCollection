//
//  AddAssetView.swift
//  TotalWealthManagement
//
//  Created by mark on 2024-11-17.
//

import SwiftUI
import _SwiftData_SwiftUI

struct AssetFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Query private var rates: [CurrencyRate]
    
    @State private var editingAsset: Asset
    @State private var selectedColor: Color
    let originalAsset: Asset?
    let isNewAsset: Bool
    
    init(asset: Asset? = nil) {
        self.originalAsset = asset
        self._editingAsset = State(initialValue: asset?.copy() ?? Asset())
        self._selectedColor = State(initialValue: asset?.displayColor ?? .blue)
        self.isNewAsset = asset == nil
    }
    
    var body: some View {
        Form {
            LabeledContent {
                TextField("Name", text: $editingAsset.name)
                    .multilineTextAlignment(.trailing)
            } label: {
                Text("Name")
            }
            
            LabeledContent {
                TextField("Amount", value: $editingAsset.amount, format: .number)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            } label: {
                Text("Amount")
            }
            
            Picker("Currency", selection: $editingAsset.currency) {
                ForEach(rates, id: \.self) { currencyRate in
                    Text(currencyRate.currency).tag(currencyRate.currency)
                }
            }
            
            ColorPicker("Asset Color", selection: $selectedColor, supportsOpacity: false)
                .onChange(of: selectedColor) { _, newColor in
                    editingAsset.color = colorToString(newColor)
                }
        }
        .navigationTitle(isNewAsset ? "Add Asset" : "Edit Asset")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(isNewAsset ? "Save" : "Done") {
                    if isNewAsset {
                        modelContext.insert(editingAsset)
                    } else if let original = originalAsset {
                        // Update original asset with edited values
                        original.name = editingAsset.name
                        original.amount = editingAsset.amount
                        original.currency = editingAsset.currency
                        original.color = editingAsset.color
                    }
                    try? modelContext.save()
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
    }
    
    private func colorToString(_ color: Color) -> String {
        let uiColor = UIColor(color)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: nil)
        return "\(red),\(green),\(blue)"
    }
}
