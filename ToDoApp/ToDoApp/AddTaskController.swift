//
//  AddTaskController.swift
//  ToDoApp
//
//  Created by Gabriel Equitz on 3/25/19.
//  Copyright © 2019 Gabriel Equitz. All rights reserved.
//

import UIKit


//protocol to add task
protocol AddTask{
    func addTask(name: String )
}

class AddTaskController: UIViewController {
    
    @IBAction func addAction(_ sender: Any) {
        
        if taskNameOutlet.text != ""{
            delegate?.addTask(name: taskNameOutlet.text!)
            navigationController?.popViewController(animated: true)
            
        }
        
        
    }
    
    @IBOutlet weak var taskNameOutlet: UITextField!
    
    var delegate: AddTask?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    

    
}
