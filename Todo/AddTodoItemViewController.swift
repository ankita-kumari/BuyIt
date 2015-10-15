//
//  AddToDoItemViewController.swift
//  Todo
//

import UIKit
import Realm

class AddTodoItemViewController: UIViewController {

    var todoItem: ToDoItem = ToDoItem()
    
    @IBOutlet var doneButton: UIBarButtonItem!
    @IBOutlet var textField: UITextField!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (self.textField.text!.utf16.count > 0) {
            todoItem.name = self.textField.text!
            todoItem.finished = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
