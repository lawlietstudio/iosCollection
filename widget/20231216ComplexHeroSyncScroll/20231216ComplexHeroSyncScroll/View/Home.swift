//
//  Home.swift
//  20231216ComplexHeroSyncScroll
//
//  Created by mark on 2023-12-16.
//

import SwiftUI

struct Home: View {
    /// View properties
    @State private var posts: [Post] = samplePosts
    @State private var showDetailView: Bool = false
    @State private var selectedPicID: UUID?
    @State private var selectedPost: Post?
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(spacing: 15) {
                    ForEach(posts) {
                        post in
                        CardView(post)
                    }
                }
                .safeAreaPadding(15)
//                .padding(15)
            }
            .navigationTitle("Animation")
        }
        .overlay {
            if let selectedPost, showDetailView {
                DetailView(isOnlinePic: Post.isOnlinePic,
                           showDetailView: $showDetailView,
                           post: selectedPost,
                           selectedPicID: $selectedPicID)
                {
                    id in
                    /// Updating Scroll Position
                    if let index = posts.firstIndex(where: { $0.id == selectedPost.id }) {
                        posts[index].scrollPosition = id
                    }
                }
                    /// You can also use the identity transition here.
                    .transition(.offset(y: 5))
            }
        }
    }
    
    /// Card View
    func CardView(_ post: Post) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                Image(systemName: "person.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.teal)
                    .frame(width: 30, height: 30)
                    .background(.background)
                
                VStack(alignment: .leading, spacing: 4, content: {
                    Text(post.username)
                        .fontWeight(.semibold)
                        .textScale(.secondary)
                    
                    Text(post.content)
                })
                
                Spacer(minLength: 0)
                
                Button("", systemImage: "ellipsis") {
                    
                }
                .foregroundStyle(.primary)
                .offset(y: -10)
            }
            
            /// Image Carousel Using New ScrollView(iOS 17+)
            VStack(alignment: .leading, spacing: 10) {
                GeometryReader {
                    let size = $0.size
                    
                    /*
                     Adding padding on the leading side so that the scrollview exactly aligns with the title and the description
                     
                     Another way: You can simply put the scrollview inside the VStack, which is in the HStack, and disabling the scroll clip will result in the same UI.
                     */
                    ScrollView(.horizontal) {
                        /*
                            As you can see, the scrollview is having some problems when using the LazyHStack. To solve this, change LazyHStack to the normal HStack and add LazyStack to each component inside the ForEach Loop, which will has the same behavior as the entire LazyHStack
                         */
                        LazyHStack(spacing: 10) {
                            ForEach(post.pics) { pic in
//                                LazyHStack {
                                    if Post.isOnlinePic {
                                        AsyncImage(url: URL(string: pic.image)) {
                                            phase in
                                            if let image = phase.image {
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                            }
                                        }
                                        .frame(maxWidth: size.width)
                                        .clipShape(.rect(cornerRadius: 10))
                                        .onTapGesture {
                                            selectedPost = post
                                            selectedPicID = pic.id
                                            showDetailView = true
                                        }
                                        .contentShape(.rect)
                                    }
                                    else {
                                        Image(pic.image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(maxWidth: size.width)
                                            .onTapGesture {
                                                selectedPost = post
                                                selectedPicID = pic.id
                                                showDetailView = true
                                            }
                                            .clipShape(.rect(cornerRadius: 10))
                                    }
//                                }
//                                .frame(maxWidth: size.width)
//                                .frame(height: size.height)
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollPosition(id: .init(get: {
                        /// We don't need this position to be updated for a detailed view since the image ID is directly stored when the image is tapped
                        return post.scrollPosition
                    }, set: { _ in
                        
                    }))
                    .scrollIndicators(.hidden)
                    .scrollTargetBehavior(.viewAligned)
                    .scrollClipDisabled()
                }
                .frame(height: 200)
                
                /// Image Buttons
                HStack(spacing: 10) {
                    ImageButton("suit.heart") {
                        
                    }
                    
                    ImageButton("suit.heart") {
                        
                    }
                    
                    ImageButton("suit.heart") {
                        
                    }
                    
                    ImageButton("suit.heart") {
                        
                    }
                }
                
                
            }
            .padding(.leading, 40)
            
            /// Adding a vertical line between the two profile images
            
            /// LIkes & Replies
            HStack(spacing: 15) {
                Image(systemName: "person.circle.fill")
                    .frame(width: 30, height: 30)
                    .background(.background)
                
                Button("10 replies") {
                    
                }
                
                Button("810 likes") {
                    
                }
                .padding(.leading, -5)
                
                Spacer()
            }
            .textScale(.secondary)
            .foregroundStyle(.secondary)
        }
        .background(alignment: .leading) {
            Rectangle()
                .fill(.secondary)
                .frame(width: 1)
                .padding(.bottom, 30)
                .offset(x: 15, y: 10)
        }
    }
    
    @ViewBuilder
    func ImageButton(_ icon: String, onTap: @escaping () -> ()) -> some View {
        Button("", systemImage: icon, action: onTap)
            .font(.title3)
            .foregroundStyle(.primary)
    }
}

#Preview {
    Home()
}

struct DetailView: View {
    let isOnlinePic: Bool
    @Binding var showDetailView: Bool
    var post: Post
    @Binding var selectedPicID: UUID?
    var updatedScrollPosition: (UUID?) -> ()
    /// View Properties
    @State private var detailScrollPosition: UUID?
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                ForEach(post.pics) { pic in
                    if isOnlinePic {
                        AsyncImage(url: URL(string: pic.image)) {
                            phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
                        .containerRelativeFrame(.horizontal)
                    }
                    else {
                        Image(pic.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .containerRelativeFrame(.horizontal)
                    }
                }
            }
            .scrollTargetLayout()
        }
        /// store the scroll position into $detailScrollPosition
        .scrollPosition(id: $detailScrollPosition)
        .background(.black)
        .scrollTargetBehavior(.paging)
        .scrollIndicators(.hidden)
        /// Close Button
        .overlay(alignment: .topLeading) {
            Button("", systemImage: "xmark.circle.fill") {
                updatedScrollPosition(detailScrollPosition)
                showDetailView = false
                selectedPicID = nil
            }
            .font(.title)
            .foregroundStyle(.white.opacity(0.8), .white.opacity(0.15))
            .padding()
        }
        .onAppear {
            /// This will make the carousel start from the tapped image in the tree view
            guard detailScrollPosition == nil else { return }
            detailScrollPosition = selectedPicID
        }
    }
}
