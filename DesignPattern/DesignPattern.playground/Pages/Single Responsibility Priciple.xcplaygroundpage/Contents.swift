import Foundation

// A class should only have one reason to change
// Separation of concerns - different classes handling different, independent tasks/problems

class Journal: CustomStringConvertible
{
    var entries = [String]()
    var count = 0
    
    func addEntry(_ text: String) -> Int
    {
        count += 1
        entries.append("\(count): \(text)")
        return count - 1
    }
    
    func removeEntry(_ index: Int)
    {
        entries.remove(at: index)
        
    }
    
    var description: String
    {
        return entries.joined(separator: "\n")
    }
    
    func save(_ filename: String, _ overwirte: Bool = false)
    {
        // save to a file
    }
    
    func load(_ filename: String)
    {
        
    }
    
    func load(_ uri: URL)
    {
        
    }
}

class Persistence
{
    func saveToFile(_ journal: Journal, _ filename: String, _ overwirte: Bool = false)
    {
        print("saved journal\"\(journal)\" to \(filename)")
    }
}

// Separatation of concern
func main()
{
    let j = Journal()
    let _ = j.addEntry("I cried today")
    let bug = j.addEntry("I ate a bug")
    print(j)
    
    j.removeEntry(bug)
    print("===")
    print(j)
    
    let p = Persistence()
    let fileName = "/dir/filename"
    p.saveToFile(j, fileName)
}

main()
