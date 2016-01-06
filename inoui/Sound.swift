//
//  Sound.swift
//  inoui
//
//  Created by Chloé Henaut on 04/01/2016.
//  Copyright © 2016 Inoui. All rights reserved.
//

import UIKit
import AVFoundation

class Sound: NSObject {
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
    var pos: CGPoint = CGPoint();
    var index: NSInteger = 0;
    
    func initSound (name: String, ext: String) {
        appDelegate.playback?.addSource(name, ext: ext);
        self.index = (appDelegate.playback?.counter)! - 1;
        print(self.index);
    }
    
    func placeSound(x:CGFloat, y:CGFloat) {
        self.pos.x = x;
        self.pos.y = y;
        appDelegate.playback?.changePos(self.index, SOURCEPOS: self.pos);
    }
    
    
    
}