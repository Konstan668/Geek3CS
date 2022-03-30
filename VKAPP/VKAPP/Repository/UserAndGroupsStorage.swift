//
//  UserAndGroupsStorage.swift
//  VKAPP
//
//  Created by Konstantin on 31.08.2021.
//

import Foundation

class UserAndGroupsStorage {
    var users: [User]
    var groups: [Group]
    
    init() {
        self.users = [
            User(userName: "Sergey", userImageName: "SergeyLogo", userPhotossName: ["Serg2","Serg3"]),
            User(userName: "Andrey", userImageName: "AndreyLogo", userPhotossName: ["Andr1", "Andr2", "Andr3","Andr1", "Andr2", "Andr3","Andr1", "Andr2", "Andr3"]),
            User(userName: "CAndrey", userImageName: "", userPhotossName: [""]),
            User(userName: "SAndrey", userImageName: "", userPhotossName: [""]),
            User(userName: "JAndrey", userImageName: "", userPhotossName: [""]),
            User(userName: "OAndrey", userImageName: "", userPhotossName: [""]),
            User(userName: "LAndrey", userImageName: "", userPhotossName: [""]),
            User(userName: "ZAndrey", userImageName: "", userPhotossName: [""]),
            User(userName: "XAndrey", userImageName: "", userPhotossName: [""]),
            User(userName: "QAndrey", userImageName: "", userPhotossName: [""])]
    
     
    
            
        
        
        
        self.groups = [Group(groupName: "MDK", groupImage: "MDKLogo"),
                       Group(groupName: "Leprum", groupImage: "LeprumLogo")]
    }

}
