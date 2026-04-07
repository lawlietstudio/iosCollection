//
//  Home.swift
//  ScrollViewWithDynamicSections
//
//  Created by mark on 2025-05-13.
//

import SwiftUI

struct Home: View {
    // MARK: View Properties
    @State var characters: [Character] = []

    // MARK: Gesture Properties
    @GestureState var isDragging: Bool = false
    /*
     How Come It's Bouncing?
     Because DragGesture's Update() Method is finishing before our animation, which is 0.2s, as a workaround we're creating a new @State which will delay its finish by 0.25s
    */
    @State var isDrag: Bool = false
    @State var offsetY: CGFloat = 0
    
    @State var currentActiveIndex: Int = 0
    @State var startOffset: CGFloat = 0
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ScrollView(.vertical) {
                    VStack(spacing: 0) {
                        // MARK: Sample Contacts View
                        ForEach(characters) { character in
                            ContactsForCharacter(character: character)
                                .id(character.index)
                        }
                    }
                    .padding(.top, 15)
                    .padding(.trailing, 100)
                }
                .scrollIndicators(.never)
                .onChange(of: currentActiveIndex) { oldValue, newValue in
                    // MARK: Scrolling to Current Index
                    // This is also happening at the same time, that's why it's not scrolling
                    if isDrag {
                        withAnimation(.easeInOut(duration: 0.15)) {
                            proxy.scrollTo(currentActiveIndex, anchor: .top)
                        }
                    }
                }
            }
            .navigationTitle("Contact's")
            .offset { offsetRect in
                if offsetRect.minY != startOffset {
                    startOffset = offsetRect.minY
                }
            }
        }
        // MARK: Why Overlay
        // Because We Don't want to CUt down the Navigation Stack header Blur View
        .overlay(alignment: .trailing, content: {
            CustomScroller()
                .padding(.top, 35)
        })
        .onAppear {
            characters = fetchCharacters()
            // MARK: Initial Check
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                characterElevation()
            }
        }
    }
    
    // MARK: Custom Scroller
    @ViewBuilder
    func CustomScroller() -> some View {
        let scroller: String = "SCROLLER"
        // MARK: Geometry Reader For Calclations
        GeometryReader { proxy in
            let rect = proxy.frame(in: .named(scroller))
            
            VStack(spacing: 0) {
                ForEach($characters) { $character in
                    // MARK: To Find Each Alphabet Origin on the Screen
                    HStack(spacing: 15) {
                        GeometryReader { innerProxy in
                            let origin = innerProxy.frame(in: .named(scroller))
                            
                            Text(character.value)
                                .font(.callout)
                                .fontWeight(character.isCurrent ? .bold : .semibold)
                                .foregroundStyle(character.isCurrent ? .black : .gray)
                                .scaleEffect(character.isCurrent ? 1.4 : 0.8)
                                // iOS 16+
                                .contentTransition(.interpolate)
                                .frame(width: origin.size.width, height: origin.size.height, alignment: .trailing)
                                .overlay {
                                    Rectangle()
                                        .fill(.gray)
                                        .frame(width: 15, height: 0.8)
                                        .offset(x: 35)
                                }
                                .offset(x: character.pusOffset)
                                .animation(.easeInOut(duration: 0.2), value: character.pusOffset)
                                .animation(.easeInOut(duration: 0.2), value: character.isCurrent)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        // MARK: Storing Origin
                                        character.rect = origin
                                    }
                                }
                        }
                        .frame(width: 20)
                        
                        // MARK: Displaying Only For First Item (AKA Scroller)
                        ZStack {
                            if characters.first?.id == character.id {
                                ScrollerKnob(character: $character, rect: rect)
                            }
                        }
                        .frame(width: 20, height: 20)
                    }
                }
            }
        }
        .frame(width: 55)
        .padding(.trailing, 10)
        .coordinateSpace(name: scroller)
        .padding(.vertical, 15)
        .background(.white.opacity(0.0000001))
    }
    
    @ViewBuilder
    func ScrollerKnob(character: Binding<Character>, rect: CGRect) -> some View {
        Circle()
            .fill(.black)
            // MARK: Scaling Animation
            .overlay(content: {
                Circle()
                    .fill(.white)
                    .scaleEffect(isDragging ? 0.8 : 0.0001)
            })
            .scaleEffect(isDragging ? 1.35 : 1)
            .animation(.easeInOut(duration: 0.2), value: isDragging)
            .offset(y: offsetY)
            .gesture (
                // MARK: Drag Gesture
                DragGesture(minimumDistance: 0)
                    .updating($isDragging, body: { _, out, _ in
                        out = true
                    })
                    .onChanged({ value in
                        isDrag = true
                        // MARK : Setting Location
                        var translation = value.location.y
                        // MARK: Limiting Translation
                        // Reducing Knob Size
                        translation = min(translation, (rect.maxY - 20))
                        translation = max(translation, rect.minY)
                        offsetY = translation
                        characterElevation()
                    })
                    .onEnded({ value in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            isDrag = false
                        }
                        // MARK: Setting to Last Character Location
                        if characters.indices.contains(currentActiveIndex) {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                offsetY = characters[currentActiveIndex].rect.minY
                            }
                        }
                    })
            )
    }
    
    // MARK: Checking For Character Elevation When Gesture is Started
    func characterElevation() {
        // MARK: We're going to Verify Ofset Lies in the Character Region With the Help of CGRect's Default Contain's Property
        if let index = characters.firstIndex(where: { character in
            character.rect.contains(CGPoint(x: 0, y: offsetY))
        }) {
            updateElevation(index: index)
        }
    }
    
    // MARK: Reusable
    func updateElevation(index: Int) {
        // MARK: Modified Indices Array
        var modifiedIndicies: [Int] = []
        
        // MARK: Updateing Side Offset
        characters[index].pusOffset = -35
        characters[index].isCurrent = true
        currentActiveIndex = index
        modifiedIndicies.append(index)
        
        // MARK: Updating Top And Bottom 3 Offset's In Order To Create a Curve Animation
        // YOUR CUSTOM OFFSETS
        let otherOffsets: [CGFloat] = [-25, -15, -5]
        for index_ in otherOffsets.indices {
            // EG index + 1, Index + 2, Index + 3
            let newIndex = index + (index_ + 1)
            // MARK: Top Indexes (Negative)
            // EG index - 1, Index - 2, Index - 3
            let newIndex_Negative = index - (index_ + 1)
            
            if verifyAndUpdate(index: newIndex, offset: otherOffsets[index_])
            {
                modifiedIndicies.append(newIndex)
            }
            
            if verifyAndUpdate(index: newIndex_Negative, offset: otherOffsets[index_])
            {
                modifiedIndicies.append(newIndex_Negative)
            }
        }
        
        
        // MARK: Setting Remaining all Other Characters Offest to Zero
        for index_ in characters.indices {
            if !modifiedIndicies.contains(index_) {
                characters[index_].pusOffset = 0
                characters[index_].isCurrent = false
            }
        }
    }
    
    // MARK: Safety Check
    func verifyAndUpdate(index: Int, offset: CGFloat) -> Bool {
        if characters.indices.contains(index) {
            characters[index].pusOffset = offset
            // Since it's not the Main Offset
            characters[index].isCurrent = false
            return true
        }
        return false
    }
    
    // MARK: Contact Row For Each Alphabet
    @ViewBuilder
    func ContactsForCharacter(character: Character) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(character.value)
                .font(.largeTitle.bold())
            
            ForEach(1...4, id: \.self) { _ in
                HStack(spacing: 10) {
                    Circle()
                        .fill(character.color.gradient)
                        .frame(width: 45, height: 45)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        RoundedRectangle(cornerRadius: 4, style: .continuous)
                            .fill(character.color.opacity(0.6).gradient)
                            .frame(height: 20)
                        
                        RoundedRectangle(cornerRadius: 4, style: .continuous)
                            .fill(character.color.opacity(0.4).gradient)
                            .frame(height: 20)
                            .padding(.trailing, 80)
                    }
                }
            }
        }
        .padding(15)
        .offset { offsetRect in
            let minY = offsetRect.minY
            let index = character.index
            
            // MARK: Logic is Simple, If MinY is Reaches the Top, Ie: Navigation Stack Header, Then We Will Update Appropriate Character in the Custom Scroller
            // Since We Have NavigationStack, So We Need to know the StartTop Offset
            if minY > 20 && minY < startOffset && !isDrag {
               // MARK: Update Scroller
                updateElevation(index: index)
                withAnimation(.easeInOut(duration: 0.15)) {
                    offsetY = characters[index].rect.minY
                }
            }
        }
    }
    
    // MARK: Fetching Characters
    func fetchCharacters() -> [Character] {
        let alphabets: String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var characters: [Character] = []
        
        characters = alphabets.compactMap({ character -> Character? in
            return Character(value: String(character))
        })
        
        // MARK: Sample Color's
        let colors: [Color] = [.red, .yellow, .pink, .orange, .cyan, .indigo, .purple, .blue]
        
        // MARK Setting Index And Random Color
        for index in characters.indices {
            characters[index].index = index
            characters[index].color = colors.randomElement()!
        }
        
        return characters
    }
}

#Preview {
    ContentView()
}
