//
//  TutorialViewController.swift
//  inoui
//
//  Created by Madjid Taha on 01/12/2015.
//  Copyright © 2015 Inoui. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController, FingerprintViewControllerDelegate {

    @IBOutlet weak var fingerprintView: UIView!
    var nextStep : String?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view.
        // (fingerprintView. as! FingerprintViewController).delegate = self;
        // NSUserDefaults.standardUserDefaults().setObject(true, forKey: "beginTutorial");

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("ReceiveMemoryWarning");

    }

    func onButtonTouch(sender: AnyObject) {
        print("FingerPrint from parent");
        print(self.nextStep);
        if self.nextStep != nil {
            let destStoryboard = UIStoryboard(name: "Tutorial", bundle: nil);
            let vc = destStoryboard.instantiateViewControllerWithIdentifier("tutorialStep"+self.nextStep!);
            self.presentViewController(vc, animated: true, completion: { () -> Void in
                // callback here
            })
     
        }
        
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
