//
//  IntroController.swift
//  inoui
//
//  Created by Chloé Henaut on 4/12/2015.
//  Copyright © 2015 Inoui. All rights reserved.
//

import UIKit
import AVFoundation

class IntroController: UIViewController {
    @IBOutlet var button: UIButton!;
    @IBOutlet weak var inouiLogo: UIImageView!
    @IBOutlet weak var sisleyLogo: UIImageView!
    
    @IBOutlet weak var headphoneIcon: UIImageView!
    @IBOutlet weak var introDescription: UITextView!
    //TODO Replace with real fingerprintView
    @IBOutlet weak var fingerprintView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let sessionInstance = AVAudioSession.sharedInstance();
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "handleRouteChange:",
            name: AVAudioSessionRouteChangeNotification,
            object: sessionInstance)
        
        self.handleRouteChange(nil);
        
        UIView.animateWithDuration(2, animations: { () -> Void in
            // animation
            self.inouiLogo.alpha = 0;
            self.sisleyLogo.alpha = 0;
            
            }, completion: { (finished) -> Void in
                // complete
                print("complete");
                self.inouiLogo.removeFromSuperview();
                self.sisleyLogo.removeFromSuperview();
                
                UIView.animateWithDuration(2, animations: { () -> Void in

                    self.headphoneIcon.alpha = 1;
                    self.introDescription.alpha = 1;
                    self.fingerprintView.alpha = 1;
                    
                    }, completion: nil);

        });
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleRouteChange(notification: NSNotification?) {
        let currentRoute = AVAudioSession.sharedInstance().currentRoute;
        
        for description in currentRoute.outputs {
            if description.portType == AVAudioSessionPortHeadphones {
                button.enabled = true;
            } else {
                button.enabled = false;
            }
        }
    }
    
    
    @IBAction func onButtonUp(sender: UIButton, forEvent event: UIEvent) {
        
        print("onButtonUp");
        
        // TODO Read the value from persistant storage
        let tutorialDone = true;
        var storyboard = "Results";

//        var storyboard = "Choice";
        
        if !tutorialDone {
            storyboard = "Tutorial";
        }
        print("Storyboard \(storyboard)")
        
            let src = self;
            let dst = UIStoryboard(name: storyboard, bundle: nil).instantiateInitialViewController();

            src.view.addSubview(dst!.view);
            src.view.transform = CGAffineTransformMakeTranslation(0.0, 0.0);
            dst!.view.transform = CGAffineTransformMakeTranslation(dst!.view.bounds.size.width * 1.0, 0.0);
            
            let originalCenter : CGPoint = src.view.center;
            
            UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                
                print("ANIMATE");
                
                src.view.transform = CGAffineTransformMakeTranslation(src.view.bounds.size.width * -1.0, 0.0);
                // dst!.view.transform = CGAffineTransformMakeTranslation(0.0, 0.0);
                dst!.view.center = originalCenter;
                
                }, completion: { (finished) -> Void in
                    print("Complete");
                    dst!.view.removeFromSuperview();
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.navigationController?.pushViewController(dst!, animated: false);
            });
            

    
        
        
        
    }

    
}

