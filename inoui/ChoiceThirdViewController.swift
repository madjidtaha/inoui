    //
//  ChoiceThirdViewController.swift
//  inoui
//
//  Created by Madjid Taha on 07/01/2016.
//  Copyright © 2016 Inoui. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class ChoiceThirdViewController: ChoiceController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var assetsView: UIView!
    
    var videos = ["tribe", "plume"]
    var player : MPMoviePlayerController?;
    var lastChoice = 0;
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        self.locationManager?.choiceNumber = 2;
        self.backgroundView.backgroundColor = UIColor(red:0.78, green:0.85, blue:0.78, alpha:1);

        let path = NSBundle.mainBundle().pathForResource( "plume", ofType: "mp4" )
        let url = NSURL.fileURLWithPath( path! )
        let moviePlayer = MPMoviePlayerController( contentURL: url );
            
        if let player = moviePlayer {
            player.view.frame = CGRectMake( 0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
            player.prepareToPlay()
            player.shouldAutoplay = true
            player.scalingMode = .AspectFill
            player.controlStyle = .None
            player.repeatMode = MPMovieRepeatMode.One
                
            player.backgroundView.backgroundColor = UIColor.clearColor()
            player.view.backgroundColor = UIColor.clearColor()
            
            for subView in moviePlayer!.view.subviews {
                subView.backgroundColor = UIColor.clearColor()
            }
            //
            self.backgroundView.insertSubview(player.view, atIndex: player.view.subviews.count);
            self.player = player;
        }
        
    
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        self.player!.play();
    
    }
    
    override func initChoices() {
        self.soundsNames = ["tribe", "animals"];
        print("INITCHOICE---------");
        for var index = 0; index < self.soundsNames.count; index++ {
            self.sounds[index] = index;
            
        }
        self.locationManager?.choiceNumber = self.sounds.count;
        
        self.locationManager?.choices.addObjectsFromArray(sounds as [AnyObject]);
        
        
    }
    
    // MARK - FingerPrintDelegate
    
    override func onButtonDown(sender: AnyObject) {
        super.onButtonDown(sender);
        //self.locationManager?.toggleGyro()
    }
    override func onButtonUp(sender: AnyObject) {
        self.locationManager?.toggleGyro()
        
        
        if self.lastChoice == 1 {
            
            UIView.animateWithDuration(0.7, animations: { () -> Void in
                //                (self.assetsView.subviews[0] as! TropicalView).unblurView();
                //                self.assetsView.subviews[1].alpha = 1;
                self.view.alpha = 0;
                }, completion: { (finished) -> Void in
                    print("finished");
                    
                    
                    let destStoryboard = UIStoryboard(name: "Results", bundle: nil);
                    let dst = destStoryboard.instantiateViewControllerWithIdentifier("Results");
                    
                    
                    let src = self;
                    
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
    
    // MARK - LocationManagerDelegate
    
    override func onChoiceChange(choice: Int) {
        super.onChoiceChange(choice);
        
        print("ONCHOICECHANGE \(choice)");
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.player?.view.alpha = choice.g
            }, completion: nil)
        
        
        for view in self.assetsView.subviews {
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                view.alpha = 0;
            })
        }
        UIView.animateWithDuration(0.4) { () -> Void in
            self.assetsView.subviews[choice].alpha = 1;
        }
        
        self.lastChoice = choice;
        
//        UIView.animateWithDuration(0.4, animations: { () -> Void in
//            self.players?[choice].alpha = 1
//            }, completion: nil)
        
    }
}
