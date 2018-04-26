//
//  FTButton.swift
//  LocalizationHandler
//
//  Created by Abdulla Kunhi on 4/25/18.
//  Copyright © 2018 Abdulla Kunhi. All rights reserved.
//

import UIKit

open class FTButton: UIButton {
    @IBInspectable open var respectLocale: Bool = true {
        didSet {
            configrueView()
        }
    }
    
    @IBInspectable open var imageName: String? {
        didSet {
            configrueView()
        }
    }
    
    @IBInspectable open var localizedTitleNormal: String? {
        didSet {
            configrueView()
        }
    }
    @IBInspectable open var localizedTitleSelected: String? {
        didSet {
            configrueView()
        }
    }
    @IBInspectable open var localizedTitleHighlighted: String? {
        didSet {
            configrueView()
        }
    }
    
    @IBInspectable open var localizedTitleDisabled: String? {
        didSet {
            configrueView()
        }
    }
    
   open override func awakeFromNib() {
        super.awakeFromNib()
        
        configrueView()
    }
    
    fileprivate var shouldFlip: Bool {
        return respectLocale && Language.current.isRTL
    }
    
   private func configrueView() {
        
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
