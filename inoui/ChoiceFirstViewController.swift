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
        
//        self.locationManager = LocationManager();
//        self.locationManager?.delegate = self;
        //self.locationManager?.choiceNumber = 4;
        
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
        
//        self.initChoices();
//        self.initSounds();
    }
    
    override func viewDidAppear(animated: Bool) {
//        self.player!.play()
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
        if lastChoice == 3 {
            // TODO Do your thang
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
        
    }
    
}
