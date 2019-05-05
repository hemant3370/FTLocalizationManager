//
//  FTLabel.swift
//  LocalizationHandler
//
//  Created by Abdulla Kunhi on 4/26/18.
//  Copyright © 2018 Abdulla Kunhi. All rights reserved.
//

import UIKit

open class FTLabel: UILabel {
    
    @IBInspectable open var respectLocale: Bool = true {
        didSet {
            configrueView()
        }
    }
    
    @IBInspectable open var localizedText: String? {
        didSet {
            configrueView()
        }
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        configrueView()
        
        // flip
        if Language.current.isRTL && respectLocale  {
            if textAlignment == .right {
                textAlignment = .left
            }
            else if textAlignment == .left {
                textAlignment = .right
            }
        }
    }
    
    open func configrueView() {
        if let localizedText = localizedText {
            text = NSLocalizedString(localizedText, comment: "")
        }
    }
}

