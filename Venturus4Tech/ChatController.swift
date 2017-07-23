//
//  ChatController.swift
//  Venturus4Tech
//
//  Created by Gustavo Reder Cazangi on 21/07/17.
//  Copyright © 2017 Venturus. All rights reserved.
//

import UIKit
import SocketIO

class ChatController : UIViewController, UITableViewDataSource {
    
    var userNick : String?;
    
    var socket : SocketIOClient?
    
    @IBOutlet weak var inputTextField: UITextField!
    
    var msgs : [[String: Any]] = [];
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        //Remove os separadores de celulas vazias...
        tableView.tableFooterView = UIView()
        getRequest()
        registerSocketEvents()
    }
    
    func registerSocketEvents() {
        socket?.on("messages") {data, ack in
            if let aMsg = data as? [[String: Any]]  {
                for i in 0..<aMsg.count {
                    self.msgs.append(aMsg[i])
                    self.updateTableView()
                }
            }
        }
    }
    
    func updateTableView() {
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: self.msgs.count-1, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
    
    @IBAction func onSendClick(_ sender: Any) {
        var json : [String : Any] = [:];
        json["author"] = userNick
        json["message"] = inputTextField.text
        socket?.emit("messages", json)
    }
    
    func getRequest() {
        let url = URL(string: "http://date.jsontest.com")
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            let json = try? JSONSerialization.jsonObject(with: data!, options: [])
            if let aMsg = json as? [String: Any]  {
              print("\(aMsg["time"]!)")
            }
        }
        
        task.resume()
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return msgs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "celula_chat", for: indexPath) as! ChatCell
        
        let pos = indexPath.row
        let msg = msgs[pos]
        let msgText = msg["message"] as? String
        
        cell.message.text = msgText
        cell.username.text = msg["author"] as? String
        cell.dateLabel.text = "\(msg["sent"] as! String)"
        cell.userInitial.text = "\(msgText!.characters.first!)"
        
        return cell
    }
 
    
}
