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
        
        print("PauseController");
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let sessionInstance = AVAudioSession.sharedInstance();
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "handleRouteChange:",
            name: AVAudioSessionRouteChangeNotification,
            object: sessionInstance)
        
        self.handleRouteChange(nil);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBackToExp () {
        // TODO add a callback to trigger to the parent view to replay
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    func handleRouteChange(notification: NSNotification?) {
        let currentRoute = AVAudioSession.sharedInstance().currentRoute;
        
        for description in currentRoute.outputs {
            if description.portType == AVAudioSessionPortHeadphones {
                button.enabled = true;
            } else {
                button.enabled = false;
            }
        }
    }
    
}

