//
//  User.swift
//  OtelApp
//
//  Created by sunil v g  on 15/06/17.
//  Copyright © 2017 Qvertz Technologies. All rights reserved.
//

import Foundation

struct Struct_User {
    var name : String?
    var email : String?
    var password : String?
    
    
    init(){
        
    }
    init(user : Struct_User)
    {
        self.name = user.name
        self.email = user.email
        self.password = user.password
    }
    
}


class User: NSObject {
    
}
