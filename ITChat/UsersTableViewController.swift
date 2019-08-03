//
//  UsersTableViewController.swift
//  ITChat
//
//  Created by NeilPhung on 8/3/19.
//  Copyright © 2019 NeilPhung. All rights reserved.
//

import UIKit
import Firebase
import ProgressHUD

class UsersTableViewController: UITableViewController, UISearchResultsUpdating {

    

    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var filterSegmentedControll: UISegmentedControl!
    
    var allUsers: [FirebaseUser] = []
    var filteredUsers: [FirebaseUser] = []
    var allUsersGroupped = NSDictionary() as! [String: [FirebaseUser] ]
    var sectionTitleList: [String] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Users"
        navigationItem.largeTitleDisplayMode = .never
        
        // xoá các cell không có thông tin hiển thị
        tableView.tableFooterView = UIView()
        
        loadUsers(filter: kCITY)

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return allUsers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UserTableViewCell
        
        cell.geneateCellWith(fUser: allUsers[indexPath.row], indexPath: indexPath)
       

        return cell
    }
    //MARK: LoadUsers method
    func loadUsers(filter: String){
        ProgressHUD.show()
        var query: Query!
        // chỗ này con sai bởi vì khơi người dùng mới tạo tài khoản thì currenUser Không có nên query sẽ nil
        switch filter {
        case kCITY:
            query = reference(.User).whereField(kCITY, isEqualTo: FirebaseUser.currentUser()!.city).order(by: kFIRSTNAME, descending: false)
        case kCOUNTRY:
            query = reference(.User).whereField(kCOUNTRY, isEqualTo: FirebaseUser.currentUser()!.city).order(by: kFIRSTNAME, descending: false)
        default:
            query = reference(.User).order(by: kFIRSTNAME, descending: false)
        }
        
        query.getDocuments { (snapshot, error) in
//            self.allUsers = []
//            self.sectionTitleList = []
//            self.allUsersGroupped = [:]
            
            if error != nil {
                print(error!.localizedDescription)
                ProgressHUD.dismiss()
                self.tableView.reloadData()
                return
            }
            guard let snapshot = snapshot else {
                ProgressHUD.dismiss(); return
            }
            if !snapshot.isEmpty {
                for userDictionary in snapshot.documents {
                    let userDictionary = userDictionary.data() as NSDictionary
                    let fUser = FirebaseUser(_dictionary: userDictionary)
                    
                    if fUser.objectId != FirebaseUser.currentId(){
                        self.allUsers.append(fUser)
                    }
                }
                
                //split to groups
            }
            self.tableView.reloadData()
            ProgressHUD.dismiss()
            
            
        }
    }
    //MARK : IBActions

    @IBAction func filterSegmentValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            loadUsers(filter: kCITY)
        case 1:
            loadUsers(filter: kCOUNTRY)
        case 2:
            loadUsers(filter: "")
        default:
            return
        }
    }
    
    
    
    
    //MARK: Search Controller Methods
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredUsers = allUsers.filter({ (user) -> Bool in
            
            return user.firstname.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }

}
