import SwiftUI
import AVFoundation

struct PianoView: View {
    // Audio engine for playing sounds
    let audioEngine = AVAudioEngine()
    let players: [AVAudioPlayer] = []
    
    // Define piano keys (white and black)
    let whiteKeys = ["C", "D", "E", "F", "G", "A", "B"]
    let blackKeys = ["C#", "D#", "F#", "G#", "A#"]
    
    var body: some View {
        ZStack {
            // White keys
            HStack(spacing: 2) {
                ForEach(whiteKeys, id: \.self) { note in
                    PianoKey(note: note, isBlack: false)
                }
            }
            
            // Black keys
            HStack(spacing: 12) {
                ForEach(blackKeys, id: \.self) { note in
                    PianoKey(note: note, isBlack: true)
                        .offset(x: calculateBlackKeyOffset(note), y: -40)
                        
                }
            }
        }
        .padding()
    }
    
    func calculateBlackKeyOffset(_ note: String) -> CGFloat {
        // Calculate position for black keys
        switch note {
        case "C#": return -50
        case "D#": return -40
        case "F#": return 30
        case "G#": return 40
        case "A#": return 50
        default: return 0
        }
    }
}

struct PianoKey: View {
    let note: String
    let isBlack: Bool
    @State private var isPressed = false
    
    var body: some View {
        Rectangle()
            .fill(isBlack ? Color.black : Color.white)
            .frame(width: isBlack ? 40 : 60, height: isBlack ? 120 : 200)
            .border(Color.black, width: 1)
            .onTapGesture {
                isPressed = true
                playNote()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    isPressed = false
                }
            }
            .scaleEffect(isPressed ? 0.95 : 1.0)
            .animation(.spring(), value: isPressed)
    }
    
    func playNote() {
        // Add sound playing logic here
        print("Playing note: \(note)")
    }
}

#Preview {
    PianoView()
}
