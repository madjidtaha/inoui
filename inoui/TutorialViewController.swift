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

    @IBOutlet weak var ageView: UITextView?
    @IBOutlet weak var fingerprintView: UIView!
    var nextStep : String?;
    var destination : String?;
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
        
        let ages = NSMutableArray();
        for var index = 15; index < 56; index++ {
            ages[index - 15] = index;
        }
        self.locationManager?.choices.addObjectsFromArray(ages as [AnyObject]);

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("ReceiveMemoryWarning");
    }
    
    func handleRouteChange(notification: NSNotification) {
        let currentRoute = AVAudioSession.sharedInstance().currentRoute;
       
        for description in currentRoute.outputs {
            if description.portType == AVAudioSessionPortHeadphones {
                print("headphone plugged in")
            } else {
                print("headphone pulled out")
                
                if let topController = (UIApplication.sharedApplication().delegate as! AppDelegate).navigationController {
 
                    let pauseStoryboard = UIStoryboard(name: "Pause", bundle: nil)
                    let pauseViewController = pauseStoryboard.instantiateInitialViewController();

                    pauseViewController!.modalPresentationStyle = UIModalPresentationStyle.FullScreen;
                    pauseViewController!.modalTransitionStyle = UIModalTransitionStyle.CoverVertical;
                    
                    topController.presentViewController(pauseViewController!, animated: true, completion: nil);
                    

                }
            }
        }
    }
    
    func disablePause() {
        //TO DO 
    }
    
    
    // MARK: - FingerprintViewControllerDelegate
    
    func onButtonDown(sender: AnyObject) {
        self.locationManager?.toggleGyro();
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
        appDelegate.playback?.playSound("SOUND");
        
        if self.restorationIdentifier == "tutorialStep3" {
            print("age tuto");
            print(self.locationManager?.choiceNumber);
            self.locationManager?.label = self.ageView!;
            self.ageView?.text = (self.locationManager?.choice.stringValue)! as String;
        }
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

//            if ((self.locationManager?.choice)! as! NSInteger == 22) {
//                let string = (self.locationManager?.choice.stringValue)! as String;
//                 vc = destStoryboard.instantiateViewControllerWithIdentifier("tutorialStep"+(string as String));
//            } else {
//            }
            
            
            vc = destStoryboard.instantiateViewControllerWithIdentifier("tutorialStep"+self.nextStep!);

            self.presentViewController(vc, animated: false, completion: { () -> Void in
                // callback here
            })
        } else if self.destination != nil {
            print("Last step");
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
