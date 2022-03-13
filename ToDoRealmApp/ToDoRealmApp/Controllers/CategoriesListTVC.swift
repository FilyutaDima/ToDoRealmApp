//
//  CategoriesTVC.swift
//  ToDoRealmApp
//
//  Created by Dmitry on 13.03.22.
//

import UIKit
import RealmSwift
 
class CategoriesListTVC: UITableViewController {

    var categoriesList: Results<Category>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categoriesList = realm.objects(Category.self).sorted(byKeyPath: "name")
        configureBarButtonItem()
    }

    @IBAction func sortingAction(_ sender: UISegmentedControl) {
    }
    
    @objc private func addCategoryAction() {
        addAndUpdateCategorisList()
    }
    
    private func configureBarButtonItem() {
        
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCategoryAction))
        
        self.navigationItem.rightBarButtonItems = [plusButton, self.editButtonItem]
    }
    
    private func addAndUpdateCategorisList() {
        
        let alertController = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        var alertTextField: UITextField!
        
        alertController.addTextField { textField in
            alertTextField = textField
            alertTextField.placeholder = "Category"
        }

        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            
            if let textField = alertController.textFields?.first,
            let newCategoryName = alertTextField.text,
            !newCategoryName.isEmpty,
            let self = self {
                
                let categoriesList = Category()
                categoriesList.name = newCategoryName
                
                StorageManager.saveCategory(category: categoriesList)
                self.tableView.insertRows(at: [IndexPath(row: self.categoriesList.count - 1, section: 0)], with: .fade)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)

        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let category = categoriesList[indexPath.row]
        cell.textLabel?.text = category.name
        cell.detailTextLabel?.text = category.tasksList.count.description
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
        } else if editingStyle == .insert {
           
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showTasksList", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
