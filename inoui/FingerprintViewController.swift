//
//  FingerprintViewController.swift
//  inoui
//
//  Created by Madjid Taha on 02/12/2015.
//  Copyright © 2015 Inoui. All rights reserved.
//

import UIKit

protocol FingerprintViewControllerDelegate {
    func onButtonTouch(sender: AnyObject)
}

class FingerprintViewController: UIViewController {

    @IBOutlet weak var fingerprintButton: UIButton!
    var delegate : FingerprintViewControllerDelegate?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        print("Fingerprint ViewController");
        // Do any additional setup after loading the view.
    }
    
    override func didMoveToParentViewController(parent: UIViewController?) {
        print(self.parentViewController);
        
        if let sourceViewController = (self.parentViewController as? FingerprintViewControllerDelegate) {
            self.delegate = sourceViewController;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onButtonTouch(sender: AnyObject) {
        self.delegate?.onButtonTouch(sender);
        print("WOUHOU FINGERPRINT");
        
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
