//
//  Constants.swift
//  Listtly
//
//  Created by Ozan Mirza on 4/7/18.
//  Copyright © 2018 Ozan Mirza. All rights reserved.
//

import Foundation
import UIKit

var toDoList: [[AnyObject]]? = [] // sections not capitalized

func saveData(toDoList: [[AnyObject]]) {
    let toDoListData = NSKeyedArchiver.archivedData(withRootObject: toDoList)
    UserDefaults.standard.set(toDoListData, forKey: "fe4ty73ik00w1bnd6")
}

func fetchData() -> [[AnyObject]]? {
    if let todo = UserDefaults.standard.array(forKey: "fe4ty73ik00w1bnd6") as! [[AnyObject]]? {
        return todo
    } else {
        return nil
    }
}

// Hierarchy:
// - 0 = color
// - 1 = title
// - 2 = description
// - 3 = trash
// - 4 = completed
// - 5 = flagged
