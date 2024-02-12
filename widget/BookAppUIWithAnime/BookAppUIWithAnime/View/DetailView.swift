//
//  DetailView.swift
//  BookAppUIWithAnime
//
//  Created by mark on 2023-07-05.
//

import SwiftUI

struct DetailView: View {
    /// View Properties
    @Binding var show: Bool
    var animation: Namespace.ID
    var book: Book
    
    /// Since we use identity transition to display the detail view, it will not animate the view with opacity animation, so we're creating other state variables to animate the contents explicitly
    @State private var animatoinContent: Bool = false
    @State private var offsetAnimation: Bool = false
    
    var body: some View {
        VStack(spacing: 15)
        {
            /// Close Button
            Button {
                withAnimation(.easeOut(duration: 0.2)) {
                    offsetAnimation = false
                }
                
                /// Closing Detail View
                withAnimation(.easeInOut(duration: 0.35).delay(0.1)) {
                    animatoinContent = false
                    show = false
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .contentShape(Rectangle())
            }
            .padding([.leading, .vertical], 15)
            .frame(maxWidth: .infinity, alignment: .leading)
            .opacity(animatoinContent ? 1 : 0)
            
            /// Book Preview (With Matched Geometry Effect)
            GeometryReader {
                let size = $0.size
                
                HStack(spacing: 20) {
                    Image(book.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        /// Since padding horizontal is 15, which means 15 on the left and 15 on the right, the total is 30
                        .frame(width: (size.width - 30) / 2, height: size.height)
                        /// Custom Corner Shape
                        .clipShape(CustomCorners(corners: [.topRight, .bottomRight], radius: 20))
                        /// Matched Geometry ID
                        .matchedGeometryEffect(id: book.id, in: animation)
                    
                    /// Book Details
                    VStack(alignment: .leading, spacing: 8) {
                        Text(book.title)
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text("By \(book.author)")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        /// Rating View
                        RatingView(rating: book.rating)
                    }
                    .padding(.trailing, 15)
                    .padding(.top, 30)
                    .offset(y: offsetAnimation ? 0 : 100)
                    .opacity(offsetAnimation ? 1 : 0)
                }
            }
            .frame(height: Home.cardHeight)
            /// Placing it Above
            .zIndex(1)
            
            Rectangle()
                .fill(.gray.opacity(0.04))
                .ignoresSafeArea()
                .overlay(alignment: .top, content: {
                    BookDetails()
                })
                .padding(.leading, 30)
                /// Since we applied the negative padding to move the view up, we need to add the same padding in order to avoid view overlapping
                .padding(.top, -180)
                .zIndex(0)
                .opacity(animatoinContent ? 1 : 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background {
            Rectangle()
                .fill(.white)
                .ignoresSafeArea()
                .opacity(animatoinContent ? 1 : 0)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.35))
            {
                animatoinContent = true
            }
            withAnimation(.easeInOut(duration: 0.35).delay(0.1))
            {
                offsetAnimation = true
            }
            /// The book details use different animations rather than opacity ones, so why a new variable? Since we need to display the details with a little delay, we introduced a new state rather than mixing the old one.
        }
    }
    
    @ViewBuilder
    func BookDetails() -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Button {
                    
                } label: {
                    Label("Reviews", systemImage: "text.alignleft")
                        .font(.callout)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                
                Button {
                    
                } label: {
                    Label("Like", systemImage: "suit.heart")
                        .font(.callout)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                
                Button {
                    
                } label: {
                    Label("Share", systemImage: "square.and.arrow.up")
                        .font(.callout)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
            }
            
            Divider()
                .padding(.top, 25)
            
            ScrollView(.vertical, showsIndicators: false)
            {
                VStack(spacing: 15) {
                    Text("About the book")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    /// Dummy Book Detail
                    Text("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a")
                        .font(.callout)
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 15)
                .padding(.top, 20)
            }
            
            /// Read Now Button
            Button {
                
            } label: {
                Text("Read Now")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 45)
                    .padding(.vertical, 10)
                    .background {
                        Capsule()
                            .fill(Color("Blue").gradient)
                    }
                    .foregroundColor(.white)
            }
            .padding(.vertical, 15)
        }
        .padding(.top, 180)
        .padding([.horizontal, .top], 15)
        /// Applying Offset Animation
        .offset(y: offsetAnimation ? 0 : 100)
        .opacity(offsetAnimation ? 1 : 0)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
