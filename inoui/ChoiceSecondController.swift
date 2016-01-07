
//
//  ChoiceSecondController.swift
//  inoui
//
//  Created by Madjid Taha on 06/01/2016.
//  Copyright © 2016 Inoui. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class ChoiceSecondController: ChoiceController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var assetsView: UIView!
    var lastChoice : Int?;
   
    var player : MPMoviePlayerController?;
    var videos = ["cascade"]

    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.locationManager?.choiceNumber = 2;
        
        self.backgroundView.backgroundColor = UIColor(red:0.12, green:0.14, blue:0.14, alpha:1);
        
        let path = NSBundle.mainBundle().pathForResource( "cascade", ofType: "mp4" )
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
    
    
    // MARK - FingerPrintDelegate
    override func onButtonDown(sender: AnyObject) {
//        super.onButtonDown(sender);
        self.locationManager?.toggleGyro();

        print("\(self.locationManager?.tilt)")
    }
    override func onButtonUp(sender: AnyObject) {
//        super.onButtonUp(sender);
        self.locationManager?.toggleGyro();

        print("\(self.locationManager?.tilt)")
        
        if self.lastChoice == 1 {
            
            UIView.animateWithDuration(0.7, animations: { () -> Void in
                (self.assetsView.subviews[0] as! TropicalView).unblurView();
                self.assetsView.subviews[1].alpha = 1;
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
        
        
        
    }
    
    // MARK - LocationManagerDelegate
    
    override func onChoiceChange(choice: Int) {
        super.onChoiceChange(choice);
        
        print("location \(choice)");
        
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.player!.view.alpha = choice.g
            }, completion: nil)
        
        
        self.lastChoice = choice;
        
        
        
        
        
        
    }
    
}
