//
//  Localizer.swift
//  LocalizationHandler
//
//  Created by Abdulla Kunhi on 4/25/18.
//  Copyright © 2018 Abdulla Kunhi. All rights reserved.
//

import Foundation
import UIKit

public extension UIApplication {
    class func handleLocalization() {
        MethodSwizzleGivenClassName(cls: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: #selector(Bundle.specialLocalizedStringForKey(_:value:table:)))
    }
}

public extension Bundle {
    @objc func specialLocalizedStringForKey(_ key: String, value: String?, table tableName: String?) -> String {
        if self == Bundle.main {
            var bundle: Bundle?
            if let _path = Bundle.main.path(forResource: Language.current.locale, ofType: "lproj") {
                bundle = Bundle(path: _path)
            } else {
                let _path = Bundle.main.path(forResource: "Base", ofType: "lproj")!
                bundle = Bundle(path: _path)
            }
            
            guard let newBundle = bundle  else {
                return (self.specialLocalizedStringForKey(key, value: value, table: tableName))
            }
            
            return (newBundle.specialLocalizedStringForKey(key, value: value, table: tableName))
            
        } else {
            return (self.specialLocalizedStringForKey(key, value: value, table: tableName))
        }
    }
}

public func MethodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    guard let origMethod: Method = class_getInstanceMethod(cls, originalSelector), let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector)  else {
        return
    }
    if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, overrideMethod);
    }
}

