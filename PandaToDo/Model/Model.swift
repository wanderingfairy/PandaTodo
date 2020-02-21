//
//  Model.swift
//  PandaToDo
//
//  Created by 정의석 on 2020/02/11.
//  Copyright © 2020 pandaman. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct Todo {
    var todoTag: Int
    var date: String
    var time: String
    var memo: String
    var color: String
    var setAlarm: Bool
    
    func save(){
        UserDefaults.standard.set(todoTag, forKey: "todoTag")
        UserDefaults.standard.set(date, forKey: "date")
        UserDefaults.standard.set(time, forKey: "time")
        UserDefaults.standard.set(memo, forKey: "memo")
        UserDefaults.standard.set(color, forKey: "color")
        UserDefaults.standard.set(setAlarm, forKey: "setAlarm")
    }
}

class Singleton {
    static let shared = Singleton()
    var todoList: [Todo] = []
    var notiList: [String] = []
    
    private init() {}
}

struct TodoForCodable: Codable {
    var todoTag: Int
    var date: String
    var time: String
    var memo: String
}
