//
//  Sound.swift
//  inoui
//
//  Created by Chloé Henaut on 04/01/2016.
//  Copyright © 2016 Inoui. All rights reserved.
//

import UIKit
import AVFoundation

class SoundsComposition: NSObject {
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
    var sounds: NSMutableArray = NSMutableArray();
    var pos: CGPoint = CGPoint();
    var endPos: CGPoint = CGPoint();
    var diameter: CGFloat = 400.0;
    var index: NSInteger = NSInteger();
    var isPlaying: Bool = false;
    var choiceNumber: NSInteger = 4;
    var isAnimated: Bool = false;
    
    override init() {
        super.init();
        
        // COUNT WITH VIEW CONTROLLER
        //self.index = 1;
    }
    
    func addSound(name: String, ext: String) {
        let sound = Sound();
        sound.initSound(name, ext: ext);
        self.sounds[sounds.count] = sound;
    }
    
    func setPos() {
        let listenerPos = appDelegate.playback?.listenerPos;
        var startPos = CGPoint();
        startPos.x = (listenerPos!.x - (diameter/2));
        startPos.y = listenerPos!.y;
        
        //COUNT WITH VIEWCONTROLLER
        let n = self.choiceNumber;
        let i = self.index.g;
        
        self.pos.x =  cos(((i * M_PI.g) / n.g) + (M_PI.g / (2.0 * n.g))) * -(diameter / 2.0);
        self.pos.y = sin(((i * M_PI.g) / n.g) + (M_PI.g / (2.0 * n.g)))  * -(diameter / 2.0);
        
//        print("Sound pos x : \(self.pos.x)");
//        print("Sound pos y : \(self.pos.y)");
        
        for var index = 0; index < self.sounds.count; index++ {
            (self.sounds[index]as! Sound).placeSound(self.pos.x, y: self.pos.y);
        }
//        self.fadeIn();
    }
    
    func goToEndPos(x:CGFloat, y:CGFloat, endY:CGFloat, a:CGFloat, b:CGFloat){
        let listenerPos = appDelegate.playback?.listenerPos;
        var newY = CGFloat();
        let delta = abs(self.pos.y - listenerPos!.y) / 100;
        if(y < endY) {
            newY = y + delta;
        } else {
            newY = y - delta;
        }
        let newX = (newY - b) / a;
        
//        print("lol: \(y)");
        for var index = 0; index < self.sounds.count; index++ {
            (self.sounds[index]as! Sound).placeSound(newX, y: newY);
        }
        
        delay(0.1) {
            
            if(abs(newY) > abs(endY) + 0.1 || abs(newY) < abs(endY) - 0.1) {
                self.goToEndPos(newX, y: newY, endY: endY, a:a, b:b);
            } else {
                self.animate();
            }
        }
    }
    
    func animate() {
        if (!self.isAnimated) {
            self.isAnimated = true;
            for var index = 0; index < self.sounds.count; index++ {
                (self.sounds[index]as! Sound).animate();
            }
        }
    }
    
    func stopAnimate() {
        if (self.isAnimated) {
            self.isAnimated = false;
            for var index = 0; index < self.sounds.count; index++ {
                (self.sounds[index]as! Sound).stopAnimate();
            }
        }
    }
    
    func fadeIn() {
        self.isPlaying = true;
        let listenerPos = appDelegate.playback?.listenerPos;
        let a = (self.pos.y - listenerPos!.y) / (self.pos.x - listenerPos!.x);
        let b = self.pos.y - (a * self.pos.x);
        
        let end = (self.pos.y - listenerPos!.y) / 2;
        
        self.goToEndPos(self.pos.x, y:self.pos.y, endY: end, a:a, b:b);
    }
    
    func fadeOut() {
        self.isPlaying = false;
        let listenerPos = appDelegate.playback?.listenerPos;
        let a = (self.pos.y - listenerPos!.y) / (self.pos.x - listenerPos!.x);
        let b = self.pos.y - (a * self.pos.x);
        
        let startY = (self.pos.y - listenerPos!.y) / 2;
        let startX = (startY - b) / a;
        
        self.goToEndPos(startX, y:startY, endY: self.pos.y, a:a, b:b);
    }
    
    func play(){
        for var index = 0; index < self.sounds.count; index++ {
            (self.sounds[index]as! Sound).play();
        }
        
    }
    
    func stop(){
        for var index = 0; index < self.sounds.count; index++ {
            (self.sounds[index]as! Sound).stop();
        }
    }
    
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    // MARK: - LocationManagerDelegate
    
  
}