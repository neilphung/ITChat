//
//  ChatsViewController.swift
//  ITChat
//
//  Created by NeilPhung on 8/3/19.
//  Copyright © 2019 NeilPhung. All rights reserved.
//

import UIKit

class ChatsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       navigationController?.navigationBar.prefersLargeTitles = true
    }
    

    //MARK: IBAction
    
    
    @IBAction func createNewChatButtonPressed(_ sender: Any) {
        let usersTableView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "usersTableView") as! UsersTableViewController
        
       self.navigationController?.pushViewController(usersTableView, animated: true)
    }
    
}
