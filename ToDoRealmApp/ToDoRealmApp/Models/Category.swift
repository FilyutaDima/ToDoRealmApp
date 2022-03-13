//
//  TasksList.swift
//  ToDoRealmApp
//
//  Created by Dmitry on 13.03.22.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name = ""
    @objc dynamic var date = Date()
    let tasksList = List<Task>()
}
