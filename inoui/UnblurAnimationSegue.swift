//
//  UnblurAnimationSegue.swift
//  inoui
//
//  Created by Madjid Taha on 01/12/2015.
//  Copyright © 2015 Inoui. All rights reserved.
//

import UIKit

@objc(UnblurAnimationSegue)
class UnblurAnimationSegue: UIStoryboardSegue {
    override func perform () {
        let src = self.sourceViewController as UIViewController
        let dst = self.destinationViewController as UIViewController
        
        // src.navigationController!.pushViewController(dst, animated:false)
    
        src.view.addSubview(dst.view);
        dst.view.transform = CGAffineTransformMakeScale(0.05, 0.05);
        
        let originalCenter : CGPoint = src.view.center;

        dst.view.center = originalCenter;
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            // animation
            dst.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
            dst.view.center = originalCenter;
            
        }, completion: { (finished) -> Void in
                // complete
            print("complete");
            print(finished);
            
            dst.view.removeFromSuperview(); // remove from temp super view
            src.presentViewController(dst, animated: false, completion: nil);
            //        [sourceViewController presentViewController:destinationViewController animated:NO completion:NULL]; // present
        });
    
    }
}


//
//- (void)perform {
//    UIViewController *sourceViewController = self.sourceViewController;
//    UIViewController *destinationViewController = self.destinationViewController;
//    
//    // Add the destination view as a subview, temporarily
//    [sourceViewController.view addSubview:destinationViewController.view];
//    
//    // Transformation start scale
//    destinationViewController.view.transform = CGAffineTransformMakeScale(0.05, 0.05);
//    
//    // Store original centre point of the destination view
//    CGPoint originalCenter = destinationViewController.view.center;
//    // Set center to start point of the button
//    destinationViewController.view.center = self.originatingPoint;
//    
//    [UIView animateWithDuration:0.5
//        delay:0.0
//        options:UIViewAnimationOptionCurveEaseInOut
//        animations:^{
//        // Grow!
//        destinationViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
//        destinationViewController.view.center = originalCenter;
//        }
//        completion:^(BOOL finished){
//        [destinationViewController.view removeFromSuperview]; // remove from temp super view
//        [sourceViewController presentViewController:destinationViewController animated:NO completion:NULL]; // present VC
//        }];
//}
//
