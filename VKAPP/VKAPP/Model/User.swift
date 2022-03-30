//
//  User.swift
//  VKAPP
//
//  Created by Konstantin on 31.08.2021.
//

import Foundation

struct User: Equatable {
    var userName: String
    var userImageName: String
    var userPhothosName: [String]
    var index: String
    

    init(userName: String, userImageName: String, userPhotossName: [String]) {
        self.userName = userName
        self.userImageName = userImageName
        self.userPhothosName = userPhotossName
        self.index = String(userName.prefix(1))
    }
}

