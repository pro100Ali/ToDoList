 //
//  ViewController.swift
//  ToDoList
//
//  Created by Али  on 16.02.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        print(models[0].name)
        cell.textLabel?.text = model.name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = models[indexPath.row]
        let sheet = UIAlertController(title: "Edit",
                                      message: "Edit your item",
                                      preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "edit", style: .default, handler: { _ in
            
            let alert = UIAlertController(title: "New item",
                                          message: "Enter new item",
                                          preferredStyle: .alert)
            alert.addTextField(configurationHandler: nil)
            alert.textFields?.first?.text = item.name
            alert.addAction(UIAlertAction(title: "Save", style: .cancel, handler: { [weak self] _ in
                guard let field = alert.textFields?.first, let newName = field.text, !newName.isEmpty else {
                    return
                }
                
                self?.updateItem(item: item, newName: newName)
            }))
            self.present(alert, animated: true)
            
        }))
        sheet.addAction(UIAlertAction(title: "delete", style: .destructive, handler: { [weak self] _ in
            self?.deleteItem(item: item )
        }))
        present(sheet, animated: true)
    }

    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier:  "cell")
        return table
    }()
    
    private var models = [ToDoListItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "ToDoList"
        self.navigationItem.title = "Your Title"
        view.backgroundColor =  .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.bounds
        getAllItems()
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(tableView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
     }
        
    @objc private func didTapAdd() {
        let alert = UIAlertController(title: "New item", message: "Enter new item", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }
            
            self?.createdItem(name: text)
        }))
        present(alert, animated: true)
    }
    
        func getAllItems() {
            do {
                models = try context.fetch(ToDoListItem.fetchRequest())
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
        
        func createdItem(name: String) {
            let newItem = ToDoListItem(context: context)
            newItem.name = name
            newItem.createdAt = Date()
            do {
                try context.save()
                getAllItems()
//                print()
            }
            catch {
                print(error.localizedDescription)
            }
        }
        
        func deleteItem(item: ToDoListItem) {
            context.delete(item)
            do {
                try context.save()
                getAllItems()
            }
            catch {
                
            }
            
        }
        
        func updateItem(item: ToDoListItem, newName: String) {
            item.name = newName
            do {
                try context.save()
                getAllItems()
                
            }
            catch {
                
            }
            
        }


}

