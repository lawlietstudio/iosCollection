import Foundation

struct Chapter: Identifiable, Decodable {
    var id: Int { number }
    let number: Int
    let introduction: MultilingualText
    let verses: [Verse]
}

struct Verse: Identifiable, Decodable {
    var id: String { key }
    let key: String
    let text: MultilingualText
}

struct MultilingualText: Decodable {
    let en: String
    let zh: String
}

// Usage within Book or Scripture structure
struct Book: Decodable {
    let chapters: [Chapter]
}
