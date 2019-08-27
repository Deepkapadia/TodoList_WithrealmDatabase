//
//  CatagoryViewController.swift
//  ToDoListAppCoreData
//
//  Created by DeEp KapaDia on 13/07/19.
//  Copyright © 2019 DeEp KapaDia. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CatagoryViewController: SwipeTableViewCellController{

    let realm = try! Realm()
    
    //Catagory Array with Database name with array.
    var catagoryArray: Results<Catagories>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       LoadCatagories()
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return catagoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView,cellForRowAt: indexPath)
        
        if let Catagoriess = catagoryArray?[indexPath.row]{
            
            cell.textLabel?.text = Catagoriess.name
            
            cell.backgroundColor = UIColor(hexString: Catagoriess.color)
            guard let catagoryColor = UIColor(hexString: Catagoriess.color) else { fatalError()}
            
            cell.backgroundColor = catagoryColor
            
            cell.textLabel?.textColor = ContrastColorOf(catagoryColor, returnFlat: true)
            
        }
        return cell
    }
    
    
    //Mark DidSelectMethod.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "GoToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TableViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCatagory = catagoryArray?[indexPath.row]
        }
    }
    
    //MARK: - Add New Catagory Button.
    @IBAction func AddCatagoryButton(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new ToDoey Catagory", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Catagory", style: .default) { (action) in
            
            //What will happen once user clicks the add button.
            let newCat = Catagories()
            newCat.name = textField.text!
            newCat.color = UIColor.randomFlat.hexValue()
            
            self.save(catagories: newCat)
        }
        
        //Create TextField on Allert Box.
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Catagory."
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - Save to database code.
    func save(catagories : Catagories){
        //*** core data With database creation. ***
        do{
            try realm.write {
                realm.add(catagories)
            }
        }catch{
            print("Errororororor \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    //Mark: Load from Database to display on anywhere.
    
    func LoadCatagories() {
        
        catagoryArray = realm.objects(Catagories.self)
        
        tableView.reloadData()
    }
    
    //<ARK: - DELETE DATA FROM SWIPE
    
    override func updateModel(at indexPath: IndexPath) {
        
        super.updateModel(at: indexPath)
        
        if let catagoryForDeletion = self.catagoryArray?[indexPath.row]{
            do{
                try self.realm.write {
                    self.realm.delete(catagoryForDeletion)
                }
            }catch{
                print("Errororororor\(error)")
            }
        }
        
        
    }
   
}

