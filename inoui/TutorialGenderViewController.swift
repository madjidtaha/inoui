//
//  TutorialGenderViewController.swift
//  inoui
//
//  Created by Madjid Taha on 05/01/2016.
//  Copyright © 2016 Inoui. All rights reserved.
//

import UIKit

class TutorialGenderViewController: TutorialViewController {
 
    @IBOutlet weak var instructionView: UITextView!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var womanBlurView: UIImageView!
    @IBOutlet weak var manBlurView: UIImageView!
    
    @IBOutlet weak var womanView: UIImageView!
    @IBOutlet weak var manView: UIImageView!
    
    
    var questionVisible = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.locationManager = LocationManager();
        self.locationManager?.delegate = self;
        self.locationManager?.choiceNumber = 2;
        
        let gender = NSMutableArray();
        for var index = 0; index < 2; index++ {
            gender[index] = index;
        }
        self.locationManager?.choices.removeAllObjects();
        self.locationManager?.choices.addObjectsFromArray(gender as [AnyObject]);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    override func onButtonDown(sender: AnyObject) {

        // super.onButtonDown(sender);
        
        self.locationManager?.toggleGyro();
        
        self.playback?.playSound("SOUND");
   
        if !questionVisible {
            
            var i : Double = 0;
            
            self.questionView.alpha = 1;
            
            for view in self.questionView.subviews {
                
                view.frame.origin.y -= 5;
                view.alpha = 0;

                UIView.animateWithDuration(0.5, delay: i * 0.2, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    view.alpha = 1;
                    view.frame.origin.y += 5;
                    }, completion: nil);
                
                i++;
                
            }
            
            UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    self.instructionView.alpha = 0;
                    self.instructionView.frame.origin.y += 5;
                    }, completion: nil);
                
            }
            
            questionVisible = true;
        
    }
    
    // MARK - LocationManagerDelegate
    
    func onLocationChange(newAngle: CGFloat) {
        
//        print("onLocationChange \(__FUNCTION__)");
        
//        angle = newAngle;
//        
//        self.setNeedsDisplay();
    }
    
    
    override func onChoiceChange(choice: Int) {
        
        print("AAAAA \(choice)");
        
    }
    
}
