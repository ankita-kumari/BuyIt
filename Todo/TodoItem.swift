//
//  TodoItem.swift
//  Todo
//

import UIKit
import Realm

class ToDoItem: RLMObject {
    dynamic var name = ""
    dynamic var finished = false
    dynamic var href = "https://www.google.co.in"
}