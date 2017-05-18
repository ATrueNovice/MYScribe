//
//  CircleButton.swift
//  MyScribe
//
//  Created by New on 5/18/17.
//  Copyright © 2017 HSI. All rights reserved.
//

import UIKit

@IBDesignable
class CircleButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 30.0 {
        didSet{

            setupView()
        }
    }

    override func prepareForInterfaceBuilder() {
        setupView()
    }

    func setupView()  {
        layer.cornerRadius = cornerRadius
    }

}
