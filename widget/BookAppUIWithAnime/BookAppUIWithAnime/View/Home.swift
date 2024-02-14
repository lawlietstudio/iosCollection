//
//  Home.swift
//  BookAppUIWithAnime
//
//  Created by mark on 2023-07-04.
//

import SwiftUI

struct Home: View {
    static let cardHeight: CGFloat = 320
    /// View Properties
    @State private var activeTag: String = "Biography"
    @State private var carouselMode: Bool = false
    /// For Matched Geometry Effect
    @Namespace private var animation
    /// Detail View Properties
    @State private var showDetailView: Bool = false
    @State private var selectedBook: Book?
    @State private var animationCurrentBook: Bool = false
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Text("Browse")
                    .font(.largeTitle.bold())
                
                Text("Recommended")
                    .fontWeight(.semibold)
                    .padding(.leading, 15)
                    .foregroundColor(.gray)
                    .offset(y: 2)
                
                Spacer(minLength: 10)
                
                Menu {
                    Button("Toggle Carousel Mode (\(carouselMode ? "On" : "Off"))")
                    {
                        carouselMode.toggle()
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .rotationEffect(.init(degrees: -90))
                        .foregroundColor(.gray)
                }

            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 15)
            
            TagsView()
            
            GeometryReader {
                let size = $0.size
                
                ScrollView(.vertical, showsIndicators: false) {
                    /// Books Card View
                    VStack(spacing: 35) {
                        ForEach(sampleBooks)
                        {
                            book in
                            BookCardView(book)
                            /// Opening Detail View, When Ever Card is Tapped
                                .onTapGesture {
                                    withAnimation(.easeInOut(duration: 0.2))
                                    {
                                        animationCurrentBook = true
                                        selectedBook = book
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7))
                                        {
                                            showDetailView = true
                                        }
                                    }
                                }
                        }
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 20)
                    .padding(.bottom, bottomPadding(size))
                    .background {
                        ScrollViewDetector(carouselMode: $carouselMode, totalCardCount: sampleBooks.count)
                    }
                }
                /// Since we need offset from here and not from global View
                .coordinateSpace(name: "SCROLLVIEW")
                
            }
            .padding(.top, 15)
        }
        .overlay {
            if let selectedBook, showDetailView
            {
                DetailView(show: $showDetailView, animation: animation, book: selectedBook)
                /// For More Fluent Animation Transition
                    .transition(.asymmetric(insertion: .identity, removal: .offset(y: 5)))
            }
        }
        .onChange(of: showDetailView) { newValue in
            if !newValue {
                /// Resetting Book Animation
                /// When the detail view is closed, the book offset is rest to zero (this why the delay is used)
                withAnimation(.easeInOut(duration: 0.15).delay(0.4))
                {
                    animationCurrentBook = false
                }
            }
        }
    }
    
    /// Bottom Padding for last card to move up to the top
    func bottomPadding(_ size: CGSize = .zero) -> CGFloat {
        let cardHeight: CGFloat = Home.cardHeight
        let scrollViewHeight: CGFloat = size.height
        
        /*
            Thus, we need to show the last card, so we're removing one card's height from the scrollview total height
            That -20 came from the vertical padding of 20, so if we remove the 40 (vertical padding 20), then we will have the top stating point, which is 20
         */
        return scrollViewHeight - cardHeight - 40
    }
    
    /// Book Card View
    @ViewBuilder
    func BookCardView(_ book: Book) -> some View {
        GeometryReader {
            let size = $0.size
            let rect = $0.frame(in: .named("SCROLLVIEW"))
            
            /// Rotation Animation Based on Scroll Position
            // let minY = rect.minY
            
            HStack(spacing: -25) {
                /// Book Detail Card
                VStack(alignment: .leading, spacing: 6) {
                    Text(book.title)
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text("By \(book.author)")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    /// Rating View
                    RatingView(rating: book.rating)
                    
                    Spacer(minLength: 10)
                    
                    HStack(spacing: 4) {
                        Text("\(book.bookViews)")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                        
                        Text("Views")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Spacer(minLength: 0)
                        
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .padding(20)
                .frame(width: size.width / 2, height: size.height * 0.8)
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
                    /// Applying Shadow
                        .shadow(color: .black.opacity(0.08), radius: 8, x: 5, y: 5)
                        .shadow(color: .black.opacity(0.08), radius: 8, x: -5, y: -5)
                }
                .zIndex(1)
                /// Moving the book, if it's tapped
                .offset(x: animationCurrentBook && selectedBook?.id == book.id ? -20 : 0)
//                .overlay {
//                    Text("\(minY)")
//                }
                
                /// Book Cover Image
                ZStack {
                    if !(showDetailView && selectedBook?.id == book.id) {
                        Image(book.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width / 2, height: size.height)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            /// Matched Geometry ID
                            .matchedGeometryEffect(id: book.id, in: animation)
                            /// Applying Shadow
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                            .shadow(color: .black.opacity(0.1), radius: 5, x: -5, y: -5)
                    }
                }
            }
            .frame(width: size.width)
            .rotation3DEffect(.init(degrees: convertOffsetToRotation(rect)), axis: (x: 1, y: 0, z:0), anchor: .bottom, anchorZ: 1, perspective: 0.8)
        }
        .frame(height: Home.cardHeight)
    }
    
    /// Converting MinY to Rotation
    func convertOffsetToRotation(_ rect: CGRect) -> CGFloat {
        /*
            That's because since we removed 20 from the minY, we need to add it to the
            height in order to get the proper rotation complete
         */
        let cardHeight = rect.height + 20
        let minY = rect.minY - 20
        /*
            As we don't want to do any rotation for any other cards,
            we only need to do with the first one, so when the offset ges beyond zero,
            we're applying rotation animation to the card
         */
        let progress = minY < 0 ? (minY / cardHeight) : 0
        /*
            Limiting progress from 0 to 1, since our offset is negative value,
            thus converting into a positive one
         */
        let constrainedProgress = min(-progress, 1.0)
        return constrainedProgress * 90
    }
    
    /// Tage View
    @ViewBuilder
    func TagsView() -> some View {
        ScrollView(.horizontal, showsIndicators: false)
        {
            HStack(spacing: 10) {
                ForEach(tags, id: \.self) {
                    tag in
                    Text(tag)
                        .font(.caption)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .background {
                            if (activeTag == tag)
                            {
                                Capsule()
                                    .fill(Color("Blue"))
                                    .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                            }
                            else {
                                Capsule()
                                    .fill(.gray.opacity(0.2))
                            }
                        }
                        .foregroundColor(activeTag == tag ? .white : .gray)
                        .onTapGesture {
                            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.7))
                            {
                                activeTag = tag
                            }
                        }
                }
            }
            .padding(.horizontal, 15)
        }
    }
}

var tags: [String] = ["History", "Classical", "Biography", "Cartoon", "Adventure", "Fairy tales", "Fantasy"]

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
