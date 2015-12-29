//
//  FingerprintView.swift
//  inoui
//
//  Created by Madjid Taha on 02/12/2015.
//  Copyright © 2015 Inoui. All rights reserved.
//

import UIKit

class FingerprintView: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 1);
        CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor);
        
        let rectangle = CGRectMake(20, 20, self.bounds.width - 40, self.bounds.height - 40);
        CGContextAddEllipseInRect(context, rectangle);
        CGContextStrokePath(context);
        
        
        // TODO Make line rotate
        
        CGContextSetLineWidth(context, 1)
        CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor);
        
        CGContextMoveToPoint(context, self.bounds.width / 2, 0);
        CGContextAddLineToPoint(context, self.bounds.width / 2, 40);
        
        CGContextMoveToPoint(context, self.bounds.width / 2, self.bounds.height - 40);
        CGContextAddLineToPoint(context, self.bounds.width / 2, self.bounds.height);
        
        CGContextStrokePath(context);


    }
    

}
