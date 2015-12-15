//
//  LocationManager.swift
//  inoui
//
//  Created by Chloé Henaut on 03/12/2015.
//  Copyright © 2015 Inoui. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

protocol LocationManagerDelegate {
    func onLocationChange(angle: CGFloat)
}


class LocationManager: NSObject, CLLocationManagerDelegate {
    private var locationManager: CLLocationManager!;
    var tilt: Bool = false;
    var startPos: CGFloat = 0.0;
    var choice: AnyObject = 0;
    var choices: NSMutableArray = [];
    var choiceNumber: NSInteger = 30;
    var radians: CGFloat = 0.0;
//    var label: UITextView = UITextView();
    var delegate: LocationManagerDelegate?;
    
    override init() {
        super.init();
        
        locationManager = CLLocationManager();
        locationManager.delegate = self;
        locationManager.startUpdatingHeading();
    }
    
    func toggleGyro() {
        tilt = !tilt;
        self.startPos = 0.0;
    }
    
    func makeChoices(angle: CGFloat) {
        self.choiceNumber = self.choices.count;
        let sections = M_PI.g / self.choiceNumber.g;
        
        for var index = 1; index < self.choiceNumber + 2; index++ {
            if (angle % M_PI.g < index.g * sections) {
                // print(self.radians);
                print(self.choices[index - 1]);
                self.choice = self.choices[index - 1];
//                self.label.text = (self.choice.stringValue)! as String;
                break;
            }
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        if tilt {
            self.radians = CGFloat(newHeading.magneticHeading) * CGFloat(M_PI) / 180.0;
            if (self.startPos == 0.0) {
                self.startPos = self.radians;
            }
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
            self.radians = ((self.radians - self.startPos) % (M_PI.g * 2));
            if (self.radians < 0) {
                self.radians =  M_PI.g * 2 + self.radians;
            }
            appDelegate.playback?.listenerRotation = -self.radians;
//                        print("orientation \(radians)");
            self.onLocationChange(self.radians);
            self.makeChoices(self.radians);
        }
    }
    
    // MARK: - LocationManagerDelegate 
    
    func onLocationChange(angle: CGFloat) {
        print("location, changed ! \(angle)");
        self.delegate?.onLocationChange(angle);
    }

}


