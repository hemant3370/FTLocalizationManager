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
    
    public init(frame: CGRect, textContainer: NSTextContainer? = nil, textAlignment: NSTextAlignment) {
        super.init(frame: frame, textContainer: textContainer)
        self.textAlignment = textAlignment
        
        setTextAlignment()
    }
    
    private override init(frame: CGRect, textContainer: NSTextContainer? = nil) {
        fatalError("should call init(frame: CGRect, textContainer: NSTextContainer? = nil, textAlignment: NSTextAlignment)")
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

private extension FTTextView {
    func configrueView() {
        if let localizedText = localizedText {
            text = NSLocalizedString(localizedText, comment: "")
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
