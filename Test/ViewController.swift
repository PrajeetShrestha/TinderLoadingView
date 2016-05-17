//
//  ViewController.swift
//  Test
//
//  Created by Prajeet Shrestha on 5/17/16.
//  Copyright © 2016 com.javra.test. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var l: TinderLoadingView!
    override func viewDidLoad() {
        super.viewDidLoad()
        l.start()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

