//
//  ChoiceController.swift
//  inoui
//
//  Created by Chloé Henaut on 04/12/2015.
//  Copyright © 2015 Inoui. All rights reserved.
//

import UIKit
import AVFoundation

class ChoiceController: UIViewController, FingerprintViewControllerDelegate, LocationManagerDelegate {
    
    @IBOutlet weak var fingerprintView: UIView!
    var nextStep : String?;
    var destination : String?;
    var locationManager: LocationManager?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if self.restorationIdentifier == "Choice1" {
            print("Choice Here \(self.view.alpha)");
            print("\(self.view.subviews[0].alpha)");
            
            self.view.subviews[0].alpha = 0.0;
            
            UIView.animateWithDuration(5, animations: { () -> Void in
                self.view.alpha = 1.0;
                self.view.subviews[0].alpha = 1.0;
            });
            
        }
        print("Choice Here \(self.view.alpha)");
        
        self.locationManager = LocationManager();
        self.locationManager?.delegate = self;
        
    }
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }
    
    func placeSounds() {
        
    }
    
    // MARK: - FingerprintViewControllerDelegate
    
    func onButtonDown(sender: AnyObject) {

        print("nextStep \(self.nextStep)")
        self.locationManager?.toggleGyro();
        
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
//        appDelegate.playback?.playSound("SOUND");
    }
    
    func onButtonUp(sender: AnyObject) {
        print("FingerPrint from parent");
        self.locationManager?.toggleGyro();
        
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
//        appDelegate.playback?.stopSound("SOUND");
        
        if self.nextStep != nil {
            
            let destStoryboard = UIStoryboard(name: "Choice", bundle: nil);
            let vc = destStoryboard.instantiateViewControllerWithIdentifier("Choice"+self.nextStep!);
            
            
            let src = self;
            let dst = vc;
            src.view.addSubview(dst.view);
            
            src.view.alpha = 1.0;
            
            
            dst.view.alpha = 0.0;
            
            UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                
                print("ANIMATE");
                dst.view.alpha = 1.0;
                
                
                
                }, completion: { (finished) -> Void in
                    print("Complete");
                    src.view.alpha = 0.0;
                    
                    dst.view.removeFromSuperview();
                    //                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    //                    appDelegate.navigationController?.pushViewController(dst, animated: false);
                    
                    self.presentViewController(dst, animated: false, completion: { () -> Void in
                        // callback here
                    });
            });
            
        }
        else if self.destination != nil {
            
            let destStoryboard = UIStoryboard(name: "Results", bundle: nil);
            let dst = destStoryboard.instantiateViewControllerWithIdentifier(self.destination!);
            
            
            let src = self;
            
            src.view.alpha = 1.0;
            
            // dst.view.alpha = 0.0;
            
            UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                
                print("ANIMATE");
                src.view.alpha = 0.0;
                
                },
                completion: { (finished) -> Void in
                    
                    //                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    //                    appDelegate.navigationController?.pushViewController(dst, animated: false);
                    //
                    //                    UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    //
                    //                        print("ANIMATE");
                    //                        dst.view.alpha = 1.0;
                    //
                    //                    }, completion: nil);
                    
                    
                    self.presentViewController(dst, animated: false, completion: { () -> Void in
                        
                        
                        
                    });
                    
            });
   
        }
    }
    

}
