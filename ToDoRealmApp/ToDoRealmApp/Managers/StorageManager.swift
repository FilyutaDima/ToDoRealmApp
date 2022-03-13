//
//  StorageManager.swift
//  ToDoRealmApp
//
//  Created by Dmitry on 13.03.22.
//

import Foundation
import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func deleteAll() {
        do {
            try realm.write{
                realm.deleteAll()
            }
        } catch {
            print("deleteAll error")
        }
    }
    
    static func saveCategory(category: Category) {
        try! realm.write {
            realm.add(category)
        }
    }
    
}
