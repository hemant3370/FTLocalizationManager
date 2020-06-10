//
//  Utils.swift
//  FTLocalizationManager
//
//  Created by Abdulla Kunhi on 08/04/2020.
//

import Foundation

prefix operator &&

prefix func && (string: String?) -> String {
    guard let string = string else { return "" }
    
    guard let customBundle = (Language.current as? RuntimeLocalizer)?.bundle else {
        return NSLocalizedString(string, bundle: Bundle.main, comment: "")
    }
    
    let result = NSLocalizedString(string, bundle: customBundle, comment: "")
    return result == string ? NSLocalizedString(string, bundle: Bundle.main, comment: "") : result
}
