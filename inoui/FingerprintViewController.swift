//
//  FingerprintViewController.swift
//  inoui
//
//  Created by Madjid Taha on 02/12/2015.
//  Copyright © 2015 Inoui. All rights reserved.
//

import UIKit

protocol FingerprintViewControllerDelegate {
    func onButtonUp(sender: AnyObject)
    func onButtonDown(sender: AnyObject)
}

class FingerprintViewController: UIViewController {

    @IBOutlet weak var fingerprintButton: UIButton!
    var delegate : FingerprintViewControllerDelegate?;
    var lastTouch : Double = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated);
    }
    
    override func didMoveToParentViewController(parent: UIViewController?) {
//        print(self.parentViewController);
        
        if let sourceViewController = (self.parentViewController as? FingerprintViewControllerDelegate) {
            self.delegate = sourceViewController;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onButtonDown(sender: AnyObject) {
        self.delegate?.onButtonDown(sender);
//        print("WOUHOU FINGERPRINT ");
        // TODO, cancel buttonup if touch too fast
        self.lastTouch = NSDate().timeIntervalSince1970;
        
    }
    
    @IBAction func onButtonUp(sender: AnyObject) {
        self.delegate?.onButtonUp(sender);
        print("Fingerprint down. \((NSDate().timeIntervalSince1970) - self.lastTouch)");
       
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
