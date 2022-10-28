//
//  UILabel+EXT.swift
//  Dailly_Challenge_SearchView
//
//  Created by Hertz on 9/15/22.
//

import UIKit

class PaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 0.0
    
    @IBInspectable var bottomInset: CGFloat = 10.0
    
    @IBInspectable var leftInset: CGFloat = 16.0
    
    @IBInspectable var rightInset: CGFloat = 0.0
 
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
}
