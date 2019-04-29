//
//  TaskCell.swift
//  ToDoApp
//
//  Created by Gabriel Equitz on 3/25/19.
//  Copyright © 2019 Gabriel Equitz. All rights reserved.
//

import UIKit

protocol ChangeButton{
    func changeButton(checked: Bool, index: Int)
}

//class to handle checked box
class TaskCell: UITableViewCell {
    
    
    @IBAction func checkBoxAction(_ sender: Any) {
        if tasks![indexP!].checked {
            delegate?.changeButton(checked: false, index: indexP!)
        } else {
            delegate?.changeButton(checked: true, index: indexP!)
        }
    }
    
    @IBOutlet weak var checkBoxOutlet: UIButton!
    
    
    @IBOutlet weak var taskNameLabel: UILabel!
    
    var delegate: ChangeButton?
    var indexP: Int?
    var tasks: [Task]?
    
}
