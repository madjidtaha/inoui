//
//  TutorialAgeViewController.swift
//  inoui
//
//  Created by Madjid Taha on 06/01/2016.
//  Copyright © 2016 Inoui. All rights reserved.
//

import UIKit
import AVFoundation

class TutorialAgeViewController: TutorialViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var labelView: UILabel!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("ageview");
        
        let subviews : [UIView] = [self.labelView, self.textView, self.ageView!]

        
        for view in subviews {
            
            view.frame.origin.y -= 5;
            view.alpha = 0;
           
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        var i : Double = 3;
        
        let subviews : [UIView] = [self.labelView, self.textView, self.ageView!]
        for view in subviews {
        
            UIView.animateWithDuration(0.5, delay: i * 0.2, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                view.alpha = 1;
                view.frame.origin.y += 5;
                }, completion: nil);
        
            i++;
        
        }
    }
}
