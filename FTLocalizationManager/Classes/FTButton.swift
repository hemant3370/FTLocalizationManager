//
//  FTButton.swift
//  LocalizationHandler
//
//  Created by Abdulla Kunhi on 4/25/18.
//  Copyright © 2018 Abdulla Kunhi. All rights reserved.
//

import UIKit

class FTButton: UIButton {
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
    
    @IBInspectable var localizedTitleNormal: String? {
        didSet {
            configureView()
        }
    }
    @IBInspectable var localizedTitleSelected: String? {
        didSet {
            configureView()
        }
    }
    @IBInspectable var localizedTitleHighlighted: String? {
        didSet {
            configureView()
        }
    }
    
    @IBInspectable var localizedTitleDisabled: String? {
        didSet {
            configureView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
    }
    
    fileprivate var shouldFlip: Bool {
        return respectLocale && Language.current.isRTL
    }
    
    func configureView() {
        
        if let localizedTitleNormal = localizedTitleNormal {
            setTitle(NSLocalizedString(localizedTitleNormal, comment: ""), for: .normal)
        }
        if let localizedTitleSelected = localizedTitleSelected {
            setTitle(NSLocalizedString(localizedTitleSelected, comment: ""), for: .selected)
        }
        if let localizedTitleHighlighted = localizedTitleHighlighted {
            setTitle(NSLocalizedString(localizedTitleHighlighted, comment: ""), for: .highlighted)
        }
        if let localizedTitleDisabled = localizedTitleDisabled {
            setTitle(NSLocalizedString(localizedTitleDisabled, comment: ""), for: .disabled)
        }
        
        // abort if we dont have an image
        guard let imageName = imageName, let newImage = UIImage(named: imageName), let cgImage = newImage.cgImage else { return }
        let image = shouldFlip ? UIImage(cgImage: cgImage, scale: newImage.scale, orientation: .upMirrored) : newImage
        
        // set image
        setImage(image, for: .normal)
    }
}
