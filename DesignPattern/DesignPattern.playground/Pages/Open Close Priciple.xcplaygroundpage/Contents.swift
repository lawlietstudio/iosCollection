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
        var result = [Product]()
        for p in products
        {
            if p.color == color
            {
                result.append(p)
            }
        }
        return result
        // return products.filter({ $0.color == color })
    }
    
    func filterBySize(_ products: [Product], _ size: Size) -> [Product] {
        var result = [Product]()
        for p in products
        {
            if p.size == size
            {
                result.append(p)
            }
        }
        return result
        // return products.filter({ $0.size == size })
    }
    
    func filterBySizeAndColor(_ products: [Product], _ size: Size, _ color: Color) -> [Product] {
        var result = [Product]()
        for p in products
        {
            if (p.size == size) && (p.color == color)
            {
                result.append(p)
            }
        }
        return result
        // return products.filter({ $0.size == size })
    }
}

// Specification (Specification Design Pattern)
protocol Specification
{
    associatedtype T
    func isSatisfied(_ item: T) -> Bool
}

protocol Filter
{
    associatedtype T
    func filter<Spec: Specification>(_ items: [T], _ spec: Spec) -> [T]
    where Spec.T == T;
}

class ColorSpecification : Specification
{
    typealias T = Product
    let color: Color
    
    init(_ color: Color)
    {
        self.color = color
    }
    
    func isSatisfied(_ item: Product) -> Bool {
        return item.color == color
    }
}

class SizeSpecification : Specification
{
    typealias T = Product
    let size: Size
    
    init(_ size: Size)
    {
        self.size = size
    }
    
    func isSatisfied(_ item: Product) -> Bool {
        return item.size == size
    }
}

class AndSpecification<T, SpecA: Specification, SpecB: Specification> : Specification
where SpecA.T == SpecB.T, T == SpecA.T, T == SpecB.T
{
    func isSatisfied(_ item: T) -> Bool {
        return first.isSatisfied(item) && second.isSatisfied(item)
    }

    let first: SpecA
    let second: SpecB

    init(_ first: SpecA, _ second: SpecB)
    {
        self.first = first
        self.second = second
    }
}


//class BetterFilter: Filter
//{
//    typealias T = Product
//
//    func filter<Spec: Specification>(_ items: [Product], _ spec: Spec) -> [T]
//    where Spec.T == T
//    {
//        var result = [Product]()
//        for i in items
//        {
//            if spec.isSatisfied(i)
//            {
//                result.append(i)
//            }
//        }
//        return result
//    }
//}

class BetterFilter
{
    typealias T = Product
    
    func filter<Spec: Specification>(_ items: [Product], _ spec: Spec) -> [T]
    where Spec.T == T
    {
        var result = [Product]()
        for i in items
        {
            if spec.isSatisfied(i)
            {
                result.append(i)
            }
        }
        return result
    }
}

// Open for extension, Close for modification
// if you are extending the functionality, you are adding new class (specification), but not modifying old class (filter)
func main()
{
    /*
    let pf = ProductFilter()
    let filteredProduct = pf.filterByColor([Product("P1", .blue, .huge), Product("P2", .green, .small)], .green)
    for product in filteredProduct {
        print(product)
    }
    */
    
    let apple = Product("Apple", .green, .small)
    let tree = Product("Tree", .green, .large)
    let house = Product("House", .blue, .large)
    
    let products = [apple, tree, house]
    
    let pf = ProductFilter()
    print("Green products (old):")
    for p in pf.filterByColor(products, .green)
    {
        print(" - \(p.name) is green")
    }
    
    let bf = BetterFilter()
    print("Green products (new):")
    for p in bf.filter(products, ColorSpecification(.green))
    {
        print(" - \(p.name) is green")
    }
    
    print("Blue and large products (new):")
    for p in bf.filter(products, AndSpecification(ColorSpecification(.blue), SizeSpecification(.large)))
    {
        print(" - \(p.name) is blue and large")
    }
}

main()

//: [Next](@next)
