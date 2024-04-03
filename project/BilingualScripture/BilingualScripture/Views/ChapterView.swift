import SwiftUI

struct ChapterView: View {
    let fileName: String = "1-ne"
    
    @State private var book: Book = Book(book: MultilingualText(en: "", zh: ""), theme: MultilingualText(en: "", zh: ""), introduction: MultilingualText(en: "", zh: ""), chapters: [])
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 5)

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    SpeakButton(text: book.book.en, speechLang: .en, font: .title)
                    
                    SpeakButton(text: book.book.zh, speechLang: .zh, font: .title)
                    
                    SpeakButton(text: book.theme.en, speechLang: .en, font: .title3)
                    
                    SpeakButton(text: book.theme.zh, speechLang: .zh, font: .title3)
                    
//                    SpeakButton(text: book.introduction.en, speechLang: .en, font: .body)
//                    
//                    SpeakButton(text: book.introduction.zh, speechLang: .zh, font: .body)
                    
                    LazyVGrid(columns: columns) {
                        ForEach(book.chapters) { chapter in
                            NavigationLink(destination: ScriptureView(chapter: chapter)) {
                                Text("\(chapter.number)")
                                    .frame(minWidth: 50, maxWidth: .infinity, minHeight: 50)
                                    .foregroundColor(.black)
                                    .background(.white)
                                    .cornerRadius(20)
                                    .shadow(radius: 2)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding()
            }
            .onAppear {
                loadChapters()
            }
        }
    }
    
    func loadChapters() {
        guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "json", subdirectory: "Scriptures/BookOfMormon") else {
            print("File \(fileName) not found in the bundle.")
            return
        }

        do {
            let data = try Data(contentsOf: fileUrl)
            let book = try JSONDecoder().decode(Book.self, from: data)
            self.book = book
        } catch {
            print("Error loading chapters: \(error)")
        }
    }
}
