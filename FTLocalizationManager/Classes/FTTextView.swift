//
//  FTTextView.swift
//  LocalizationHandler
//
//  Created by Abdulla Kunhi on 4/26/18.
//  Copyright © 2018 Abdulla Kunhi. All rights reserved.
//

import UIKit

open class FTTextView: UITextView {
    @IBInspectable var respectLocale: Bool = true {
        didSet {
            configrueView()
        }
    }
    
    @IBInspectable var localizedText: String? {
        didSet {
            configrueView()
        }
    }
    
    @IBInspectable var localizedPlaceholder: String? {
        didSet {
            configrueView()
        }
    }
    
   open override func awakeFromNib() {
        super.awakeFromNib()
        
        configrueView()
    }
    
    private func configrueView() {
        if let localizedText = localizedText {
            text = NSLocalizedString(localizedText, comment: "")
        }
        
        
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
}
