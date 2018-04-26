//
//  FTImageView.swift
//  LocalizationHandler
//
//  Created by Abdulla Kunhi on 4/25/18.
//  Copyright © 2018 Abdulla Kunhi. All rights reserved.
//

import UIKit


open class FTImageView: UIImageView {
    @IBInspectable var respectLocale: Bool = true {
        didSet {
            configureView()
        }
    }
    
    @IBInspectable var imageName: String? {
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
    
    func configureView() {
        
        // abort if we dont have an image
        guard let imageName = imageName, let newImage = UIImage(named: imageName), let cgImage = newImage.cgImage else { return }
        
        // set image
        image = shouldFlip ? UIImage(cgImage: cgImage, scale: newImage.scale, orientation: .upMirrored) : newImage
    }
}

