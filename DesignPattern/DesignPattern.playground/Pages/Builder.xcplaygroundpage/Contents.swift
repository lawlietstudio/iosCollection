import Foundation

// Some objects are simple and can be created in a single initializer call
// Other objects require a lot of ceremony to create
// Having an object with 10 initializer arguments is not productive
// instead, opt for piecewise construction
// Budiler provides an API for constructing an object step-by-step

// When piecewise object construction is complicated, provide an API for doing it succinctly


class HtmlElement: CustomStringConvertible
{
    var name = ""
    var text = ""
    var elements = [HtmlElement]()
    
    private let indentSize = 2
    
    init()
    {
        
    }
    
    init(name: String, text: String) {
        self.name = name
        self.text = text
    }
    
    private func description(_ indent: Int) -> String
    {
        var result = ""
        let i = String(repeating: " ", count: indent)
        result += "\(i)<\(name)>\n"
        
        if !text.isEmpty
        {
            result += String(repeating: " ", count: (indent + 1))
            result += text
            result += "\n"
        }
        
        for e in elements
        {
            result += e.description(indent+1)
        }
        
        result += "\(i)</\(name)>\n"
        
        return result
    }
    
    public var description: String
    {
        return description(0)
    }
}

class HtmlBuilder: CustomStringConvertible
{
    private let rootName: String
    var root = HtmlElement()
    
    init(rootName: String)
    {
        self.rootName = rootName
        root.name = rootName
    }
    
    func addChild(name: String, text: String)
    {
        let e = HtmlElement(name: name, text: text)
        root.elements.append(e)
    }
    
    // for chain function
    func addChildFluent(name: String, text: String) -> Self
    {
        let e = HtmlElement(name: name, text: text)
        root.elements.append(e)
        return self
    }
    
    var description: String
    {
        return root.description
    }
    
    func clear()
    {
        root = HtmlElement(name: rootName, text: "")
    }
}

func main()
{
    let hello = "hello"
    var result = "<p>\(hello)</p>"
    print(result)
    
    let words = ["hello", "world"]
    result = "<ul>\n"
    for word in words
    {
        result.append("<li>\(word)</li>\n")
    }
    result.append("</ul>")
    
    print(result)
    
    let builder = HtmlBuilder(rootName: "ul")
    builder.addChildFluent(name: "li", text: "hello")
           .addChildFluent(name: "li", text: "world")
    print(builder)
}

main()

// Faceted Builder
class Person : CustomStringConvertible
{
    // address
    var streetAddress = "", postcode = "", city = ""
    
    // employment
    var companyName = "", position = ""
    var annualIncome = 0
    
    var description: String
    {
        return "I live at \(streetAddress), \(postcode), \(city). I work at \(companyName) as a \(position), earning \(annualIncome)."
    }
}

class PersonBuilder
{
    var person = Person()
    var lives : PersonAddressBuilder
    {
        return PersonAddressBuilder(person)
    }
    
    var works : PersonJobBuilder
    {
        return PersonJobBuilder(person)
    }
    
    func build() -> Person
    {
        return person
    }
}

class PersonAddressBuilder : PersonBuilder
{
    internal init(_ person: Person)
    {
        super.init()
    }
    func at(_ streetAddress: String) -> PersonAddressBuilder
    {
        person.streetAddress = streetAddress
        return self
    }
    func withPostcode(_ postcode: String) -> PersonAddressBuilder
    {
        person.postcode = postcode
        return self
    }
    func inCity(_ city: String) -> PersonAddressBuilder
    {
        person.city = city
        return self
    }
}

class PersonJobBuilder : PersonBuilder
{
    internal init(_ person: Person)
    {
        super.init()
        self.person = person
    }
    
    func at(_ companyName: String) -> PersonJobBuilder
    {
        person.companyName = companyName
        return self
    }
    
    func asA(_ position: String) -> PersonJobBuilder
    {
        person.position = position
        return self
    }
    
    func earning(_ annualIncome: Int) -> PersonJobBuilder
    {
        person.annualIncome = annualIncome
        return self
    }
}

func main2()
{
    let pb = PersonBuilder()
    let p = pb
            .lives.at("123 London Road")
                  .inCity("London")
                  .withPostcode("Sw12BC")
            .works.at("Fabrikam")
                  .asA("Engineer")
                  .earning(123000)
            .build()
    print(p)
}

main2()

