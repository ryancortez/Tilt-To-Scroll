//
//  ViewController.swift
//  Tilt-To-Scroll
//
//  Created by Ryan Cortez on 7/14/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var coreMotionManger: CMMotionManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coreMotionManger = CMMotionManager()
        coreMotionManger.deviceMotionUpdateInterval = 0.1
        coreMotionManger.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue()) { (data: CMDeviceMotion?, error: NSError?) in
            
            if let data = data {
                print(self.textView.contentOffset)
                print(data.gravity.y)
    
                let acceleration:CGFloat = 30
                let scrollViewHeight = self.textView.contentSize.height - self.textView.contentSize.height / 2.5
                let upperBound = -0.73
                let lowerBound = -0.93
                
                // Scroll Up if higher than -0.73
                if (data.gravity.y > upperBound) {
                    var y = CGFloat(self.textView.contentOffset.y - acceleration)
                    if (y < 0) {
                        y = 0
                    }
                    self.textView.setContentOffset(CGPointMake(0, y), animated: true)
                }
                
                // Scroll Down if lower than -0.97
                else if (data.gravity.y < lowerBound) {
                    var y = CGFloat(self.textView.contentOffset.y + acceleration)
                    if (y > scrollViewHeight) {
                        y = scrollViewHeight
                    }
                    self.textView.setContentOffset(CGPointMake(0, y), animated: true)
                }
                
                
                
            }
        }
    }
    

}

