//
//  FTTextField.swift
//  LocalizationHandler
//
//  Created by Abdulla Kunhi on 4/26/18.
//  Copyright © 2018 Abdulla Kunhi. All rights reserved.
//

import UIKit

open class FTTextField: UITextField {
    
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
    
    public init(frame: CGRect, textAlignment: NSTextAlignment) {
        super.init(frame: frame)
        self.textAlignment = textAlignment
        
        setTextAlignment()
    }
    
    public override init(frame: CGRect) {
        fatalError("should call init(frame: CGRect, textAlignment: NSTextAlignment)")
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        configrueView()
        
        // flip
        setTextAlignment()
    }
}

private extension FTTextField {
    func configrueView() {
        if let localizedText = localizedText {
            text = NSLocalizedString(localizedText, comment: "")
        }
        
        if let localizedPlaceholder = localizedPlaceholder {
            placeholder = NSLocalizedString(localizedPlaceholder, comment: "")
        }
    }
    
    func setTextAlignment() {
        if Language.current.isRTL && respectLocale {
            if textAlignment == .right {
                textAlignment = .left
            }
            else if textAlignment == .left {
                textAlignment = .right
            }
        }
    }
}

