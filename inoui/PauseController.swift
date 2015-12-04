//
//  PauseController.swift
//  inoui
//
//  Created by Chloé Henaut on 04/12/2015.
//  Copyright © 2015 Inoui. All rights reserved.
//

import UIKit
import AVFoundation

class PauseController: UIViewController {
    @IBOutlet var button: UIButton!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let sessionInstance = AVAudioSession.sharedInstance();
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "handleRouteChange:",
            name: AVAudioSessionRouteChangeNotification,
            object: sessionInstance)
        
        let currentRoute = AVAudioSession.sharedInstance().currentRoute;
        
        for description in currentRoute.outputs {
            if description.portType == AVAudioSessionPortHeadphones {
                print("headphone plugged in")
                button.enabled = true;
            } else {
                print("headphone pulled out")
                button.enabled = false;
            }
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBackToExp () {
        
    }
    
    func handleRouteChange(notification: NSNotification) {
        let currentRoute = AVAudioSession.sharedInstance().currentRoute;
        
        for description in currentRoute.outputs {
            if description.portType == AVAudioSessionPortHeadphones {
                print("headphone plugged in")
                button.enabled = true;
            } else {
                print("headphone pulled out")
                button.enabled = false;
            }
        }
    }
    
}

