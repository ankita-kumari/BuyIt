//
//  ToDoListTableTableViewController.swift
//  Todo
//

import UIKit
import Realm

class TodoListTableViewController: UITableViewController {
    
    var URL = NSURL(string : "")
    
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
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
    
    @IBAction func openURL(sender: UIButton) {
        let button = sender
        performSegueWithIdentifier("openURL", sender: button)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "openURL") {
            let button = sender
            let view = button.superview!
            let cell = view?.superview as! UITableViewCell
            let indexPath:NSIndexPath = self.tableView.indexPathForCell(cell)!
            var todoItem:ToDoItem = ToDoItem()
            switch indexPath.section {
            case 0:
                todoItem = todos.objectAtIndex(UInt(indexPath.row)) as! ToDoItem
            case 1:
                todoItem = finished.objectAtIndex(UInt(indexPath.row)) as! ToDoItem
            default:
                fatalError("What the fuck did you think?!")
            }
            let webview = segue.destinationViewController as! WebViewController
            webview.url = NSURL(string : todoItem.href)
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ListPrototypeCell", forIndexPath: indexPath) as UITableViewCell
        for view in cell.contentView.subviews {
            if (view.isKindOfClass(UILabel)) {
                view.removeFromSuperview()
            }
        }
        let label:UILabel = UILabel(frame: CGRectMake(15, 3, 200, 30))
        label.textAlignment = NSTextAlignment.Justified
        label.textColor = UIColor.blackColor()
        
        //var buyButton: UIButton =
        cell.textLabel?.userInteractionEnabled = true
        switch indexPath.section {
        case 0:
            let todoItem = todos.objectAtIndex(UInt(indexPath.row)) as! ToDoItem
            let attributedText = NSMutableAttributedString(string: todoItem.name)
            attributedText.addAttribute(NSStrikethroughStyleAttributeName, value: 0, range: NSMakeRange(0, attributedText.length))
            label.attributedText = attributedText
            if (todoItem.finished) {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            } else {
                cell.accessoryType = UITableViewCellAccessoryType.None
            }
        case 1:
            let todoItem = finished.objectAtIndex(UInt(indexPath.row)) as! ToDoItem
            let attributedText = NSMutableAttributedString(string: todoItem.name)
            attributedText.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, attributedText.length))
            label.attributedText = attributedText
            if (todoItem.finished) {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            } else {
                cell.accessoryType = UITableViewCellAccessoryType.None
            }
        default:
            fatalError("What the fuck did you think ??")
        }
        cell.contentView.addSubview(label)
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
