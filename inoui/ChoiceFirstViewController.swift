//
//  ChoiceFirstViewController.swift
//  inoui
//
//  Created by Madjid Taha on 06/01/2016.
//  Copyright © 2016 Inoui. All rights reserved.
//

import UIKit
import AVFoundation

class ChoiceFirstViewController: ChoiceController {

    @IBOutlet weak var assetsView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    var color : [UIColor] = [
        UIColor(red:0.98, green:0.92, blue:0.7, alpha:1), // Campagne
        UIColor(red:0.77, green:0.95, blue:0.94, alpha:1), // Mer
        UIColor(red:0, green:0.02, blue:0.11, alpha:1), // Ville
        UIColor(red:0.85, green:0.94, blue:0.85, alpha:1) // Tropical
    ];
    var lastChoice = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
//        self.locationManager = LocationManager();
//        self.locationManager?.delegate = self;
        //self.locationManager?.choiceNumber = 4;
        
        print("first Choice");

    }
    
    
    // MARK - FingerPrintViewControllerDelegate
    
    override func onButtonDown(sender: AnyObject) {
        self.locationManager?.toggleGyro();
        print("down \(self.locationManager?.tilt)");
        
       for var index = 0; index < self.sounds.count; index++ {
            (self.sounds[index] as! SoundsComposition).play();
        }

    }
    
    override func onButtonUp(sender: AnyObject) {
        print("up");
        self.locationManager?.toggleGyro();
        if self.lastChoice == 3 {
            // TODO Do your thang
            print("LASTCHOICE");
            
            UIView.animateWithDuration(0.7, animations: { () -> Void in
                (self.assetsView.subviews[self.lastChoice] as! TropicalView).unblurView();
                self.assetsView.subviews[4].alpha = 1;
                }, completion: { (finished) -> Void in
                    print("finished");
                    
                    
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

            });
        }
        
        for var i = 0; i < self.sounds.count; i++ {
            let soundi = ((self.sounds[i]) as! SoundsComposition);
            if(soundi.isPlaying) {
                soundi.fadeOut();
            }
        }
        
        for var index = 0; index < self.sounds.count; index++ {
            (self.sounds[index] as! SoundsComposition).stop();
        }

    }
    
    override func onChoiceChange(choice: Int) {
        for var i = 0; i < self.sounds.count; i++ {
            let soundi = ((self.sounds[i]) as! SoundsComposition);
            if(soundi.isPlaying) {
                soundi.fadeOut();
            }
        }
        let sound = ((self.sounds[choice]) as! SoundsComposition);
        print(sound.sounds[1].name);
        //(sound.sounds[1] as! Sound).placeSound(0.0, y: 0.0);
        sound.fadeIn();
        
        
        print("choice \(choice)");
        for view in self.assetsView.subviews {
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                view.alpha = 0;
            })
        }
        UIView.animateWithDuration(0.4) { () -> Void in
            self.assetsView.subviews[choice].alpha = 1;
            self.backgroundView.backgroundColor = self.color[choice];
        }
        self.lastChoice = choice;
    }
    
}
