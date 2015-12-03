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

class LocationManager: NSObject, CLLocationManagerDelegate {
    private var locationManager: CLLocationManager!;
    var tilt: Bool = false;
    var startPos: CGFloat = 0.0;
    
    override init() {
        super.init();
        
        locationManager = CLLocationManager();
        locationManager.delegate = self;
        locationManager.startUpdatingHeading();
    }
    
    func toggleGyro() {
        tilt = !tilt;
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        if tilt {
            var radians = CGFloat(newHeading.magneticHeading) * CGFloat(M_PI) / 180.0;
            if (self.startPos == 0.0) {
                self.startPos = radians;
            }
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
            radians = -((radians - self.startPos) % (M_PI.g * 2));
            appDelegate.playback?.listenerRotation = radians;
            //            print("orientation \(radians)");
        }
    }

}


