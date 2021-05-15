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
    
    public var locale: String {
        return rawValue
    }
    
    public var title: String {
        switch self {
        case .english: return "English"
        case .arabic: return "Arabic"
        }
    }
    
    public var localizedTitle: String {
        switch self {
        case .english: return "English"
        case .arabic: return "العربية"
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
        return [.arabic, english]
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
        
        // save the preferred language
        UserDefaults.standard.set(language.locale, forKey: Keys.preferred)
        UserDefaults.standard.synchronize()
        
        // update app for new language
        if #available(iOS 13.0, *) { }
        else {
            language.updateView(restarting: rootViewControllerGenerator)
        }
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
        UITextField.appearance().semanticContentAttribute = semanticContentAttribute
        UICollectionView.appearance().semanticContentAttribute = semanticContentAttribute
        
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
        if #available(iOS 13.0, *) {
            Language.current = Language.device
        }
        else {
            Language.current = Language.current
            UIApplication.handleLocalization()
        }
    }
}
