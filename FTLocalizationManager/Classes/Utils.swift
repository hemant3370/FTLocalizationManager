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
    
    let bundle = (Language.current as? RuntimeLocalizer)?.bundle ?? Bundle.main
    return NSLocalizedString(string, tableName: nil, bundle: bundle, comment: "")
}
