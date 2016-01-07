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
    
    var players : NSMutableArray?;
    var videos = ["tribe", "plume"]

    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        self.locationManager?.choiceNumber = 2;
        
        self.players = NSMutableArray();
        
        for video in self.videos {
            
            let path = NSBundle.mainBundle().pathForResource( video, ofType: "mp4" )
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
                self.players?.addObject(player);
            }

        }
    
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        print("viewDidAppear \(self.players)");
        
        (self.players![0] as! MPMoviePlayerController).play();
        (self.players![1] as! MPMoviePlayerController).play();
    
    }
    
    // MARK - FingerPrintDelegate
    
    override func onButtonDown(sender: AnyObject) {
        self.locationManager?.toggleGyro()
    }
    override func onButtonUp(sender: AnyObject) {
        self.locationManager?.toggleGyro()
    }
    
    // MARK - LocationManagerDelegate
    
    override func onChoiceChange(choice: Int) {
        
        print("ONCHOICECHANGE \(choice)");
        
        if choice == 0 {
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.backgroundView.subviews[0].alpha = 1
                self.backgroundView.subviews[1].alpha = 0
                }, completion: nil)
            
        }
        else {

            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.backgroundView.subviews[0].alpha = 0
                self.backgroundView.subviews[1].alpha = 1
                }, completion: nil)

            
        }
        
//        UIView.animateWithDuration(0.4, animations: { () -> Void in
//            self.players?[choice].alpha = 1
//            }, completion: nil)
        
    }
    
}
