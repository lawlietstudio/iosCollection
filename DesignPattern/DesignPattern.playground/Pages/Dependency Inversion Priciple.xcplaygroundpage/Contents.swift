//: [Previous](@previous)

import Foundation

// High Level Module should not depend on low level module, both should depend on abstractions

enum Relationship
{
    case parent
    case child
    case sibling
}

class Person
{
    var name = ""
    init(_ name: String) {
        self.name = name
    }
}

protocol RelationshipBrowser
{
    func findAllChildrenOf(_ name: String) -> [Person]
}

class Relationships: RelationshipBrowser // low-level
{
    // this should be private
    var relations = [(Person, Relationship, Person)]()
    
    func addParentAndChild(_ p: Person, _ c: Person)
    {
        relations.append((p, .parent, c))
        relations.append((c, .child, p))
    }
    
    func findAllChildrenOf(_ name: String) -> [Person] {
//        var result: [Person] = []
//        for r in relations where r.0.name == "John" && r.1 == .parent
//        {
//            result.append(r.2)
//        }
//        return result
        return relations.filter({ $0.name == name && $1 == .parent  && $2 === $2})
            .map({ $2 })
    }
}

class Research // high-level
{
//    init(_ relationships: Relationships)
//    {
//        let relations = relationships.relations
//        for r in relations where r.0.name == "John" && r.1 == .parent
//        {
//            print("John has a child called \(r.2.name)")
//        }
//    }
    
    init(_ browser: RelationshipBrowser)
    {
        for r in browser.findAllChildrenOf("John")
        {
            print("John has a new child called \(r.name)")
        }
    }
}

func main()
{
    let parent = Person("John")
    let child1 = Person("Chris")
    let child2 = Person("Matt")
    
    let relationships = Relationships()
    relationships.addParentAndChild(parent, child1)
    relationships.addParentAndChild(parent, child2)
    
    let _ = Research(relationships)
}

main()

//: [Next](@next)
