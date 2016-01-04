//
//  Sound.swift
//  inoui
//
//  Created by Chloé Henaut on 04/01/2016.
//  Copyright © 2016 Inoui. All rights reserved.
//

import UIKit
import AVFoundation

class SoundsComposition: NSObject, LocationManagerDelegate {
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
    var sounds: NSMutableArray = NSMutableArray();
    var pos: CGPoint = CGPoint();
    var endPos: CGPoint = CGPoint();
    var diameter: CGFloat = 20.0;
    var index: NSInteger = NSInteger();
    
    override init() {
        super.init();
        
        // COUNT WITH VIEW CONTROLLER
        self.index = 0;
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
        let n = 3;
        let i = self.index.g;
        
        self.pos.x =  cos(((i * M_PI.g) / n.g) + (M_PI.g / (2.0 * n.g))) * -(diameter / 2.0);
        self.pos.y = sin(((i * M_PI.g) / n.g) + (M_PI.g / (2.0 * n.g)))  * -(diameter / 2.0);
        
        print("Sound pos x : \(self.pos.x)");
        print("Sound pos y : \(self.pos.y)");
        
        for var index = 0; index < self.sounds.count; index++ {
            (self.sounds[index]as! Sound).placeSound(self.pos.x, y: self.pos.y);
        }
        
        //self.goToEndPos(self.pos.x, y: self.pos.y);
    }
    
    func goToEndPos(x:CGFloat, y:CGFloat){
        let newX = x + M_PI.g / 10;
        let newY = y + M_PI.g / 10;
        let point = CGPointMake(newX, newY);
        delay(0.05) {
            print("lol: \(x)");
            for var index = 0; index < self.sounds.count; index++ {
                (self.sounds[index]as! Sound).placeSound(newX, y: newY);
            }
            if(point != self.endPos) {
                self.goToEndPos(newX, y: newY);
            }
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
    
    func onChoiceChange(choice: Int) {
        print("test");
        
        self.goToEndPos(self.pos.x, y:self.pos.y);
    }
    
}