//
//  DataController.swift
//  20231226CoreDataMany
//
//  Created by mark on 2023-12-26.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    // The persistent container
    let container: NSPersistentContainer

    // Initializer
    init() {
        container = NSPersistentContainer(name: "ProductModel") // Use your model file name

        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                // Handle errors in development.
                fatalError("Unresolved error \(error)")
            }
        }
    }
    
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this with proper error handling.
                fatalError("An error occurred while saving: \(error)")
            }
        }
    }

    func convertToCDTProduct(tProduct: TProduct, context: NSManagedObjectContext) -> CDTProduct {
        let cdtProduct = CDTProduct(context: context)
        cdtProduct.name = tProduct.name
        return cdtProduct
    }

    func convertToTProduct(cdtProduct: CDTProduct) -> TProduct {
        return TProduct(name: cdtProduct.name ?? "")
    }
}
