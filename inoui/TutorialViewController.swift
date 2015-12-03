//
//  TutorialViewController.swift
//  inoui
//
//  Created by Madjid Taha on 01/12/2015.
//  Copyright © 2015 Inoui. All rights reserved.
//

import UIKit
import AVFoundation

class TutorialViewController: UIViewController, FingerprintViewControllerDelegate {

    @IBOutlet weak var fingerprintView: UIView!
    var nextStep : String?;
    var locationManager: LocationManager?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view.
        // (fingerprintView. as! FingerprintViewController).delegate = self;
        // NSUserDefaults.standardUserDefaults().setObject(true, forKey: "beginTutorial");
        
        self.locationManager = LocationManager();
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
        appDelegate.playback?.addSource("sound", ext: "caf");
        
        let sessionInstance = AVAudioSession.sharedInstance();
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "handleRouteChange:",
            name: AVAudioSessionRouteChangeNotification,
            object: sessionInstance)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("ReceiveMemoryWarning");

    }
    
    func handleRouteChange(notification: NSNotification) {
//        print(notification)
        let currentRoute = AVAudioSession.sharedInstance().currentRoute;
       
        for description in currentRoute.outputs {
            if description.portType == AVAudioSessionPortHeadphones {
                print("headphone plugged in")
            } else {
                print("headphone pulled out")
            }
        }
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
            let destStoryboard = UIStoryboard(name: "Tutorial", bundle: nil);
            let vc = destStoryboard.instantiateViewControllerWithIdentifier("tutorialStep"+self.nextStep!);
            self.presentViewController(vc, animated: false, completion: { () -> Void in
                // callback here
            })
     
        }
    }
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
