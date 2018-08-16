//
//  FTBarButtonItem.swift
//  LocalizationHandler
//
//  Created by Abdulla Kunhi on 4/26/18.
//  Copyright © 2018 Abdulla Kunhi. All rights reserved.
//

import UIKit

open class FTBarButtonItem: UIBarButtonItem {
    
    @IBInspectable open var respectLocale: Bool = true {
        didSet {
            configrueView()
        }
    }
    
    @IBInspectable open var localizedImage: UIImage? {
        didSet {
            configrueView()
        }
    }
    
    @IBInspectable open var localizedText: String? {
        didSet {
            configrueView()
        }
    }
    
    fileprivate var shouldFlip: Bool {
        return respectLocale && Language.current.isRTL
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        configrueView()
    }
    
    private func configrueView() {
        if let localizedText = localizedText {
            title = NSLocalizedString(localizedText, comment: "")
        }
        
        // abort if we dont have an image
        guard let localizedImage = localizedImage, let cgImage = localizedImage.cgImage else { return }
        let image = shouldFlip ? UIImage(cgImage: cgImage, scale: localizedImage.scale, orientation: .upMirrored) : localizedImage
        
        // set image
        self.image = image
    }
}
