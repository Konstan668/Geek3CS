//
//  MySession.swift
//  VKAPP
//
//  Created by Konstantin on 31.03.2022.
//

import UIKit

 class MySession {

     static let instance = MySession()

     private init() {}

     var token: String = ""
     var userId: Int = 0
 }
