//
//  UINavigationItemExtensions.swift
//  LocalizationHandler
//
//  Created by Abdulla Kunhi on 4/26/18.
//  Copyright © 2018 Abdulla Kunhi. All rights reserved.
//

import UIKit

extension UINavigationItem {
    @IBInspectable open var localizedText: String? {
        get { return valueFor(key: &localizedTextKey) }
        set {
            setValue(value: newValue, key: &localizedTextKey)
            setLocalizedText()
        }
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        setLocalizedText()
    }
    
    private func setLocalizedText() {
        if let localizedText = localizedText {
            title = &&localizedText
        }
    }
}
