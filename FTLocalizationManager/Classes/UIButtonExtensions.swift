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
            localize()
        }
    }
    
    @IBInspectable open var localizedTitleSelected: String? {
        get { return valueFor(key: &localizedSelectedTitleKey) }
        set {
            setValue(value: newValue, key: &localizedSelectedTitleKey)
            localize()
        }
    }
    
    @IBInspectable open var localizedTitleHighlighted: String? {
        get { return valueFor(key: &localizedHighlightedTitleKey) }
        set {
            setValue(value: newValue, key: &localizedHighlightedTitleKey)
            localize()
        }
    }
    
    @IBInspectable open var localizedTitleDisabled: String? {
        get { return valueFor(key: &localizedDisabledTitleKey) }
        set {
            setValue(value: newValue, key: &localizedDisabledTitleKey)
            localize()
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
            localize()
        }
    }
    
    @IBInspectable open var selectedImage: UIImage? {
        get { return valueFor(key: &localizedSelectedImageKey) }
        set {
            setValue(value: newValue, key: &localizedSelectedImageKey)
            localize()
        }
    }
    
    @IBInspectable open var alwaysTemplate: Bool {
        get { return valueFor(key: &alwaysTemplateKey) ?? false }
        set {
            setValue(value: newValue, key: &alwaysTemplateKey)
            localize()
        }
    }
    
    fileprivate var shouldFlip: Bool {
          return respectLocale && Language.current.isRTL
      }
  
    public func localize() {
        
        if let localizedTitleNormal = localizedTitleNormal {
            upperCased ? setTitle((&&localizedTitleNormal).uppercased(), for: .normal) : setTitle(&&localizedTitleNormal, for: .normal)
        }
        if let localizedTitleSelected = localizedTitleSelected {
            upperCased ? setTitle((&&localizedTitleSelected).uppercased(), for: .selected) : setTitle(&&localizedTitleSelected, for: .selected)
        }
        if let localizedTitleHighlighted = localizedTitleHighlighted {
            upperCased ? setTitle((&&localizedTitleHighlighted).uppercased(), for: .highlighted) : setTitle(&&localizedTitleHighlighted, for: .highlighted)
        }
        if let localizedTitleDisabled = localizedTitleDisabled {
            upperCased ? setTitle((&&localizedTitleDisabled).uppercased(), for: .disabled) : setTitle(&&localizedTitleDisabled, for: .disabled)
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
