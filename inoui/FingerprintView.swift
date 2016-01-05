//
//  FingerprintView.swift
//  inoui
//
//  Created by Madjid Taha on 02/12/2015.
//  Copyright © 2015 Inoui. All rights reserved.
//

import UIKit

class FingerprintView: UIView, LocationManagerDelegate {

    var angle : CGFloat = 0;
    var locationManager: LocationManager?;

    override init(frame: CGRect) {
        super.init(frame: frame);
      
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        let displayLink = CADisplayLink(target: self, selector: "update")
//        displayLink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        
        self.locationManager = LocationManager();
        self.locationManager?.delegate = self;
        self.locationManager?.choiceNumber = 360;
        
        let angle = NSMutableArray();
        for var index = 0; index < self.locationManager?.choiceNumber; index++ {
            angle[index] = index;
        }
        self.locationManager?.choices.addObjectsFromArray(angle as [AnyObject]);
        self.locationManager?.toggleGyro();
        
//        self.locationManager = (UIApplication.sharedApplication().delegate as! AppDelegate).locationManager;
        
        self.opaque = false;

    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        super.drawRect(rect);
        
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
        
        CGContextMoveToPoint(context, self.bounds.width / 2, 7);
        CGContextAddLineToPoint(context, self.bounds.width / 2, 32);
        
        CGContextMoveToPoint(context, self.bounds.width / 2, self.bounds.height - 32);
        CGContextAddLineToPoint(context, self.bounds.width / 2, self.bounds.height - 7);
        
        CGContextStrokePath(context);

        CGContextRestoreGState(context);
        
//        for (var i = 0; i < 360; i += 2) {
//            
//            CGContextSaveGState(context);
//            
//            CGContextTranslateCTM(context, CGRectGetMidX(rect), CGRectGetMidY(rect));
//            
////            CGContextRotateCTM(context, angle);
//            CGContextRotateCTM(context, CGFloat((M_PI * i.d) / 180));
//            
//            
//            CGContextTranslateCTM(context, -CGRectGetMidX(rect), -CGRectGetMidY(rect));
//            
//            
//            CGContextSetLineWidth(context, 1)
//            CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor);
//            
//            CGContextMoveToPoint(context, self.bounds.width / 2, 35);
//            CGContextAddLineToPoint(context, self.bounds.width / 2, 45);
//            
//            CGContextMoveToPoint(context, self.bounds.width / 2, self.bounds.height - 45);
//            CGContextAddLineToPoint(context, self.bounds.width / 2, self.bounds.height - 35);
//            
//            CGContextStrokePath(context);
//            
//            CGContextRestoreGState(context);
//            
//        }


    }
    
    func update() {
        
//        print("Update");
//        print(self.locationManager?.radians);
        
//        angle += 0.1;
//        angle = (self.locationManager?.radians)!;
        
//        self.setNeedsDisplay();
    
    }
    
    // MARK: - LocationManagerDelegate

    func onLocationChange(newAngle: CGFloat) {
//        print(" Fingerprint \(newAngle)");
        
        angle = newAngle;
        
        self.setNeedsDisplay();
    }
    

}
