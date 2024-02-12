import SwiftUI
import CoreData

struct DisplayableProductListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: CDDisplayableProduct.entity(),
        sortDescriptors: [],
        animation: .default)
    private var cdDisplayableProducts: FetchedResults<CDDisplayableProduct>

    @State private var newProductName: String = ""
    @State private var selectedProductType: ProductType = .tProduct

    var body: some View {
        NavigationView {
            VStack {
                Picker("Type", selection: $selectedProductType) {
                    Text("T Product").tag(ProductType.tProduct)
                    Text("HJ Product").tag(ProductType.hjProduct)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                TextField("Product Name", text: $newProductName)
                Button("Add Product", action: addProduct)
                    .disabled(newProductName.isEmpty)

                List {
                    ForEach(cdDisplayableProducts, id: \.self) { cdDisplayableProduct in
                        HStack {
                            Text(cdDisplayableProduct.tProduct?.name ?? cdDisplayableProduct.hjProduct?.name ?? "Unnamed")
                            Spacer()
                            Text(cdDisplayableProduct.productType ?? "Untyped")
                        }
                    }
                    .onDelete(perform: deleteProducts)
                }
            }
            .navigationTitle("Products")
            .toolbar {
                EditButton()
            }
        }
    }

    private func addProduct() {
        withAnimation {
            let displayableProduct = DisplayableProduct(productType: selectedProductType, tProduct: nil, hjProduct: nil)
            let cdDisplayableProduct = displayableProduct.toCDDisplayableProduct(context: viewContext)

            switch selectedProductType {
            case .tProduct:
                let cdTProduct = CDTProduct(context: viewContext)
                cdTProduct.name = newProductName
                cdDisplayableProduct.tProduct = cdTProduct
            case .hjProduct:
                let cdHJProduct = CDHJProduct(context: viewContext)
                cdHJProduct.name = newProductName
                cdDisplayableProduct.hjProduct = cdHJProduct
            }

            saveContext()
            newProductName = ""
        }
    }

    private func deleteProducts(offsets: IndexSet) {
        withAnimation {
            offsets.map { cdDisplayableProducts[$0] }.forEach(viewContext.delete)
            saveContext()
        }
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

enum ProductType: String, CaseIterable {
    case tProduct = "TProduct"
    case hjProduct = "HJProduct"
}

//struct DisplayableProductListView_Previews: PreviewProvider {
//    static var previews: some View {
//        DisplayableProductListView()
//            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
