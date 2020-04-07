//
//  UIBarButtonItemExtension.swift
//  LocalizationHandler
//
//  Created by Abdulla Kunhi on 4/26/18.
//  Copyright © 2018 Abdulla Kunhi. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    @IBInspectable open var respectLocale: Bool {
        get { return autoLocalizeValue() }
        set { setAutoLocalizeValue(value: newValue) }
    }
    
    @IBInspectable open var localizedText: String? {
        get { return valueFor(key: &localizedTextKey) }
        set {
            setValue(value: newValue, key: &localizedTextKey)
            configureView()
        }
    }
    
    @IBInspectable open var localizedImage: UIImage? {
        get { return valueFor(key: &localizedImageKey) }
        set {
            setValue(value: newValue, key: &localizedImageKey)
            configureView()
        }
    }
    
    fileprivate var shouldFlip: Bool {
        return respectLocale && Language.current.isRTL
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
    }
    
    private func configureView() {
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
