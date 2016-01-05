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
    @IBOutlet weak var fingerprintView: UIView!
    var currentChoice: Int = -1;
    var nextStep : String?;
    var destination : String?;
    var locationManager: LocationManager?;
    var playback: Playback?;
    
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
        
        self.playback?.playSound("SOUND");
//        
//        if self.restorationIdentifier == "tutorialStep3" {
//            print("age tuto");
//            print(self.locationManager?.choiceNumber);
////            self.locationManager?.label = self.ageView!;
//            self.ageView?.text = (self.locationManager?.choice.stringValue)! as String;
//        }
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
            
//            let srcView = UIView();
//            
//            srcView.addSubview(src.view.subviews)
            
            src.view.addSubview(dst.view);
//            src.view.transform = CGAffineTransformMakeTranslation(0.0, 0.0);
            src.view.alpha = 1.0;
            
//            dst.view.transform = CGAffineTransformMakeTranslation(dst.view.bounds.size.width * 1.0, 0.0);
            dst.view.alpha = 0.0;
            
            UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                
                print("ANIMATE");
                
//                src.view.transform = CGAffineTransformMakeTranslation(src.view.bounds.size.width * -1.0, 0.0);
                //                dst!.view.transform = CGAffineTransformMakeTranslation(0.0, 0.0);
//                dst.view.center = originalCenter;

//                src.view.alpha = 0.0;
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
            
            
            
//            THIS WORK
//            self.presentViewController(vc, animated: false, completion: { () -> Void in
//                // callback here
//            });
            
            if (self.restorationIdentifier == "tutorialStep3" && self.currentChoice > -1) {
                
                NSUserDefaults.standardUserDefaults().setInteger(self.currentChoice, forKey: "userAge");
                
            }
            
        } else if self.destination != nil {
            
            let destStoryboard = UIStoryboard(name: "Choice", bundle: nil);
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
            ageView!.text = "Vous avez \(choice + 15) ans";
            ageView!.selectable = false;
            self.currentChoice = choice + 15;
        }
        
    }
    

}
