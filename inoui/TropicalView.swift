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
    var unblurredView : NSMutableArray?;

    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.originalView = NSMutableArray();
        self.originalImages = NSMutableArray();
        self.unblurredView = NSMutableArray();
        
        for imageView in self.subviews as! [UIImageView] {
            
            self.originalView?.addObject(imageView);
            self.originalImages?.addObject(imageView.image!);
            
            let unblurView = UIImageView(image: imageView.image);
            unblurView.frame = imageView.frame;
            unblurView.alpha = 1;
            unblurView.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.2);
            
            self.unblurredView?.addObject(unblurView);
            self.addSubview(unblurView);
            
            let imageToBlur : CIImage = CIImage(image: imageView.image!)!;
            let blurFilter = CIFilter(name: "CIGaussianBlur");
            blurFilter?.setValue(imageToBlur, forKey: "inputImage");
            blurFilter?.setValue(NSNumber(float: 20), forKey: "inputRadius");
            
            let resultImage : CIImage = blurFilter?.valueForKey("outputImage") as! CIImage;
            let blurredImage = UIImage(CIImage: resultImage);
            
            imageView.image = blurredImage;
            
        }
        
    }

    func unblurView() {
        let originalView = NSArray(array: self.originalView!);
        let unblurredView = NSArray(array: self.unblurredView!);
        
        for var i = 0; i < self.originalView?.count; i++ {
            (originalView[i] as! UIImageView).alpha = 0;
            (unblurredView[i] as! UIImageView).alpha = 1;
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
