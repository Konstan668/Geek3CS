//
//  GroupsTableViewCell.swift
//  VKAPP
//
//  Created by Konstantin on 01.09.2021.
//

import UIKit

class GroupsTableViewCell: UITableViewCell {
    
    static let identifier = "groupsTableViewCell"
    
    @IBOutlet weak var groupsLabel: UILabel!
    @IBOutlet weak var groupsImage: UIImageView!
    
    func cinfigure(group: Group) {
        groupsLabel.text = group.groupName
        groupsImage.image = UIImage(named: group.groupImage)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
