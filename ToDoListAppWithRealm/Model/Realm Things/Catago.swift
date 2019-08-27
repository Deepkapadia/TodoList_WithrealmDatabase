//
//  Catago.swift
//  ToDoListAppWithRealm
//
//  Created by DeEp KapaDia on 13/07/19.
//  Copyright © 2019 DeEp KapaDia. All rights reserved.
//

import Foundation
import RealmSwift

class Catagories: Object {
    
    @objc dynamic var name : String = ""
    @objc dynamic var  color: String = ""
    let item = List<Item>()
    
}

