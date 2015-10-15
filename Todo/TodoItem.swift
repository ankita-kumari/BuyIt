//
//  TodoItem.swift
//  Todo
//

import UIKit
import Realm

class ToDoItem: RLMObject {
    dynamic var name = ""
    dynamic var finished = false
}