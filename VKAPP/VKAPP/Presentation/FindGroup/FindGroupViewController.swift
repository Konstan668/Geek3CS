//
//  FindGroupViewController.swift
//  VKAPP
//
//  Created by Konstantin on 25.08.2021.
//

import UIKit

class FindGroupViewController: UIViewController {
    
    let groups: UserAndGroupsStorage = UserAndGroupsStorage()
    @IBOutlet weak var findGroupTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findGroupTableView.delegate = self
        findGroupTableView.dataSource = self
        
        
    }
    
    
}

extension FindGroupViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups.groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FindGroupTableViewCell.identifier) as! FindGroupTableViewCell
        cell.configure(group: groups.groups[indexPath.row])
        cell.addSubview(cell.addImageButton())
        return cell
    }
    
    
}
