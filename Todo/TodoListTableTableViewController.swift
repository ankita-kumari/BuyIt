//
//  ToDoListTableTableViewController.swift
//  Todo
//

import UIKit
import Realm

class TodoListTableViewController: UITableViewController {

    var todos: RLMResults {
        get {
            let predicate = NSPredicate(format: "finished == false", argumentArray: nil)
            return ToDoItem.objectsWithPredicate(predicate)
        }
    }
    
    var finished: RLMResults {
        get {
            let predicate = NSPredicate(format: "finished == true", argumentArray: nil)
            return ToDoItem.objectsWithPredicate(predicate)
        }
    }
    
    @IBAction func unwindAndAddToList(segue: UIStoryboardSegue) {
        let source = segue.sourceViewController as! AddTodoItemViewController
        let todoItem: ToDoItem = source.todoItem
            
        if todoItem.name != "" {
//            self.todoItems.append(todoItem)
            let realm = RLMRealm.defaultRealm()
            realm.beginWriteTransaction()
            realm.addObject(todoItem)
            realm.commitWriteTransaction()
            
            self.tableView.reloadData()
        }
    }
    
    @IBAction func unwindToList(segue: UIStoryboardSegue) {
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
//    func loadInitialData() {
//        todoItems = [
//            TodoItem(itemName: "Go to the dentist"),
//            TodoItem(itemName: "Fetch groceries"),
//            TodoItem(itemName: "Sleep")
//        ]
//        finishedItems = []
//    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.deselectRowAtIndexPath(indexPath, animated: false)
//        
//        let tappedItem = todoItems[indexPath.row] as TodoItem
//        tappedItem.completed = !tappedItem.completed
//        
//        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
        var todoItem: ToDoItem?
        switch indexPath.section {
        case 0:
            todoItem = todos.objectAtIndex(UInt(indexPath.row)) as? ToDoItem
        case 1:
            todoItem = finished.objectAtIndex(UInt(indexPath.row)) as? ToDoItem
        default:
            fatalError("What the fuck did you think ??")
        }
        let realm = RLMRealm.defaultRealm()
        realm.beginWriteTransaction()
        todoItem?.finished = !todoItem!.finished
        realm.commitWriteTransaction()
        self.tableView.reloadData()
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let tempCell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("ListPrototypeCell")! as UITableViewCell
//        let todoItem = todoItems[indexPath.row]
//        
//        // Downcast from UILabel? to UILabel
//        let cell = tempCell.textLabel as UILabel!
//        cell.text = todoItem.itemName
//        
//        if (todoItem.completed) {
//            tempCell.accessoryType = UITableViewCellAccessoryType.Checkmark;
//        } else {
//            tempCell.accessoryType = UITableViewCellAccessoryType.None;
//        }
//        
//        return tempCell
        let cell = tableView.dequeueReusableCellWithIdentifier("ListPrototypeCell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.userInteractionEnabled = true
        switch indexPath.section {
        case 0:
            let todoItem = todos.objectAtIndex(UInt(indexPath.row)) as! ToDoItem
            var attributedText = NSMutableAttributedString(string: todoItem.name)
            attributedText.addAttribute(NSStrikethroughStyleAttributeName, value: 0, range: NSMakeRange(0, attributedText.length))
            cell.textLabel!.attributedText = attributedText
        case 1:
            let todoItem = finished.objectAtIndex(UInt(indexPath.row)) as! ToDoItem
            var attributedText = NSMutableAttributedString(string: todoItem.name)
            attributedText.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, attributedText.length))
            cell.textLabel!.attributedText = attributedText
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        default:
            fatalError("What the fuck did you think ??")
        }
        return cell

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return Int(todos.count)
        case 1:
            return Int(finished.count)
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "To do"
        case 1:
            return "Finished"
        default:
            return ""
        }
    }
}
