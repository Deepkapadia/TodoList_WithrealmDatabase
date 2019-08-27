//
//  ItemsRealm.swift
//  ToDoListAppWithRealm
//
//  Created by DeEp KapaDia on 13/07/19.
//  Copyright © 2019 DeEp KapaDia. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCatagories = LinkingObjects(fromType: Catagories.self , property:"item")
    
}
