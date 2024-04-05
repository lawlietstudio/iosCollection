import SwiftUI
import AVFoundation

struct SettingView: View {
    @State private var selectedEngVoiceIdentifier: String = UserDefaults.standard.string(forKey: "engVoiceIdentifier") ?? AVSpeechSynthesisVoice(language: "en-US")!.identifier
    @State private var selectedZhoVoiceIdentifier: String = UserDefaults.standard.string(forKey: "zhoVoiceIdentifier") ?? AVSpeechSynthesisVoice(language: "zh-TW")!.identifier

    var body: some View {
        HStack {
            VStack {
                Text("Eng Voice:")
                
                Picker("Select a voice", selection: $selectedEngVoiceIdentifier) {
                    ForEach(AVSpeechSynthesisVoice.speechVoices().filter({ isEngVoice($0.language) }).map { $0.identifier }, id: \.self) { identifier in
                        let voice = AVSpeechSynthesisVoice(identifier: identifier)!
                        Text("\(voice.name)(\(voice.language))")
                            .tag(identifier)
                    }
                }
                .pickerStyle(.wheel)
                .onChange(of: selectedEngVoiceIdentifier) { _, newIdentifier in
                    UserDefaults.standard.set(newIdentifier, forKey: "engVoiceIdentifier")
                }
            }
            
            VStack {
                Text("Zho Voice:")
                
                Picker("Select a voice", selection: $selectedZhoVoiceIdentifier) {
                    ForEach(AVSpeechSynthesisVoice.speechVoices().filter({ isZhoVoice($0.language) }).map { $0.identifier }, id: \.self) { identifier in
                        let voice = AVSpeechSynthesisVoice(identifier: identifier)!
                        Text("\(voice.name)(\(voice.language))")
                            .tag(identifier)
                    }
                }
                .pickerStyle(.wheel)
                .onChange(of: selectedZhoVoiceIdentifier) { _, newIdentifier in
                    UserDefaults.standard.set(newIdentifier, forKey: "zhoVoiceIdentifier")
                }
            }
        }
    }
    
    private func isEngVoice(_ language: String) -> Bool {
        return language.contains("en")
            || language.contains("ja")
            || language.contains("ko")
    }
    
    private func isZhoVoice(_ language: String) -> Bool {
        return language.contains("zh")
    }
}
