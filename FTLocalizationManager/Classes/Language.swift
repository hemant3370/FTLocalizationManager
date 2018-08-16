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
    case hindi = "hi"
    case russian = "ru"
    
    public var locale: String {
        return rawValue
    }
    
    public var title: String {
        switch self {
        case .english: return "English"
        case .arabic: return "Arabic"
        case .french: return "French"
        case .russian: return "Russian"
        case .hindi: return "Hindi"
        }
    }
    
    public var localizedTitle: String {
        switch self {
        case .english: return "English"
        case .arabic: return "العربية"
        case .french: return "Français"
        case .russian: return "русский"
        case .hindi: return "हिंदी"
        }
    }
    
    public var semanticContentAttribute: UISemanticContentAttribute {
        return isRTL ? .forceRightToLeft : .forceLeftToRight
    }
    
    public var mainStoryBoardName: String {
        return Bundle.main.object(forInfoDictionaryKey: "UIMainStoryboardFile") as? String ?? "Main"
    }
    
    public var isRTL: Bool {
        return self == .arabic
    }
    
    public static func language(from code: String) -> Language {
        return Language(rawValue: code) ?? .english
    }
    
    public static var all: [Language] {
        return [.arabic, english, .french, .russian, .hindi]
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
                Language.setCurrentLanguage(language: .device)
                
                return Language.device
            }
            
            return Language(rawValue: preferred) ?? .english
        }
        set {
            setCurrentLanguage(language: newValue)
        }
        
    }
    
    /// set the current language and restart with the rootviewcontroller
    static func setCurrentLanguage(language: Language, restarting rootViewControllerGenerator: (() -> UIViewController?)? = nil) {
        
        // save the preffered language
        UserDefaults.standard.set(language.locale, forKey: Keys.preferred)
        UserDefaults.standard.synchronize()
        
        // update app for new language
        language.updateView(restarting: rootViewControllerGenerator)
    }
    
    /// returns the device language. returns arabic if device language is arabic, else returns english
    static var device: Language {
        guard let deviceLanguages = UserDefaults.standard.object(forKey: Keys.device) as? [String],
            let deviceLanguage = deviceLanguages.first else { return .english }
        let array = deviceLanguage.components(separatedBy: "-")
        return Language(rawValue: array.first ?? "en") ?? .english
    }
}

public extension Language {
    fileprivate func updateView(restarting rootViewControllerGenerator: (() -> UIViewController?)? = nil) {
        
        // update semanticContentAttribute
        UIView.appearance().semanticContentAttribute = semanticContentAttribute
        UISearchBar.appearance().semanticContentAttribute = semanticContentAttribute
        
        restart(rootViewControllerGenerator: rootViewControllerGenerator)
    }
    
    private func restart(rootViewControllerGenerator: (() -> UIViewController?)? = nil) {
        guard let wrappedWindow = UIApplication.shared.delegate?.window, let window = wrappedWindow else { return }
        
        // load root view controller from the generator if we have one, or load initial view controller of main storyboard
        let rootViewController = rootViewControllerGenerator?()
        window.rootViewController = rootViewController ?? UIStoryboard(name: mainStoryBoardName, bundle: nil).instantiateInitialViewController()
        
        UIView.transition(with: window, duration: 0.6, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    static func apply() {
        Language.current = Language.current
        UIApplication.handleLocalization()
    }
}
