//
//  SwipeTableViewCellController.swift
//  ToDoListAppWithRealm
//
//  Created by DeEp KapaDia on 13/07/19.
//  Copyright © 2019 DeEp KapaDia. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewCellController: UITableViewController,SwipeTableViewCellDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
        
        cell.delegate = self
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
         
            self.updateModel(at: indexPath)
            
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "trash-circle")
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
   
    func updateModel(at indexPath: IndexPath){
        
        print("Data Deleted Sucessfully")
        
    }
    
}

