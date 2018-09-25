//
//  FTTextView.swift
//  LocalizationHandler
//
//  Created by Abdulla Kunhi on 4/26/18.
//  Copyright © 2018 Abdulla Kunhi. All rights reserved.
//

import UIKit

open class FTTextView: UITextView {
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
    
    @IBInspectable open var localizedPlaceholder: String? {
        didSet {
            configrueView()
        }
    }
    
    /// Setting true will use the custom fonts specified
    @IBInspectable var useCustomFont: Bool = true
    @IBInspectable var rtlFontName: String = "LandRoverWeb-Medium"
    @IBInspectable var ltrFontName: String = "LandRoverWeb-Medium"
    
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
    
    private func configrueView() {
        if let localizedText = localizedText {
            text = NSLocalizedString(localizedText, comment: "")
        }
        guard useCustomFont else { return }
        
        // get the custom font
        var customFont: UIFont?
        if Language.current.isRTL {
            customFont = UIFont(name: rtlFontName, size: font?.pointSize ?? 5)
        } else {
            customFont = UIFont(name: ltrFontName, size: font?.pointSize ?? 5)
        }
        
        // set font
        self.font = customFont
    }
}
