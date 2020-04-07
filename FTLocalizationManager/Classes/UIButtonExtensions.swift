//
//  UIButtonExtensions.swift
//  LocalizationHandler
//
//  Created by Abdulla Kunhi on 4/25/18.
//  Copyright © 2018 Abdulla Kunhi. All rights reserved.
//

import UIKit

private var localizedSelectedTitleKey: UInt8 = 5
private var localizedHighlightedTitleKey: UInt8 = 6
private var localizedDisabledTitleKey: UInt8 = 7
private var localizedSelectedImageKey: UInt8 = 8
private var alwaysTemplateKey: UInt8 = 9

extension UIButton {
    
    @IBInspectable open var localizedTitleNormal: String? {
        get { return valueFor(key: &localizedTextKey) }
        set {
            setValue(value: newValue, key: &localizedTextKey)
            configureView()
        }
    }
    
    @IBInspectable open var localizedTitleSelected: String? {
        get { return valueFor(key: &localizedSelectedTitleKey) }
        set {
            setValue(value: newValue, key: &localizedSelectedTitleKey)
            configureView()
        }
    }
    
    @IBInspectable open var localizedTitleHighlighted: String? {
        get { return valueFor(key: &localizedHighlightedTitleKey) }
        set {
            setValue(value: newValue, key: &localizedHighlightedTitleKey)
            configureView()
        }
    }
    
    @IBInspectable open var localizedTitleDisabled: String? {
        get { return valueFor(key: &localizedDisabledTitleKey) }
        set {
            setValue(value: newValue, key: &localizedDisabledTitleKey)
            configureView()
        }
    }
    
    @IBInspectable open var upperCased: Bool {
        get { return valueFor(key: &uppercasedKey)  ?? false }
        set { setValue(value: newValue, key: &uppercasedKey) }
    }
    
    @IBInspectable open var normalImage: UIImage? {
        get { return valueFor(key: &localizedImageKey) }
        set {
            setValue(value: newValue, key: &localizedImageKey)
            configureView()
        }
    }
    
    @IBInspectable open var selectedImage: UIImage? {
        get { return valueFor(key: &localizedSelectedImageKey) }
        set {
            setValue(value: newValue, key: &localizedSelectedImageKey)
            configureView()
        }
    }
    
    @IBInspectable open var alwaysTemplate: Bool {
        get { return valueFor(key: &alwaysTemplateKey) ?? false }
        set {
            setValue(value: newValue, key: &alwaysTemplateKey)
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
        
        if let localizedTitleNormal = localizedTitleNormal {
            upperCased ? setTitle(NSLocalizedString(localizedTitleNormal, comment: "").uppercased(), for: .normal) : setTitle(NSLocalizedString(localizedTitleNormal, comment: ""), for: .normal)
        }
        if let localizedTitleSelected = localizedTitleSelected {
            upperCased ? setTitle(NSLocalizedString(localizedTitleSelected, comment: "").uppercased(), for: .selected) : setTitle(NSLocalizedString(localizedTitleSelected, comment: ""), for: .selected)
        }
        if let localizedTitleHighlighted = localizedTitleHighlighted {
            upperCased ? setTitle(NSLocalizedString(localizedTitleHighlighted, comment: "").uppercased(), for: .highlighted) : setTitle(NSLocalizedString(localizedTitleHighlighted, comment: ""), for: .highlighted)
        }
        if let localizedTitleDisabled = localizedTitleDisabled {
            upperCased ? setTitle(NSLocalizedString(localizedTitleDisabled, comment: "").uppercased(), for: .disabled) : setTitle(NSLocalizedString(localizedTitleDisabled, comment: ""), for: .disabled)
        }
        
        setimage(normalImage, for: .normal)
        setimage(selectedImage, for: .selected)
    }
    
    private func setimage(_ image: UIImage?, for state: UIControl.State) {
        
        guard let newImage = image, let cgImage = image?.cgImage else {
            setImage(image, for: state)
            return
        }
        
        let image = shouldFlip ? UIImage(cgImage: cgImage, scale: newImage.scale, orientation: .upMirrored).withRenderingMode(alwaysTemplate ? .alwaysTemplate: .automatic) : newImage
        
        // set image
        setimage(image, for: state)
    }
}
