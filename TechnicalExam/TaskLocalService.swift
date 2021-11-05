//
//  TaskLocalService.swift
//  TechnicalExam
//
//  Created by Klein Noctis on 10/30/20.
//  Copyright © 2020 Klein Noctis. All rights reserved.
//

import Foundation

protocol TaskLocalService {
    func save(task : Task)
    func saveAllTasks() 
    func findAll()
}
