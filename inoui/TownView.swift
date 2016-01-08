//
//  TownView.swift
//  inoui
//
//  Created by Madjid Taha on 08/01/2016.
//  Copyright © 2016 Inoui. All rights reserved.
//

import UIKit

class TownView: TropicalView {
    
    override func initAnimation() {
        
        
        for imageView in self.subviews as! [UIImageView] {
            
            let animation = CAKeyframeAnimation(keyPath: "transform")
            animation.values = [
                NSValue(CATransform3D: CATransform3DMakeTranslation(0, 0, 1)),
                NSValue(CATransform3D: CATransform3DMakeTranslation(CGFloat(Int(arc4random_uniform(3)) - 1), CGFloat(Int(arc4random_uniform(3)) - 1), 1)  ),
                NSValue(CATransform3D: CATransform3DMakeTranslation(CGFloat(Int(arc4random_uniform(3)) - 1), CGFloat(Int(arc4random_uniform(3)) - 1), 1)  ),
                NSValue(CATransform3D: CATransform3DMakeTranslation(0, 0, 1))
            ]
            animation.keyTimes = [ 0.0, 0.3, 0.7, 1.0 ]
            animation.duration = 3
            animation.repeatCount = Float.infinity
            animation.removedOnCompletion = false
            animation.fillMode = kCAFillModeBoth
            
            imageView.layoutIfNeeded()
            imageView.layer.addAnimation(animation, forKey: "transform")
            
        }
        
    }
    
}
