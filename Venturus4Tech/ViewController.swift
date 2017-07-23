//
//  ViewController.swift
//  Venturus4Tech
//
//  Created by Gustavo Reder Cazangi on 21/07/17.
//  Copyright © 2017 Venturus. All rights reserved.
//

import UIKit
import SocketIO

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var socket : SocketIOClient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onButtonClick(_ sender: Any) {
        socket = SocketIOClient(socketURL: URL(string: "http://192.168.2.117:3000")!, config: [])
        
        socket?.on(clientEvent: .connect) {data, ack in
            self.openChat()
        }
        
        socket?.connect()
    }
    
    func openChat() {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "chat") as! ChatController
        vc.userNick = textField.text
        vc.socket = socket
        self.present(vc, animated: true, completion: nil)
    }

}

