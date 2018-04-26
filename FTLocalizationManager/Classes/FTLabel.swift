//
//  FTLabel.swift
//  LocalizationHandler
//
//  Created by Abdulla Kunhi on 4/26/18.
//  Copyright © 2018 Abdulla Kunhi. All rights reserved.
//

import UIKit

open class FTLabel: UILabel {
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
    
   open override func awakeFromNib() {
        super.awakeFromNib()
    
        print("testing")
        configrueView()
    }
    
   private func configrueView() {
        if let localizedText = localizedText {
            text = NSLocalizedString(localizedText, comment: "")
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

