//
//  ViewController.swift
//  ToDoListAppCoreData
//
//  Created by DeEp KapaDia on 12/07/19.
//  Copyright © 2019 DeEp KapaDia. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class TableViewController: SwipeTableViewCellController{

    //Catagory Array with Database name with array.
    
    @IBOutlet weak var SearchBar: UISearchBar!
    
    
    let realm = try! Realm()
    
    var itemArray: Results<Item>?

    var selectedCatagory : Catagories? {
        didSet{
            LoadItems()
        }
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.rowHeight = 80.0
        tableView.separatorStyle = .none
        

    }

    override func viewWillAppear(_ animated: Bool) {
        
        title = selectedCatagory?.name
        
        guard let colorHex = selectedCatagory?.color else {fatalError()}
        
        UpdateNavBar(withHexCode: colorHex)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
       UpdateNavBar(withHexCode: "1D9BF6")
        
    }
    
    //MARK: - Nav Bar Methods *****
    
    func UpdateNavBar(withHexCode colorHexCode:String){
        
        guard let navBar = navigationController?.navigationBar else {fatalError("Navigation Bar Does't Exist.")}
        
        guard let navBarColor = UIColor(hexString: colorHexCode) else{fatalError()}
        
        navBar.barTintColor = navBarColor
        navBar.tintColor = ContrastColorOf(navBarColor, returnFlat: true)
        SearchBar.barTintColor = navBarColor
        navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: ContrastColorOf(navBarColor, returnFlat: true)]
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = itemArray?[indexPath.row] {
        
        cell.textLabel?.text = item.title
        
            if let color = UIColor(hexString: selectedCatagory!.color)?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(itemArray!.count)){
                
                cell.backgroundColor = color
                
                cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
                
            }
            
            
            
            
        //ternery condition sample
        cell.accessoryType = item.done ? .checkmark : .none

        }else{
            cell.textLabel?.text = "No items are here.!"
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = itemArray?[indexPath.row]{
            do{
                try self.realm.write {
                item.done = !item.done
                }
            }catch{
                print("Errorrorororooroor\(error)")
            }
        }

        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //Mark - Add New Item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Today Items", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in

            if let currenCatagory = self.selectedCatagory{
                do{
                try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.dateCreated = Date()
                    currenCatagory.item.append(newItem)
                }
                }catch{
                    print("Errorrorororooroor\(error)")
                }
            }
            self.tableView.reloadData()
        }
        
        //Create TextField on Allert Box.
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item."
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    

    
    //Mark: Load Items
    
    func LoadItems() {

       itemArray = selectedCatagory?.item.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()

    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let item = itemArray?[indexPath.row]{
            do{
                try realm.write {
                    realm.delete(item)
                }
            }catch{
                print("Errorrorororroro\(error)")
            }
        }
        print("Data Deleted Successfully")
        
    }
    
}

//*** Split Functionalities of a single view controllers code ***
extension TableViewController: UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        itemArray = itemArray?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
        
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            LoadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }

}
