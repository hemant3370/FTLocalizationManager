//
//  FTImageView.swift
//  LocalizationHandler
//
//  Created by Abdulla Kunhi on 4/25/18.
//  Copyright © 2018 Abdulla Kunhi. All rights reserved.
//

import UIKit

open class FTImageView: UIImageView {
    
    @IBInspectable open var respectLocale: Bool = true {
        didSet {
            configureView()
        }
    }
    
    @IBInspectable open var localizedImage: UIImage? {
        didSet {
            configureView()
        }
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
    }
    
    fileprivate var shouldFlip: Bool {
        return respectLocale && Language.current.isRTL
    }
    
    private func configureView() {
        
        // abort if we dont have an image
        guard let localizedImage = localizedImage, let cgImage = localizedImage.cgImage else { return }
        
        // set image
        image = shouldFlip ? UIImage(cgImage: cgImage, scale: localizedImage.scale, orientation: .upMirrored) : localizedImage
    }
}
