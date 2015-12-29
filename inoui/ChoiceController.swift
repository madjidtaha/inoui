//
//  ChoiceController.swift
//  inoui
//
//  Created by Chloé Henaut on 04/12/2015.
//  Copyright © 2015 Inoui. All rights reserved.
//

import UIKit
import AVFoundation

class ChoiceController: UIViewController, FingerprintViewControllerDelegate {
    
    @IBOutlet weak var fingerprintView: UIView!
    var nextStep : String?;
    var locationManager: LocationManager?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }
    
    func placeSounds() {
        
    }
    
    // MARK: - FingerprintViewControllerDelegate
    
    func onButtonDown(sender: AnyObject) {
        self.locationManager?.toggleGyro();
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
        appDelegate.playback?.playSound("SOUND");
    }
    
    func onButtonUp(sender: AnyObject) {
        print("FingerPrint from parent");
        self.locationManager?.toggleGyro();
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
        appDelegate.playback?.stopSound("SOUND");
        
        print(self.nextStep);
        if self.nextStep != nil {
            print("You choose");
            print(self.locationManager?.choice);
            let destStoryboard = UIStoryboard(name: "Tutorial", bundle: nil);
            var vc = destStoryboard.instantiateViewControllerWithIdentifier("tutorialStep1");
            
            if ((self.locationManager?.choice)! as! NSInteger == 22) {
                let string = (self.locationManager?.choice.stringValue)! as String;
                vc = destStoryboard.instantiateViewControllerWithIdentifier("tutorialStep"+(string as String));
            } else {
                vc = destStoryboard.instantiateViewControllerWithIdentifier("tutorialStep"+self.nextStep!);
            }
            self.presentViewController(vc, animated: false, completion: { () -> Void in
                // callback here
            })
        }
    }
    

}
