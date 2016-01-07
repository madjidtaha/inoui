//
//  CampagneView.swift
//  inoui
//
//  Created by Madjid Taha on 07/01/2016.
//  Copyright © 2016 Inoui. All rights reserved.
//

import UIKit

class CampagneView: UIView {

    var originalImages : NSMutableArray?;
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    
        self.originalImages = NSMutableArray();
        
        for imageView in self.subviews as! [UIImageView] {
            
            self.originalImages?.addObject(imageView.image!);
            let imageToBlur : CIImage = CIImage(image: imageView.image!)!;
            let blurFilter = CIFilter(name: "CIGaussianBlur");
            blurFilter?.setValue(imageToBlur, forKey: "inputImage");
            blurFilter?.setValue(NSNumber(float: 20), forKey: "inputRadius");

            let resultImage : CIImage = blurFilter?.valueForKey("outputImage") as! CIImage;
            let blurredImage = UIImage(CIImage: resultImage);
            
            imageView.image = blurredImage;
            
        }
        
        
    }
    
}
