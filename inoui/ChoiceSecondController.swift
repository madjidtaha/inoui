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

    var player : MPMoviePlayerController?;

    override func viewDidLoad() {
        
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
        // self.player.play();
    }
    
}
