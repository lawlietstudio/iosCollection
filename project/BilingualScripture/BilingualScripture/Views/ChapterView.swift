import SwiftUI

struct ChapterView: View {
    @State private var chapters: [Chapter] = []
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 5)

    var body: some View {
        NavigationStack {
            Text("1-ne")
            LazyVGrid(columns: columns) {
                ForEach(chapters) { chapter in
                    NavigationLink(destination: ScriptureView(chapter: chapter)) {
                        Text("\(chapter.number)")
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                    }
                }
            }
            .onAppear {
                loadChapters()
            }
        }
    }
    
    func loadChapters() {
        guard let fileUrl = Bundle.main.url(forResource: "1-ne", withExtension: "json", subdirectory: "Scriptures/BookOfMormon") else {
            print("File '1-ne.json' not found in the bundle.")
            return
        }

        do {
            let data = try Data(contentsOf: fileUrl)
            let book = try JSONDecoder().decode(Book.self, from: data)
            chapters = book.chapters
        } catch {
            print("Error loading chapters: \(error)")
        }
    }
}

struct ChapterView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterView()
    }
}
