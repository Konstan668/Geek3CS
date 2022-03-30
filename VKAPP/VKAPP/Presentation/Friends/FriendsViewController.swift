//
//  FriendsViewController.swift
//  VKAPP
//
//  Created by Konstantin on 26.08.2021.
//

import UIKit


final class FriendsViewController: UIViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    let userStorage: UserAndGroupsStorage = UserAndGroupsStorage()
    var usersArray: [User] = [User]()
    var indexArray:[String] = [String]()
    var usersDictionary =  [String: [User]]()
    
    private var filteredIndexArray:[String] = [String]()
    private var filteredUsersArray = [User]()
    private var filteredUsersDictionary = [String: [User]]()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        
        return text.isEmpty
    }
    
    
    
    
    
    @IBAction func exitButtonPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.dismiss(animated: true)
    }
    
    @IBOutlet weak var FriendsTableView: UITableView!
    
    override func loadView() {
        super.loadView()
        
        sortUsers(userStorageInFunc: userStorage)
        makeIndexArray(userArray: usersArray)
        addKeys(indexArray: indexArray)
        addUserByKeys(usersArrayInFunc: usersArray)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FriendsTableView.delegate = self
        FriendsTableView.dataSource = self
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.sizeToFit()
        
        self.FriendsTableView.tableHeaderView = searchController.searchBar
        
    }
    
    
    
    func sortUsers(userStorageInFunc: UserAndGroupsStorage) {
        usersArray = userStorageInFunc.users
        usersArray.sort{$0.userName < $1.userName}
    }
    
    func makeIndexArray(userArray: [User]) {
        for user in usersArray {
            if !indexArray.contains(user.index){
                indexArray.append(user.index)
            }
        }
    }
    
    func addKeys(indexArray: [String]) {
        let emptyUserArray = [User]()
        for index in indexArray {
            usersDictionary.updateValue(emptyUserArray, forKey: index)
        }
    }
    
    func addUserByKeys(usersArrayInFunc: [User]) {
        for user in usersArrayInFunc {
            usersDictionary[user.index]?.append(user)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if searchBarIsEmpty {
            
            return indexArray.count
        } else {
            return filteredIndexArray.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return indexArray[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchBarIsEmpty {
            let x = usersDictionary[indexArray[indexPath.section]]
            let x2 = x![indexPath.row]
            performSegue(withIdentifier: "photosSegue", sender:x2)
        } else {
            let x = filteredUsersDictionary[filteredIndexArray[indexPath.section]]
            let x2 = x![indexPath.row]
            performSegue(withIdentifier: "photosSegue", sender:x2)
        }
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if searchBarIsEmpty {
            return indexArray
        } else {
            return filteredIndexArray
        }
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard segue.identifier == "photosSegue" else { return }
//        guard let destination = segue.destination as? NewPhotoViewController else { return }
//        let row = sender as! User
//        destination.users = row
//
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "photosSegue" else { return }
       // guard let destination = segue.destination as? NewPhotoViewController else { return }
        guard let destination = segue.destination as? ViewControllerLesson8 else {return}
        let row = sender as! User
        destination.users = row
    }
    
    
       
    
}



extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBarIsEmpty {
            return usersDictionary[indexArray[section]]!.count
        } else {
            return filteredUsersDictionary[filteredIndexArray [section]]!.count
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  FriendsTableViewCell.identifier) as! FriendsTableViewCell
        if searchBarIsEmpty {
            let x = usersDictionary[indexArray[indexPath.section]]
            let x2 = x![indexPath.row]
            cell.configure(user: x2)
            return cell
        } else {
            let x = filteredUsersDictionary[filteredIndexArray[indexPath.section]]
            let x2 = x![indexPath.row]
            cell.configure(user: x2)
            return cell
        }
    }
    
}

extension FriendsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {

        filteredIndexArray = []
        filteredUsersArray = []
        filteredUsersDictionary = [:]
        
        filterContentForSearchText(searchController.searchBar.text!)


        
        
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredUsersArray = {
            for userD in usersDictionary {
                let user = userD.value
                for userA in user {
                    if userA.userName.contains(searchText) {
                        if !filteredUsersArray.contains(userA) {
                            filteredUsersArray.append(userA)
                        }
                    }
                }
            }
            
            return filteredUsersArray
        } ()
        
        filteredUsersArray = {
            filteredUsersArray.sort{$0.userName < $1.userName}
            return filteredUsersArray
            
        } ()
        
        
        filteredIndexArray = {
            for user in filteredUsersArray {
                if !filteredIndexArray.contains(user.index){
                    filteredIndexArray.append(user.index)
                }
            }
            return filteredIndexArray
        }()
        
        filteredUsersDictionary = {
            let emptyUserArray = [User]()
            for index in filteredIndexArray {
                filteredUsersDictionary.updateValue(emptyUserArray, forKey: index)
            }
            return filteredUsersDictionary
        } ()
        
        filteredUsersDictionary = {
            for user in filteredUsersArray {
                filteredUsersDictionary[user.index]?.append(user)
            }
            return filteredUsersDictionary
        } ()
        
        FriendsTableView.reloadData()
        
    }
    
}



