//
//  TutorialViewController.swift
//  inoui
//
//  Created by Madjid Taha on 01/12/2015.
//  Copyright © 2015 Inoui. All rights reserved.
//

import UIKit
import CoreLocation

class TutorialViewController: UIViewController, FingerprintViewControllerDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var fingerprintView: UIView!
    var nextStep : String?;
    var tilt: Bool = false;
    var startPos: CGFloat = 0.0;
    private var locationManager: CLLocationManager!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view.
        // (fingerprintView. as! FingerprintViewController).delegate = self;
        // NSUserDefaults.standardUserDefaults().setObject(true, forKey: "beginTutorial");
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
        appDelegate.playback?.addSource("sound", ext: "caf");
        
        
        locationManager = CLLocationManager();
        locationManager.delegate = self;
        locationManager.startUpdatingHeading();

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("ReceiveMemoryWarning");

    }
    
    func toggleGyro() {
        if (tilt == false) {
            tilt = true;
        } else {
            tilt = false;
        }
    }
    
    
    // MARK: - FingerprintViewControllerDelegate
    
    func onButtonDown(sender: AnyObject) {
        self.toggleGyro();
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
        appDelegate.playback?.playSound("SOUND");
    }

    func onButtonUp(sender: AnyObject) {
        print("FingerPrint from parent");
        self.toggleGyro();
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
        appDelegate.playback?.stopSound("SOUND");
        
        print(self.nextStep);
        if self.nextStep != nil {
            let destStoryboard = UIStoryboard(name: "Tutorial", bundle: nil);
            let vc = destStoryboard.instantiateViewControllerWithIdentifier("tutorialStep"+self.nextStep!);
            self.presentViewController(vc, animated: true, completion: { () -> Void in
                // callback here
            })
     
        }
    }
    
    // MARK: - CLLocationManagerDelegate

    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        if tilt {
            var radians = CGFloat(newHeading.magneticHeading) * CGFloat(M_PI) / 180.0;
            if (self.startPos == 0.0) {
                self.startPos = radians;
            }
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
            radians = -((radians - self.startPos) % (M_PI.g * 2));
            appDelegate.playback?.listenerRotation = radians;
//            print("orientation \(radians)");
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
