//
//  ContentView1.swift
//  SkeletonLoadingAnimation
//
//  Created by mark on 2025-04-15.
//

import SwiftUI

struct ContentView1: View {
    
    @State private var card: Card?
    
    var body: some View {
        VStack {
            if let card {
                CardView(card: card)
            } else {
                CardView(card: .mock)
                    .skeleton(isRedacted: true)
            }
            
            Spacer()
        }
        .onTapGesture {
            withAnimation(.smooth) {
                card = .cardData
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
    }
}

struct CardView: View {
    var card: Card
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Rectangle()
                .foregroundStyle(.clear)
                .overlay {
                    Image(card.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                .frame(height: 220)
                .clipped()
            
            VStack(alignment: .leading, spacing: 6) {
                Text(card.title)
                    .fontWeight(.semibold)
                
                Group {
                    Text(card.subTitle)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)
                }
                .padding(.trailing, 30)
                
                ZStack {
                    Text(card.description)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                .frame(height: 50)
                .lineLimit(3)
            }
            .padding([.horizontal, .top], 15)
            .padding(.bottom, 25)
        }
        .background(.background)
        .clipShape(.rect(cornerRadius: 15))
        .shadow(color: .black.opacity(0.1), radius: 10)
    }
}

#Preview {
    ContentView1()
}
