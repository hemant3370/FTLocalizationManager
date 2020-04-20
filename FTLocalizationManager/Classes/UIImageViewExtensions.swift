//
//  UIImageViewExtensions.swift
//  LocalizationHandler
//
//  Created by Abdulla Kunhi on 4/25/18.
//  Copyright © 2018 Abdulla Kunhi. All rights reserved.
//

import UIKit

extension UIImageView {
    
    @IBInspectable open var localizedImage: UIImage? {
        get { return valueFor(key: &localizedImageKey) }
        set {
            setValue(value: newValue, key: &localizedImageKey)
            localize()
        }
    }
    
    fileprivate var shouldFlip: Bool {
        return respectLocale && Language.current.isRTL
    }
    
    public func localize() {
        
        // abort if we dont have an image
        guard let localizedImage = localizedImage, let cgImage = localizedImage.cgImage else { return }
        
        // set image
        image = shouldFlip ? UIImage(cgImage: cgImage, scale: localizedImage.scale, orientation: .upMirrored) : localizedImage
    }
}
