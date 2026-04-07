//
//  CustomMenu.swift
//  LiveActivityAPI
//
//  Created by mark on 2025-05-05.
//

import SwiftUI

struct CustomMenu: View {
    @State var currentSelection: Status = .received
    @State var isPressed: Bool = false
    
    var body: some View {
        Menu {
            ForEach(Status.allCases, id: \.self) { status in
                Button(action: {
                    currentSelection = status
                }) {
                    if currentSelection == status {
                        Label(status.rawValue, systemImage: "checkmark")
                    } else {
                        Text(status.rawValue)
                    }
                }
            }
        } label: {
            // Custom-styled trigger
            HStack {
                Text(currentSelection.rawValue)
                    .fontWeight(.medium)
                Spacer()
                Image(systemName: "chevron.down")
                    .rotationEffect(.degrees(isPressed ? 180 : 0))
                    .animation(.spring(), value: isPressed)
            }
            .padding()
            .background(Color.blue.opacity(0.1))
            .cornerRadius(10)
        }
        .buttonStyle(CapsuleButtonStyle(isPressed: $isPressed)) // Optional: prevent default button styling
    }
}


struct CapsuleButtonStyle: ButtonStyle {
    @Binding var isPressed: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
//            .background(.white)
            .foregroundColor(.green)
            .clipShape(Capsule())
            .overlay(content: {
                Capsule()
                    .stroke(.green, lineWidth: 2)
            })
//            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .onChange(of: configuration.isPressed) { oldValue, newValue in
                isPressed = configuration.isPressed
            }
    }
}

#Preview {
    CustomMenu()
}
