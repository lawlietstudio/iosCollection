//: [Previous](@previous)

import Foundation

enum Color
{
    case red
    case green
    case blue
}

enum Size
{
    case small
    case medium
    case large
    case huge
}

class Product: CustomStringConvertible
{
    var name: String
    var color: Color
    var size: Size
    
    init(_ name: String, _ color: Color, _ size: Size) {
        self.name = name
        self.color = color
        self.size = size
    }
    
    var description: String {
        return "\(name) \(color) \(size)"
    }
}

class ProductFilter
{
    func filterByColor(_ products: [Product], _ color: Color) -> [Product] {
        return products.filter({ $0.color == color })
    }
}

// Open for extension, Close for modification
func main()
{
    let pf = ProductFilter()
    let filteredProduct = pf.filterByColor([Product("P1", .blue, .huge), Product("P2", .green, .small)], .green)
    for product in filteredProduct {
        print(product)
    }
}

main()

//: [Next](@next)
