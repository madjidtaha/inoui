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
    var name = String();
    var playback = Playback?();
    var backgroundTimer = NSTimer();
    
    override init() {
        super.init();
        self.playback = (UIApplication.sharedApplication().delegate as! AppDelegate).playback!;
        
        
        //backgroundTimer.invalidate();
    }
    
    func initSound (name: String, ext: String) {
        appDelegate.playback?.addSource(name, ext: ext);
        self.name = name.uppercaseString;
        self.index = (appDelegate.playback?.counter)! - 1;
    }
    
    func placeSound(x:CGFloat, y:CGFloat) {
        self.pos.x = x;
        self.pos.y = y;
        appDelegate.playback?.changePos(self.index, SOURCEPOS: self.pos);
    }
    
    func play(){
        self.playback?.playSound(self.name);
    }
    
    func stop(){
        self.playback?.stopSound(self.name);
    }
    
    func animate() {
        
        switch(self.type){
            case "background":
//                self.backgroundTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector:  Selector("backgroundAnimate"), userInfo: nil, repeats: true);
                break;
            case "voice":
                break;
            case "extra":
                break;
            default:
                break;
        }
    }
    
    func stopAnimate() {
        self.backgroundTimer.invalidate();
    }
    
    func backgroundAnimate() {
        if (self.pos.x > -100) {
            self.placeSound(self.pos.x - 1, y: self.pos.y);
        } else if (self.pos.x < 100){
            self.placeSound(self.pos.x - 1, y: self.pos.y);
        } else {
            self.placeSound(self.pos.x - 1, y: self.pos.y);
        }
        print(self.pos.x);
    }
    
    
    //MARK: Setters / Getters
    
    // The coordinates of the sound source
    private var _type: String = String()
    dynamic var type: String {
        get {
            return self._type;
        }
        
        set(TYPE) {
            self._type = TYPE;
            print(self._type);
        }
    }
    

}