//
//  TropicalView.swift
//  inoui
//
//  Created by Madjid Taha on 07/01/2016.
//  Copyright © 2016 Inoui. All rights reserved.
//

import UIKit

class TropicalView: UIView {

    var originalView : NSMutableArray?;
    var originalImages : NSMutableArray?;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.originalView = NSMutableArray();
        self.originalImages = NSMutableArray();
        
        for imageView in self.subviews as! [UIImageView] {
            
            self.originalView?.addObject(imageView);
            self.originalImages?.addObject(imageView.image!);
            
            let imageToBlur : CIImage = CIImage(image: imageView.image!)!;
            let blurFilter = CIFilter(name: "CIGaussianBlur");
            blurFilter?.setValue(imageToBlur, forKey: "inputImage");
            blurFilter?.setValue(NSNumber(float: 5), forKey: "inputRadius");
            
            let resultImage : CIImage = blurFilter?.valueForKey("outputImage") as! CIImage;
            let blurredImage = UIImage(CIImage: resultImage);
            
            imageView.image = blurredImage;
            
        }
        
        self.initAnimation();
        
    }
    
    func initAnimation() {
        
        
        let animation = CAKeyframeAnimation(keyPath: "transform")
        animation.values = [
            NSValue(CATransform3D: CATransform3DMakeRotation(0, 0, 0, 1)),
            NSValue(CATransform3D: CATransform3DMakeRotation(3 * CGFloat(M_PI/180.0), 0, 0, 1)),
            NSValue(CATransform3D: CATransform3DMakeRotation(0, 0, 0, 1))
        ]
        animation.keyTimes = [ 0.0, 0.3, 1.0 ]
        animation.duration = 7
        animation.repeatCount = Float.infinity
        animation.removedOnCompletion = false
        animation.fillMode = kCAFillModeBoth
        
        for imageView in self.subviews as! [UIImageView] {

            imageView.layoutIfNeeded()
            imageView.layer.addAnimation(animation, forKey: "transform")

        }

    }

    func unblurView() {
        let originalView = NSArray(array: self.originalView!);
        
        for var i = 0; i < self.originalView?.count; i++ {
            (originalView[i] as! UIImageView).alpha = 0;
        }
        
//        UIView.animateWithDuration(0.5, animations: { () -> Void in
//            for var i = 0; i < self.originalView?.count; i++ {
//                (originalView[i] as! UIImageView).alpha = 0;
//                (unblurredView[i] as! UIImageView).alpha = 1;
//            }
//            
//            
//            }) { (finished) -> Void in
//                print("COMPLETE");
//        }
    }
    
    
}
