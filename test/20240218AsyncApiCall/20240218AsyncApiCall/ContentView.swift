//
//  ContentView.swift
//  20240218AsyncApiCall
//
//  Created by Mark Ho on 18/2/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .onAppear() {
            Task {
                do {
                    let data = try await fetchData()
                    
                    print("Data: \(data)")
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
        .padding()
    }
    
    func fetchData() async throws -> Post {
        let urlString = "https://jsonplaceholder123.typicode.com/posts/1"
//        let urlString = "https://jsonplaceholder.typicode.com/posts/1"
        
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let post = try JSONDecoder().decode(Post.self, from: data)
        return post
    }
}

#Preview {
    ContentView()
}
