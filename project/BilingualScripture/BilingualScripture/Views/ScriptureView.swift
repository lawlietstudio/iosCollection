import SwiftUI
import AVFoundation

enum SpeechLang {
    case en
    case zh
}

struct ScriptureView: View {
    var chapter: Chapter  // Assume Chapter struct has necessary details

    let synthesizer = AVSpeechSynthesizer()

    var body: some View {
        List(chapter.verses, id: \.key) { verse in
            Text(verse.key)

            Button(action: {
                speak(text: verse.text.en, speechLang: .en)
            }) {
                VStack(alignment: .leading) {
                    Text(verse.text.en).font(.subheadline)
                }
            }

            Button(action: {
                speak(text: verse.text.zh, speechLang: .zh)
            }) {
                VStack(alignment: .leading) {
                    Text(verse.text.zh).font(.subheadline)
                }
            }
        }
        .navigationTitle("Chapter \(chapter.number)")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    self.stopSpeaking()
                }) {
                    Image(systemName: "stop.circle")
                }
            }
        }
        .onDisappear {
            self.stopSpeaking()
        }
    }
    
    private func stopSpeaking() {
        synthesizer.stopSpeaking(at: .word)
    }
    
    private func speak(text: String, speechLang: SpeechLang) {
        self.stopSpeaking()
        
        let utterance = AVSpeechUtterance(string: text)
        switch speechLang {
        case .en:
            if let sinjiVoice = AVSpeechSynthesisVoice.speechVoices().first(where: { $0.language == "en-US" && $0.name == "Samantha" }) {
                utterance.voice = sinjiVoice
                synthesizer.speak(utterance)
            }
        case .zh:
            if let sinjiVoice = AVSpeechSynthesisVoice.speechVoices().first(where: { $0.language == "zh-HK" && $0.name == "Sinji" }) {
                utterance.voice = sinjiVoice
                synthesizer.speak(utterance)
            }
        }
    }

//    private func speak(text: String, speechLang: SpeechLang) {
//        let utterance = AVSpeechUtterance(string: text)
//        switch speechLang {
//        case .en:
//            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
//        case .zh:
//            utterance.voice = AVSpeechSynthesisVoice(language: "zh-CN")
//        }
//        synthesizer.speak(utterance)
//    }
}

