//
//  TableViewController.swift
//  DemoCoreData
//
//  Created by Aleksandr Kalinin on 27.03.17.
//  Copyright © 2017 Aleksandr Kalinin. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
  var toDoItems: [Task] = []
  
  @IBAction func addNewTask(_ sender: UIBarButtonItem) {
    let ac = UIAlertController(title: "Add task", message: "add new task", preferredStyle: .alert)
    let ok = UIAlertAction(title: "Ok", style: .default) { action in
      let textField = ac.textFields?[0]
      
      // Новый таск добавляется всегда в самый верх списка на позицию 0
      self.saveTask(newTask: (textField?.text)!)
      //      self.toDoItems.insert((textField?.text)!, at: 0)
      self.tableView.reloadData()
    }
    let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
    
    // Добавляем поле для ввода в alert
    ac.addTextField { textField in }
    ac.addAction(ok)
    ac.addAction(cancel)
    
    present(ac, animated: true, completion: nil)
  }
  
  func saveTask(newTask: String) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let taskEntity = NSEntityDescription.entity(forEntityName: "Task", in: context)
    guard taskEntity != nil else { print("NIL печальбеда"); return }
    let taskObject = NSManagedObject(entity: taskEntity!, insertInto: context) as! Task
    
    taskObject.text = newTask
    do {
      try context.save()
      toDoItems.append(taskObject)
    } catch {
      print("Error \(error.localizedDescription)")
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return toDoItems.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
    let task = toDoItems[indexPath.row]
    cell.textLabel?.text = task.text
    
    return cell
  }
  
  /*
   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */
  
  /*
   // Override to support editing the table view.
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
   if editingStyle == .delete {
   // Delete the row from the data source
   tableView.deleteRows(at: [indexPath], with: .fade)
   } else if editingStyle == .insert {
   // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
   }
   }
   */
  
  /*
   // Override to support rearranging the table view.
   override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
   
   }
   */
  
  /*
   // Override to support conditional rearranging of the table view.
   override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the item to be re-orderable.
   return true
   }
   */
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
