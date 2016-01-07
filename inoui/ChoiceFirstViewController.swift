//
//  ChoiceFirstViewController.swift
//  inoui
//
//  Created by Madjid Taha on 06/01/2016.
//  Copyright © 2016 Inoui. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class ChoiceFirstViewController: ChoiceController {

    @IBOutlet weak var assetsView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    var player : MPMoviePlayerController?;
    var color : [UIColor] = [
        UIColor(red:0.98, green:0.92, blue:0.7, alpha:1), // Campagne
        UIColor(red:0.77, green:0.95, blue:0.94, alpha:1), // Mer
        UIColor(red:0, green:0.02, blue:0.11, alpha:1), // Ville
        UIColor(red:0.85, green:0.94, blue:0.85, alpha:1) // Tropical
    ];
    var lastChoice = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.locationManager = LocationManager();
        self.locationManager?.delegate = self;
        self.locationManager?.choiceNumber = 4;
        
        print("first Choice");
        
//        let path = NSBundle.mainBundle().pathForResource( "cascade", ofType: "mp4" )
//        print("\(path)")
//        let url = NSURL.fileURLWithPath( path! )
//        print("\(url)")
//        let moviePlayer = MPMoviePlayerController( contentURL: url )
//        
//        if let player = moviePlayer {
//            player.view.frame = CGRectMake( 0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
//            player.prepareToPlay()
//            player.shouldAutoplay = true
//            player.scalingMode = .AspectFill
//            player.controlStyle = .None
//            player.repeatMode = MPMovieRepeatMode.One
//            
//            player.backgroundView.backgroundColor = UIColor.clearColor()
//            player.view.backgroundColor = UIColor.clearColor()
//
//            for subView in moviePlayer!.view.subviews {
//                subView.backgroundColor = UIColor.clearColor()
//            }
////
//            self.backgroundView.insertSubview(player.view, atIndex: player.view.subviews.count);
//            self.player = player;
//        }
    }
    
    override func viewDidAppear(animated: Bool) {
//        self.player!.play()
    }
    
    // MARK - FingerPrintViewControllerDelegate
    
    override func onButtonDown(sender: AnyObject) {
        self.locationManager?.toggleGyro();
        print("down");
    }
    
    override func onButtonUp(sender: AnyObject) {
        print("up");
        self.locationManager?.toggleGyro();
        if self.lastChoice == 3 {
            // TODO Do your thang
            print("LASTCHOICE");
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                (self.assetsView.subviews[self.lastChoice] as! TropicalView).unblurView();
                }, completion: { (finished) -> Void in
                    print("finished");
            });
        }
    }
    
    override func onChoiceChange(choice: Int) {
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
