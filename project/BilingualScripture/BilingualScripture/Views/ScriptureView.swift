import SwiftUI

struct ScriptureView: View {
    var chapter: Chapter  // Assume Chapter struct has necessary details

    var body: some View {
        List(chapter.verses, id: \.key) { verse in
            Text(verse.key)

            SpeakButton(text: verse.text.en, speechLang: .en)

            SpeakButton(text: verse.text.zh, speechLang: .zh)
        }
        .navigationTitle("Chapter \(chapter.number)")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    SpeechUtil.share.stopSpeaking()
                }) {
                    Image(systemName: "stop.circle")
                }
            }
        }
        .onDisappear {
            SpeechUtil.share.stopSpeaking()
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

