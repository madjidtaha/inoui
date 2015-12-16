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

@objc protocol LocationManagerDelegate {
    optional func onLocationChange(angle: CGFloat)
    optional  func onChoiceChange(choice: Int);
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    private var _locationManager: CLLocationManager!;
    private var _choiceNumber: Int = 0;
    private var _sections: CGFloat = 0;
    var choiceNumber: NSInteger? {
        get {
            return self._choiceNumber;
        }
        set {
            self._choiceNumber = newValue!;
            self._sections = M_PI.g / self._choiceNumber.g;
        }
    };

    
    
    var tilt: Bool = false;
    var startPos: CGFloat = 0.0;
    var choice: AnyObject = 0;
    var choices: NSMutableArray = [];
    var radians: CGFloat = 0.0;
    var delegate: LocationManagerDelegate?;
    
    override init() {
        super.init();
        
        _locationManager = CLLocationManager();
        _locationManager.delegate = self;
        _locationManager.startUpdatingHeading();
    }
    
    func toggleGyro() {
        tilt = !tilt;
        self.startPos = 0.0;
    }
    
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        if tilt {
            print("heading : \(newHeading)");
            self.radians = CGFloat(newHeading.magneticHeading) * CGFloat(M_PI) / 180.0;
            if (self.startPos == 0.0) {
                self.startPos = self.radians;
            }
            self.radians = ((self.radians - self.startPos) % (M_PI.g * 2));
            if (self.radians < 0) {
                self.radians =  M_PI.g * 2 + self.radians;
            }
            self.onLocationChange(self.radians);
            self.onChoiceChange(self.radians);
        }
    }
    
    // MARK: - LocationManagerDelegate 
    
    func onLocationChange(angle: CGFloat) {
//        print("location, changed ! \(angle)");
        self.delegate?.onLocationChange?(angle);
    }

    func onChoiceChange(angle: CGFloat) {
        if choiceNumber != nil || choiceNumber != 0 {
            for var i = 0; i < self.choiceNumber; i++ {
                if (angle % M_PI.g < i.g * self._sections) {
                    self.delegate?.onChoiceChange?(i);
                    break;
                }
            }
        }
        
        
    }
    
}


