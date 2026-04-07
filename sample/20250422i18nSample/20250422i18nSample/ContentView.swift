//
//  ContentView.swift
//  20250422i18nSample
//
//  Created by mark on 2025-04-22.
//

import SwiftUI
import Foundation

class LanguageManager: ObservableObject {
    static let shared = LanguageManager()
    
    @Published var currentLanguage: String {
        didSet {
            UserDefaults.standard.set(currentLanguage, forKey: "AppLanguage")
        }
    }

    private init() {
        let saved = UserDefaults.standard.string(forKey: "AppLanguage")
        currentLanguage = saved ?? Locale.current.language.languageCode?.identifier ?? "en"
    }

    var bundle: Bundle {
        guard let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return .main
        }
        return bundle
    }

    func localized(_ key: String) -> String {
        return NSLocalizedString(key, bundle: bundle, comment: "")
    }
}

struct ContentView: View {
    @ObservedObject private var languageManager = LanguageManager.shared

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(languageManager.localized("greeting"))
            
            let availableLanguages = Bundle.main.localizations.filter { $0 != "Base" }.sorted {
                displayName(for: $0) < displayName(for: $1)
            }
            
            Picker("Language", selection: $languageManager.currentLanguage) {
                ForEach(availableLanguages, id: \.self) { lang in
                        Text(displayName(for: lang)).tag(lang)
                    }
            }
            .pickerStyle(.segmented)
            .padding(.top)
        }
        .padding()
    }
    
    func displayName(for languageCode: String) -> String {
        let locale = Locale(identifier: languageCode)
        return locale.localizedString(forIdentifier: languageCode) ?? languageCode
    }
}

#Preview {
    ContentView()
}
