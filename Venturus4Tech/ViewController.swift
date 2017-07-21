//
//  ViewController.swift
//  Venturus4Tech
//
//  Created by Gustavo Reder Cazangi on 21/07/17.
//  Copyright © 2017 Venturus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    var clicks = 0
    
    let maximo = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        label.text = "\(clicks)"
        label.textColor = UIColor.green
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onButtonClick(_ sender: Any) {
        clicks = clicks + 1
        if (clicks % 4 != 0) {
            label.textColor = UIColor.green
            label.text = "\(clicks)"
        } else {
            label.textColor = UIColor.red
            label.text = "PIM"
        }
        if (clicks == maximo) {
            clicks = 0
        }
        
    }

}

