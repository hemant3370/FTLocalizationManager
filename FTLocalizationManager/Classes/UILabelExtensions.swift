//
//  UILabelExtensions.swift
//  LocalizationHandler
//
//  Created by Abdulla Kunhi on 4/26/18.
//  Copyright © 2018 Abdulla Kunhi. All rights reserved.
//

import UIKit

var autoLocalizeKey: UInt8 = 0
var localizedTextKey: UInt8 = 1
var uppercasedKey: UInt8 = 2
var localizedPlaceholderKey: UInt8 = 3
var localizedImageKey: UInt8 = 4

extension NSCoding {
    
    func valueFor<T>(key: UnsafeMutablePointer<UInt8>) -> T? {
        return objc_getAssociatedObject(self, key) as? T
    }
    
    func setValue<T>(value: T?, key: UnsafeMutablePointer<UInt8>) {
        guard let value = value else { return }
        let policy = objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN
        objc_setAssociatedObject(self, key, value, policy)
    }
    
    func autoLocalizeValue() -> Bool {
        return valueFor(key: &autoLocalizeKey) ?? true
    }
    
    func setAutoLocalizeValue(value: Bool) {
        setValue(value: value, key: &autoLocalizeKey)
    }
}

extension UIView {
    @IBInspectable open var respectLocale: Bool {
        get { return autoLocalizeValue() }
        set { setAutoLocalizeValue(value: newValue) }
    }
}

extension UILabel {
    
    @IBInspectable open var upperCased: Bool {
        get { return valueFor(key: &uppercasedKey)  ?? false }
        set { setValue(value: newValue, key: &uppercasedKey) }
    }
    
    @IBInspectable open var localizedText: String? {
        get { return valueFor(key: &localizedTextKey) }
        set {
            setValue(value: newValue, key: &localizedTextKey)
            setLocalizedText()
        }
    }
}

extension UILabel {
    open func setLocalizedText() {
        if let localizedText = localizedText {
            text = upperCased ? NSLocalizedString(localizedText, comment: "").uppercased() : NSLocalizedString(localizedText, comment: "")
        }
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        if Language.current.isRTL && respectLocale {
            if textAlignment == .right {
                textAlignment = .left
            }
            else if textAlignment == .left {
                textAlignment = .right
            }
        }
        setLocalizedText()
    }
}
