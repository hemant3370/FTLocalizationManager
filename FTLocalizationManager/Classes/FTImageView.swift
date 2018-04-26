//
//  FTImageView.swift
//  LocalizationHandler
//
//  Created by Abdulla Kunhi on 4/25/18.
//  Copyright © 2018 Abdulla Kunhi. All rights reserved.
//

import UIKit

protocol LocalizableImage {
    var respectLocale: Bool { get set }
    var imageName: String? { get set }
    var shouldFlip: Bool { get }
    func configureView()
}

extension LocalizableImage {
    var shouldFlip: Bool {
        return respectLocale && Language.current.isRTL
    }
}

class FTImageView: UIImageView, LocalizableImage {
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
    }
    
    func configureView() {
        
        // abort if we dont have an image
        guard let imageName = imageName, let newImage = UIImage(named: imageName), let cgImage = newImage.cgImage else { return }
        
        // set image
        image = shouldFlip ? UIImage(cgImage: cgImage, scale: newImage.scale, orientation: .upMirrored) : newImage
    }
}

