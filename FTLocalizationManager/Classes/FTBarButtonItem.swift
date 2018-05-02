//
//  FTBarButtonItem.swift
//  LocalizationHandler
//
//  Created by Abdulla Kunhi on 4/26/18.
//  Copyright © 2018 Abdulla Kunhi. All rights reserved.
//

import UIKit

open class FTBarButtonItem: UIBarButtonItem {
    @IBInspectable var respectLocale: Bool = true {
        didSet {
            configrueView()
        }
    }
    
    @IBInspectable var imageName: String? {
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
        
        configrueView()
    }
    
    
   private func configrueView() {
        if let localizedText = localizedText {
            title = NSLocalizedString(localizedText, comment: "")
        }
    }
}
