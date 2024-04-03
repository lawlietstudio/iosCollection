import Foundation
import AVFoundation

enum SpeechLang {
    case en
    case zh
}

class SpeechUtil {
    static var share = SpeechUtil()
    
    let synthesizer = AVSpeechSynthesizer()
    
    public func stopSpeaking() {
        synthesizer.stopSpeaking(at: .word)
    }
    
    public func speak(text: String, speechLang: SpeechLang) {
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
}
