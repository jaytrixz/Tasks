//
//  TaskLocalServiceProvider.swift
//  TechnicalExam
//
//  Created by Klein Noctis on 10/30/20.
//  Copyright © 2020 Klein Noctis. All rights reserved.
//

import Foundation

class TaskLocalServiceProvider : TaskLocalService {
    
    let defaults = UserDefaults.standard
    let taskKey = "Tasks"
    var allTasks = [Task]()
    init() {
        if let objects = defaults.value(forKey: taskKey) as? Data {
            let decoder = JSONDecoder()
            if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [Task] {
                allTasks = objectsDecoded
            }
        }
    }
    
    func save(task: Task) {
        allTasks.append(task)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(allTasks){
            UserDefaults.standard.set(encoded, forKey: taskKey)
        }

    }
    
    func saveAllTasks() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(allTasks){
            UserDefaults.standard.set(encoded, forKey: taskKey)
        }

    }
    
    func findAll() {
        if let objects = defaults.value(forKey: taskKey) as? Data {
            let decoder = JSONDecoder()
            if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [Task] {
                allTasks = objectsDecoded
            }
        }
        
    }
    
}
