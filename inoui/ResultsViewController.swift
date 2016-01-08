//
//  ResultsViewController.swift
//  inoui
//
//  Created by Madjid Taha on 04/01/2016.
//  Copyright © 2016 Inoui. All rights reserved.
//

import UIKit
import AVFoundation

class ResultsViewController: UIViewController {
 
    @IBOutlet weak var scrollView: UIScrollView!
    var imageView : UIImageView?
    
    override func viewDidLoad() {
    
        let scrollImage = UIImage(named: "Result");
        print("ResultsViewController \(scrollImage)");
        
        scrollView.frame.origin.x = 0.0;
        
        scrollView.frame.origin.y = 0.0;
        
        scrollView.frame.size = UIScreen.mainScreen().bounds.size;
        
        self.imageView = UIImageView(image: scrollImage);
        
        let height = (scrollImage?.size.height)! * (UIScreen.mainScreen().bounds.size.width / (scrollImage?.size.width)!);

        self.imageView?.frame = CGRectMake((self.imageView?.frame.origin.x)!, (self.imageView?.frame.origin.y)!, UIScreen.mainScreen().bounds.size.width, height );
        
        scrollView.contentSize = CGSize(width: 1.0, height: height);
        
        scrollView.addSubview(self.imageView!);
        
        let button1 = UIButton(type: UIButtonType.System) as UIButton
        button1.frame = CGRectMake(154 * (UIScreen.mainScreen().bounds.size.width / (scrollImage?.size.width)!), 589 * (UIScreen.mainScreen().bounds.size.width / (scrollImage?.size.width)!), 75, 74)
        button1.setBackgroundImage(UIImage(named: "Select"), forState: .Normal);
        button1.setTitle("button1", forState: UIControlState.Disabled);
        button1.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        scrollView.addSubview(button1)
        
        let button2 = UIButton(type: UIButtonType.System) as UIButton
        button2.frame = CGRectMake(120 * (UIScreen.mainScreen().bounds.size.width / (scrollImage?.size.width)!), 1050 * (UIScreen.mainScreen().bounds.size.width / (scrollImage?.size.width)!), 75, 74)
        button2.setBackgroundImage(UIImage(named: "Select"), forState: .Normal);
        button2.setTitle("button2", forState: UIControlState.Disabled);
        button2.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        scrollView.addSubview(button2)
        
        
        let button3 = UIButton(type: UIButtonType.System) as UIButton
        button3.frame = CGRectMake(155 * (UIScreen.mainScreen().bounds.size.width / (scrollImage?.size.width)!), 1730 * (UIScreen.mainScreen().bounds.size.width / (scrollImage?.size.width)!), 75, 74)
        button3.setBackgroundImage(UIImage(named: "Select"), forState: .Normal);
        button3.setTitle("button3", forState: UIControlState.Disabled);
        button3.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        scrollView.addSubview(button3)
        
//        let button4 = UIButton(type: UIButtonType.System) as UIButton
//        button4.frame = CGRectMake(154 * (UIScreen.mainScreen().bounds.size.width / (scrollImage?.size.width)!), 589 * (UIScreen.mainScreen().bounds.size.width / (scrollImage?.size.width)!), 75, 74)
//        button4.setBackgroundImage(UIImage(named: "Select"), forState: .Normal);
//        //        button4.setTitle("Test Button", forState: UIControlState.Normal)
//        button4.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
//        
//        scrollView.addSubview(button3)
        
        print("size \(UIScreen.mainScreen().bounds.size)");
        
        print("button \(button1.frame.origin.x) \(button1.frame.origin.y) \(button2.frame.origin.x) \(button2.frame.origin.y) \(button3.frame.origin.x) \(button3.frame.origin.y)");

    }
    
    override func viewDidAppear(animated: Bool) {
    
        scrollView.contentInset.top = 0;
        
    }
    
    func buttonAction(sender: UIButton!) {
        
        print("buttonAction \(sender.frame) \(sender.titleForState(.Disabled)) \(self.navigationController)");
        if sender.titleForState(.Disabled) == "button3" {
//            if let topController = self.navigationController {
            
            let pauseStoryboard = UIStoryboard(name: "Product", bundle: nil)
            let pauseViewController = pauseStoryboard.instantiateInitialViewController();
            
            pauseViewController!.modalPresentationStyle = UIModalPresentationStyle.FullScreen;
            pauseViewController!.modalTransitionStyle = UIModalTransitionStyle.CoverVertical;
            
            self.presentViewController(pauseViewController!, animated: true, completion: { () -> Void in
                print("oker");
            })
            
            if let topController = (UIApplication.sharedApplication().delegate as! AppDelegate).navigationController {
            
                print("LAAA")
                
                let pauseStoryboard = UIStoryboard(name: "Product", bundle: nil)
                let pauseViewController = pauseStoryboard.instantiateInitialViewController();
                
                pauseViewController!.modalPresentationStyle = UIModalPresentationStyle.FullScreen;
                pauseViewController!.modalTransitionStyle = UIModalTransitionStyle.CoverVertical;
                
                topController.presentViewController(pauseViewController!, animated: true, completion: nil);
                
            }
            
        }
   
    }
    
}
