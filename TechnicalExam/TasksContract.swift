//
//  TasksContract.swift
//  TechnicalExam
//
//  Created by Klein Noctis on 10/30/20.
//  Copyright © 2020 Klein Noctis. All rights reserved.
//

import Foundation

protocol TaskView {
    func displayTasks(tasks : [Task])
    func addTaskToList(task : Task)
    func removeTaskFromList(task : Task)
    func updateTaskInList(task : Task)
    
}

protocol TaskPresenter {
    func taskClicked()
    func savedTask(task : Task)
    func checkedTask(taskId : Int)
    func uncheckedTask(taskId : Int)
    func deletedTask(taskId : Int)
}
