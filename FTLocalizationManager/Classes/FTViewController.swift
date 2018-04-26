//
//  FTViewController.swift
//  LocalizationHandler
//
//  Created by Abdulla Kunhi on 4/26/18.
//  Copyright © 2018 Abdulla Kunhi. All rights reserved.
//

import UIKit

class FTViewController: UIViewController {
    @IBInspectable var localizedText: String? {
        didSet {
            configrueView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configrueView()
    }
    
    func configrueView() {
        if let localizedText = localizedText {
            title = NSLocalizedString(localizedText, comment: "")
        }
    }
}

