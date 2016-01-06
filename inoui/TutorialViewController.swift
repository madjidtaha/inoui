//
//  TutorialViewController.swift
//  inoui
//
//  Created by Madjid Taha on 01/12/2015.
//  Copyright © 2015 Inoui. All rights reserved.
//

import UIKit
import AVFoundation

class TutorialViewController: UIViewController, FingerprintViewControllerDelegate, LocationManagerDelegate {

    @IBOutlet weak var ageView: UITextView?
    var currentChoice: Int = -1;
    var nextStep : String?;
    var destination : String?;
    var locationManager: LocationManager?;
    var playback: Playback?;
    var choices: NSMutableArray?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view.
        // (fingerprintView. as! FingerprintViewController).delegate = self;
        // NSUserDefaults.standardUserDefaults().setObject(true, forKey: "beginTutorial");
        
//        self.view.backgroundColor = UIColor.clearColor();
        
        self.playback = (UIApplication.sharedApplication().delegate as! AppDelegate).playback!;
        self.playback?.addSource("sound", ext: "caf");
        
//        self.locationManager = appDelegate.locationManager;
        self.locationManager = LocationManager();
        self.locationManager?.delegate = self;
        self.locationManager?.choiceNumber = 40;

        let sessionInstance = AVAudioSession.sharedInstance();
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "handleRouteChange:",
            name: AVAudioSessionRouteChangeNotification,
            object: sessionInstance)
        
        self.choices = NSMutableArray();
        for var index = 15; index < 56; index++ {
            self.choices![index - 15] = index;
        }

        
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
        //TODO
    }
    
    
    // MARK: - FingerprintViewControllerDelegate
    
    func onButtonDown(sender: AnyObject) {
        
        self.locationManager?.toggleGyro();
        
        self.playback?.playSound("SOUND");

    }

    func onButtonUp(sender: AnyObject) {
        print("FingerPrint from parent");
        self.locationManager?.toggleGyro();
        
        self.playback?.stopSound("SOUND");
        
        print(self.nextStep);
        if self.nextStep != nil {
        
            let destStoryboard = UIStoryboard(name: "Tutorial", bundle: nil);
            let vc = destStoryboard.instantiateViewControllerWithIdentifier("tutorialStep"+self.nextStep!);

            
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

                    self.presentViewController(dst, animated: false, completion: { () -> Void in
                        // callback here
                    });
            });
            

            
            if (self.restorationIdentifier == "tutorialStep3" && self.currentChoice > -1) {
                
                NSUserDefaults.standardUserDefaults().setInteger(self.currentChoice, forKey: "userAge");
                
            }
            
        } else if self.destination != nil {
            
            let destStoryboard = UIStoryboard(name: "Choice", bundle: nil);
            let dst = destStoryboard.instantiateViewControllerWithIdentifier(self.destination!);
            
            
            let src = self;
            
            src.view.alpha = 1.0;
            
            UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                
                src.view.alpha = 0.0;
                
                },
                completion: { (finished) -> Void in
                    
                    self.presentViewController(dst, animated: false, completion: { () -> Void in
                        
                    });
            
            });
            
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
    
    // MARK: - LocationManagerDelegate
    
//    func onLocationChange(newAngle: CGFloat) {

//        print("locationChange \(newAngle)");
//        
//        if self.restorationIdentifier == "tutorialStep3" {
//            ageView!.text = "Vous avez \(newAngle) ans";
//        }
    
//    }
    
    func onChoiceChange(choice: Int) {
       
        if self.restorationIdentifier == "tutorialStep3" {
            ageView!.selectable = true;
            ageView!.text = "Vous avez \(self.choices![choice]) ans";
            ageView!.selectable = false;
            self.currentChoice = self.choices![choice] as! Int;
        }
        
    }
    

}
