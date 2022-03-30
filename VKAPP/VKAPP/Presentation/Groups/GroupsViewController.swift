//
//  GroupsViewController.swift
//  VKAPP
//
//  Created by Konstantin on 25.08.2021.
//

import UIKit

class GroupsViewController: UIViewController {
    
    var userGroups = [Group]()
    
    @IBOutlet weak var groupsTableView: UITableView!
    
    @IBAction func exitButtonPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupsTableView.delegate = self
        groupsTableView.dataSource = self
        
    }
    
    @IBAction func findGroups( segue: UIStoryboardSegue) {
        if segue.identifier == "findGroups" {
            guard let findGruopViewController = segue.source as? FindGroupViewController else { return }
            if let indexPath = findGruopViewController.findGroupTableView.indexPathForSelectedRow {
                let group = findGruopViewController.groups.groups[indexPath.row]
                if !userGroups.contains(group) {
                    userGroups.append(group)
                    groupsTableView.reloadData()
                }
            }
        }
    }
}

extension GroupsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = groupsTableView.dequeueReusableCell(withIdentifier: GroupsTableViewCell.identifier) as! GroupsTableViewCell
        cell.cinfigure(group: userGroups[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            userGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
}
