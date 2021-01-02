//
//  Constants.swift
//  Listtly
//
//  Created by Ozan Mirza on 4/7/18.
//  Copyright © 2018 Ozan Mirza. All rights reserved.
//

import Foundation
import UIKit

struct Item: Codable {
    var title: String
    var description: String
    var color: ItemColor
    var section: Section
}

enum Section: Codable {
    enum Key: CodingKey {
        case rawValue
    }
    
    enum CodingError: Error {
        case unknownValue
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let rawValue = try container.decode(String.self, forKey: .rawValue)
        switch rawValue {
        case "main":
            self = .main
        case "completed":
            self = .completed
        case "flagged":
            self = .flagged
        case "trash":
            self = .trash
        default:
            throw CodingError.unknownValue
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        switch self {
        case .main:
            try container.encode("main", forKey: .rawValue)
        case .completed:
            try container.encode("completed", forKey: .rawValue)
        case .flagged:
            try container.encode("flagged", forKey: .rawValue)
        case .trash:
            try container.encode("trash", forKey: .rawValue)
        }
    }
    
    case main, flagged, trash, completed
}

struct ItemColor: Codable {
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    
    var color: UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    static func from(color: UIColor) -> ItemColor {
        var red: CGFloat = .zero
        var green: CGFloat = .zero
        var blue: CGFloat = .zero
        
        color.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        return ItemColor(red: red, green: green, blue: blue)
    }
}

var toDoList: [Item]? = [] // sections not capitalized

func saveData(toDoList: [Item]) {
    UserDefaults.standard.set(try? PropertyListEncoder().encode(toDoList), forKey: "fe4ty73ik00w1bnd6")
}

func fetchData() -> [Item]? {
    if let data = UserDefaults.standard.value(forKey: "fe4ty73ik00w1bnd6") as? Data {
        return try? PropertyListDecoder().decode(Array<Item>.self, from: data)
    }
    
    return nil
}

// Hierarchy:
// - 0 = color
// - 1 = title
// - 2 = description
// - 3 = trash
// - 4 = completed
// - 5 = flagged
