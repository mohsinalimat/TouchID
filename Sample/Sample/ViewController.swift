//
//  ViewController.swift
//  Sample
//
//  Created by Meniny on 2017-07-22.
//  Copyright © 2017年 Meniny. All rights reserved.
//

import UIKit
import TouchID

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tap Screen to Evaluate"
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        TouchID.evaluate(reason: "fot framework testing") { (success, error) in
            if success {
                print("Success")
            } else {
                print("Failed - \(error != nil ? error!.localizedDescription : "Error")")
            }
        }
    }


}

