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
    
    var nextStep : String?;
    var destination : String?;
    var locationManager: LocationManager?;
    var sounds: NSMutableArray = NSMutableArray();
    var subNames = ["background", "voice", "extra"];
    var soundsNames: NSMutableArray = ["sea"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if self.restorationIdentifier == "Choice1" {
            print("Choice Here \(self.view.alpha)");
            print("\(self.view.subviews[0].alpha)");
            
            self.view.subviews[0].alpha = 0.0;
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.view.alpha = 1.0;
                self.view.subviews[0].alpha = 1.0;
            });
            
        }
        print("Choice Here \(self.view.alpha)");
        
        
        self.locationManager = LocationManager();
        self.locationManager?.delegate = self;
        

        
        self.initChoices();
        self.initSounds();
        
    }
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }
    
    func initChoices() {
        print("INITCHOICE---------");
        for var index = 0; index < self.soundsNames.count; index++ {
            self.sounds[index] = index;
            
        }
        self.locationManager?.choiceNumber = self.sounds.count;
        
        self.locationManager?.choices.addObjectsFromArray(sounds as [AnyObject]);
    }
    
    func initSounds() {
        for var i = 0; i < self.sounds.count; i++ {
            let sound: SoundsComposition = SoundsComposition();
            self.sounds[i] = sound;
            sound.index = i;
            for var j = 0; j < self.subNames.count; j++ {
                let string : String = (self.soundsNames[i] as! String) + "_" + self.subNames[j];
                print(string);
                sound.addSound(string, ext: "caf");
            }
            print(sound.index);
            sound.choiceNumber = self.sounds.count;
            sound.setPos();
        }
    }
    

    
    // MARK: - FingerprintViewControllerDelegate
    
    func onButtonDown(sender: AnyObject) {
        
        for var index = 0; index < self.sounds.count; index++ {
            (self.sounds[index] as! SoundsComposition).play();
        }

        print("nextStep \(self.nextStep)")
        self.locationManager?.toggleGyro();
        
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
//        appDelegate.playback?.playSound("SOUND");
    }
    
    func onButtonUp(sender: AnyObject) {
        print("FingerPrint from parent");
        self.locationManager?.toggleGyro();
        
        for var i = 0; i < self.sounds.count; i++ {
            let soundi = ((self.sounds[i]) as! SoundsComposition);
            if(soundi.isPlaying) {
                soundi.fadeOut();
            }
        }
        
        for var index = 0; index < self.sounds.count; index++ {
            (self.sounds[index] as! SoundsComposition).stop();
        }
        
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
    
    //MARK: - LocationManagerDelegate
    
    func onChoiceChange(choice: Int) {
        for var i = 0; i < self.sounds.count; i++ {
            let soundi = ((self.sounds[i]) as! SoundsComposition);
            if(soundi.isPlaying) {
                soundi.fadeOut();
            }
        }
        let sound = ((self.sounds[choice]) as! SoundsComposition);
        sound.fadeIn();
    }

}
