//
//  ViewController.swift
//  asd
//
//  Created by Chris on 5/17/16.
//  Copyright © 2016 Prince Fungus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myView: UIView!
    
    var origFrame = CGRect.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.origFrame = myView.frame
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func tap(sender: AnyObject) {
//        UIView.animateWithDuration(2.0) {
            self.myView.transform = CGAffineTransformMakeScale(1.0, 0.5)
            
            self.myView.frame.origin = self.origFrame.origin
            
        //}
    }
    
}

