//
//  CampagneView.swift
//  inoui
//
//  Created by Madjid Taha on 07/01/2016.
//  Copyright © 2016 Inoui. All rights reserved.
//

import UIKit

class CampagneView: TropicalView {
//
//    var originalImages : NSMutableArray?;
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame);
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    
//        self.originalImages = NSMutableArray();
//        
//        for imageView in self.subviews as! [UIImageView] {
//            
//            self.originalImages?.addObject(imageView.image!);
//            let imageToBlur : CIImage = CIImage(image: imageView.image!)!;
//            let blurFilter = CIFilter(name: "CIGaussianBlur");
//            blurFilter?.setValue(imageToBlur, forKey: "inputImage");
//            blurFilter?.setValue(NSNumber(float: 10), forKey: "inputRadius");
//
//            let resultImage : CIImage = blurFilter?.valueForKey("outputImage") as! CIImage;
//            let blurredImage = UIImage(CIImage: resultImage);
//            
//            imageView.image = blurredImage;
//            
//        }
//        
//        self.initAnimation()
//        
//    }
//    
//    func initAnimation() {
//        
//        
//        let transformAnim = CAKeyframeAnimation(keyPath:"transform")
//        transformAnim.values = [NSValue(CATransform3D: CATransform3DMakeRotation(3 * CGFloat(M_PI/180), 0, 0, -1)),
//            NSValue(CATransform3D: CATransform3DConcat(CATransform3DMakeScale(1.5, 1.5, 1), CATransform3DMakeRotation(3 * CGFloat(M_PI/180), 0, 0, 1))),
//            NSValue(CATransform3D: CATransform3DMakeScale(1.5, 1.5, 1)),
//            NSValue(CATransform3D: CATransform3DConcat(CATransform3DMakeScale(1.5, 1.5, 1), CATransform3DMakeRotation(-8 * CGFloat(M_PI/180), 0, 0, 1)))]
//        transformAnim.keyTimes = [0, 0.349, 0.618, 1]
//        transformAnim.duration = 1
//        transformAnim.repeatCount = Float.infinity
//        transformAnim.fillMode = kCAFillModeBoth
//        transformAnim.removedOnCompletion = false
////
//        //        self.testView.layer.addAnimation(transformAnim, forKey: "transform")
//        
//        let animation = CAKeyframeAnimation(keyPath: "transform")
//        animation.values = [
//            NSValue(CATransform3D: CATransform3DMakeRotation(0, 0, 0, 1)),
//            NSValue(CATransform3D: CATransform3DMakeRotation(30 * CGFloat(M_PI/180.0), 0, 0, 1)),
//            NSValue(CATransform3D: CATransform3DMakeRotation(0, 0, 0, 1))
//        ]
//        animation.keyTimes = [ 0.0, 0.3, 1.0 ]
//        animation.duration = 0.3
//        animation.repeatCount = Float.infinity
//        animation.removedOnCompletion = false
//        animation.fillMode = kCAFillModeBoth
//
//        
//        for imageView in self.subviews as! [UIImageView] {
//            //            imageView.layer.addAnimation(animation, forKey: "transform")
//            imageView.layoutIfNeeded()
//            imageView.layer.addAnimation(animation, forKey: "transform")
//        }
//    }
    
}
