//
//  FTTextField.swift
//  LocalizationHandler
//
//  Created by Abdulla Kunhi on 4/26/18.
//  Copyright © 2018 Abdulla Kunhi. All rights reserved.
//

import UIKit

class FTTextField: UITextField {
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configrueView()
    }
    
    func configrueView() {
        if let localizedText = localizedText {
            text = NSLocalizedString(localizedText, comment: "")
        }
        
        if let localizedPlaceholder = localizedPlaceholder {
            placeholder = NSLocalizedString(localizedPlaceholder, comment: "")
        }
        
        if Language.current.isRTL && respectLocale  {
            if self.textAlignment == .right {
                self.textAlignment = .left
            }
            if self.textAlignment == .left {
                self.textAlignment = .right
            }
        }
    }
}
