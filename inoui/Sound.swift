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
    var oldPos: CGPoint = CGPoint();
    var index: NSInteger = 0;
    var name = String();
    var playback = Playback?();
    var backgroundTimer = NSTimer();
    var voiceTimer = NSTimer();
    var extraTimer = NSTimer();
    var number = -1;
    
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
        self.oldPos = self.pos;
        switch(self.type){
            case "background":
                self.backgroundTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector:  Selector("backgroundAnimate"), userInfo: nil, repeats: true);
                break;
            case "voice":
                self.voiceTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector:  Selector("voiceAnimate"), userInfo: nil, repeats: true);
                break;
            case "extra":
                self.extraTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector:  Selector("extraAnimate"), userInfo: nil, repeats: true);
                break;
            default:
                break;
        }
    }
    
    func stopAnimate() {
        self.backgroundTimer.invalidate();
        self.voiceTimer.invalidate();
        self.extraTimer.invalidate();
        self.placeSound(self.oldPos.x, y: self.oldPos.y)
    }
    
    func backgroundAnimate() {
        
    }
    
    func voiceAnimate() {
        
        if (self.pos.x <= self.oldPos.x - 60.5) {
            number = 1;
        } else if (self.pos.x >= self.oldPos.x + 60.5){
            number = -1;
        }
        self.placeSound(self.pos.x + number.g * 4, y: self.pos.y);
        print(self.pos.x);
        print(self.pos.y);
        print(self.name);
    }
    
    func extraAnimate() {
        
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