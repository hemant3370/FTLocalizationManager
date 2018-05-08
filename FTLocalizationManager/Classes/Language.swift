//
//  Language.swift
//  LocalizationHandler
//
//  Created by Abdulla Kunhi on 4/25/18.
//  Copyright © 2018 Abdulla Kunhi. All rights reserved.
//

import UIKit

public enum Language: String {
    case english = "en"
    case arabic = "ar"
    case french = "fr"
    
   public var locale: String {
        return rawValue
    }
    
   public var title: String {
        switch self {
        case .english: return "English"
        case .arabic: return "Arabic"
        case .french: return "French"
        }
    }
    
    public var localizedTitle: String {
        switch self {
        case .english: return "English"
        case .arabic: return "العربية"
        case .french: return "Français"
        }
    }
    
   public var isRTL: Bool {
        return self == .arabic
    }
    
    public static func language(from code: String) -> Language {
        return Language(rawValue: code) ?? .english
    }
    
    public static var all: [Language] {
        return [.arabic, english, .french]
    }
}

public extension Language {
    fileprivate struct Keys {
        static let preferred = "UserPreferedAppLanguage"
        static let device = "AppleLanguages"
    }
}

public extension Language {
    /// current language if user has preferred one or the device language
    static var current: Language {
        get {
            guard let preferred = UserDefaults.standard.string(forKey: Keys.preferred) else {
                
                // save device language as preferred
                Language.current = Language.device
                
                return Language.device
            }
            
            return Language(rawValue: preferred) ?? .english
        }
        set {
            UserDefaults.standard.set(newValue.locale, forKey: Keys.preferred)
            UserDefaults.standard.synchronize()
            
            // update app for new language
            newValue.updateView()
        }
    }
    
    /// returns the device language. returns arabic if device language is arabic, else returns english
    static var device: Language {
        guard let deviceLanguages = UserDefaults.standard.object(forKey: Keys.device) as? [String],
            let deviceLanguage = deviceLanguages.first else { return .english }
       return Language(rawValue: deviceLanguage) ?? .english
    }
}

public extension Language {
    fileprivate func updateView() {
        
        // update semanticContentAttribute
        if #available(iOS 9.0, *) {
            UIView.appearance().semanticContentAttribute = isRTL ? .forceRightToLeft : .forceLeftToRight
        } else {
            // Fallback on earlier versions
        }

        restart()
    }
    
    private func restart() {
        guard let wrappedWindow = UIApplication.shared.delegate?.window else { return }
        guard let window = wrappedWindow else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        window.rootViewController = storyboard.instantiateInitialViewController()
        
        UIView.transition(with: window, duration: 0.6, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    static func apply() {
        UIApplication.handleLocalization()
    }
}
