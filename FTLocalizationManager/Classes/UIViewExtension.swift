//
//  UIViewExtension.swift
//  FTLocalizationManager
//
//  Created by Abdulla Kunhi on 13/04/2020.
//

import UIKit

public extension UIView {
    func forceLeftToRight() {
        guard Language.current.isRTL else { return }
        
        if #available(iOS 13.0, *) {
            semanticContentAttribute = .forceLeftToRight
        } else {
            transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        }
    }
}
