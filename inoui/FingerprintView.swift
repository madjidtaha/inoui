//
//  FingerprintView.swift
//  inoui
//
//  Created by Madjid Taha on 02/12/2015.
//  Copyright © 2015 Inoui. All rights reserved.
//

import UIKit

class FingerprintView: UIView {

    var angle : CGFloat = 0;
    var locationManager: LocationManager?;

    override init(frame: CGRect) {
        super.init(frame: frame);
      
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let displayLink = CADisplayLink(target: self, selector: "update")
        displayLink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        
        self.locationManager = LocationManager();
        self.locationManager?.toggleGyro()
        self.locationManager?.choiceNumber = 360;
        
        let angle = NSMutableArray();
        for var index = 0; index < 360; index++ {
            angle[index] = index;
        }
        self.locationManager?.choices.addObjectsFromArray(angle as [AnyObject]);
//        self.locationManager = (UIApplication.sharedApplication().delegate as! AppDelegate).locationManager;

    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        // Drawing code
        let context = UIGraphicsGetCurrentContext();
        
        CGContextClearRect(context, rect)
        
        CGContextSetLineWidth(context, 1);
        CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor);
        
        let rectangle = CGRectMake(20, 20, self.bounds.width - 40, self.bounds.height - 40);
        CGContextAddEllipseInRect(context, rectangle);
        CGContextStrokePath(context);
        
        
        // TODO Make line rotate
        CGContextSaveGState(context);
        
        CGContextTranslateCTM(context, CGRectGetMidX(rect), CGRectGetMidY(rect));
        
        CGContextRotateCTM(context, angle);
//        CGContextRotateCTM(context, CGFloat((M_PI * angle) / 180));

        
        CGContextTranslateCTM(context, -CGRectGetMidX(rect), -CGRectGetMidY(rect));

        
        CGContextSetLineWidth(context, 1)
        CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor);
        
        CGContextMoveToPoint(context, self.bounds.width / 2, 0);
        CGContextAddLineToPoint(context, self.bounds.width / 2, 40);
        
        CGContextMoveToPoint(context, self.bounds.width / 2, self.bounds.height - 40);
        CGContextAddLineToPoint(context, self.bounds.width / 2, self.bounds.height);
        
        CGContextStrokePath(context);

        CGContextRestoreGState(context);


    }
    
    func update() {
        
//        print("Update");
//        print(self.locationManager?.radians);
        
//        angle += 0.1;
        angle = (self.locationManager?.radians)!;
        
        self.setNeedsDisplay();
    
    }
    
    

}
