//
//  ContentView.swift
//  SampleAPICall
//
//  Created by mark on 2023-04-15.
//

import SwiftUI

struct ContentView: View {
    @State private var posts: [Post] = []
    @State private var isLoading = true
    
    var body: some View {
        if isLoading {
            ProgressView("Loading...")
                .onAppear {
                    DataService().fetchPosts { posts in
                        self.posts = posts
                        self.isLoading = false
                    }
                }
        } else {
            List(posts, id: \.id) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .font(.subheadline)
                }
            }
        }
    }
}

class DataService {
    func fetchPosts(completionHandler: @escaping ([Post]) -> Void) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                let posts = try decoder.decode([Post].self, from: data)
                completionHandler(posts)
            } catch {
                print(error)
            }
        }.resume()
    }
}

struct Post: Codable {
    let id: Int
    let title: String
    let body: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
