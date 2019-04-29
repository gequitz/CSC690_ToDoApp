//
//  ViewController.swift
//  ToDoApp
//
//  Created by Gabriel Equitz on 3/25/19.
//  Copyright © 2019 Gabriel Equitz. All rights reserved.
//


// program that creates application of a todo list.
//user can edit task by swiping to the right and delete task by swiping to the right
// the application saves the tasks when turned off.
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddTask, ChangeButton {
    
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // creating task array
    var tasks: [Task] = []
    
    var store = UserDefaults.standard
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        let decoder = JSONDecoder()
        if
            let storedTaskData = store.data(forKey: "tasks"),
            let tasks = try? decoder.decode(Array<Task>.self, from: storedTaskData) {
            self.tasks = tasks
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
        
        
        cell.taskNameLabel.text = tasks[indexPath.row].name
        
        
        if tasks[indexPath.row].checked{
            cell.checkBoxOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkBoxFILLED "), for: UIControl.State.normal)
        } else {
            cell.checkBoxOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkBoxOUTLINE "), for: UIControl.State.normal)
        }
        
        
        cell.delegate = self
        cell.indexP = indexPath.row
        cell.tasks = tasks
        
        
        return cell
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let vc = segue.destination as! AddTaskController
        vc.delegate = self
        
    }

    
    
    func addTask(name: String){
        tasks.append(Task(name: name))
        
        let enconder = JSONEncoder()
        if let taskData = try? enconder.encode(self.tasks){
            self.store.set(taskData, forKey: "tasks")
        }
        tableView.reloadData()
    }
    
    
    func changeButton(checked: Bool, index: Int){
        tasks[index].checked = checked
        tableView.reloadData()
    }
    
    
    //function to delete task
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        
        
        if editingStyle == .delete{
            tasks.remove(at: indexPath.row)
            tableView.reloadData()
            
        }

        
        
    }
    
    
    
    //function to edit task
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let alert = UIAlertController(title: "Edit", message: nil, preferredStyle: .alert)
        alert.addTextField{ (taskNameOutlet) in taskNameOutlet.placeholder = self.tasks[indexPath.row].name}
        
        let action = UIAlertAction(title: "Edit", style: .default){ (_) in
            self.tasks[indexPath.row].name = alert.textFields!.first!.text!
            tableView.reloadData()
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(action)
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
            
        
        
    }
 
    
    
}



class Task:Codable{
    var name = ""
    var checked = false
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}






