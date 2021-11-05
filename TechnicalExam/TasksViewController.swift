//
//  TasksViewController.swift
//  TechnicalExam
//
//  Created by Klein Noctis on 10/30/20.
//  Copyright © 2020 Klein Noctis. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController, TaskView, TaskPresenter, UITableViewDataSource, UITableViewDelegate {
    
    var presenter: TaskPresenter?
    var provider: TaskLocalServiceProvider = TaskLocalServiceProvider()
    
    var selectedIndex: Int = 0
    
    // MARK: - Constants
    struct Constants {
        static let taskCell = "TaskCell"
        
        struct Titles {
            static let saveTitle = "Save"
            static let completeTitle = "Mark as Complete"
            static let incompleteTitle = "Mark as Incomplete"
            static let removeTitle = "Remove"
            static let yesTitle = "Yes"
            static let cancelTitle = "Cancel"
            static let addTaskTitle = "Add Task"
            static let updateTaskTitle = "Update Task"
            static let removeTaskTitle = "Remove Task"
        }
        
        struct Descriptions {
            static let addTaskMessage = "Add your task description here. Don't forget to save."
            static let updateTaskMessage = "Update your task description here. Don't forget to save."
            static let removeTaskMessage = "Are you sure you want to remove this task?"
            static let placeholderMessage = "Task description"
            static let defaultTaskDescription = ""
        }
    }
    
    @IBOutlet var table: UITableView?
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        /**
         *   Finish this simple task recording app
         *   1. Make sure all defects are fixed
         *   2. Show a view (can be UIAlertController or any) that can add/edit the task.
         *   3. Show the added task in a UITableView/CollectionView
         *   4. Allow the user to toggle it as completed
         *   5. Allow the user to delete a task
         *
         **/
    }
    
    // MARK: - Task view protocols
    
    func displayTasks(tasks: [Task]) {
        DispatchQueue.main.async {
            self.table?.reloadData()
        }
    }
    
    func addTaskToList(task: Task) {
        provider.save(task: task)
        displayTasks(tasks: provider.allTasks)
    }
    
    func removeTaskFromList(task: Task) {
        provider.allTasks.removeLast()
        displayTasks(tasks: provider.allTasks)
    }
    
    func updateTaskInList(task: Task) {
        let alert = UIAlertController(title: Constants.Titles.updateTaskTitle,
                                      message: Constants.Descriptions.updateTaskMessage,
                                      preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = Constants.Descriptions.placeholderMessage
            textField.text = task.description
        }
        let cancelAction = UIAlertAction(title: Constants.Titles.cancelTitle, style: .cancel, handler: nil)
        
        // Save action
        let saveAction = UIAlertAction(title: Constants.Titles.saveTitle, style: .default) { Action in
            task.description = alert.textFields?.first?.text
            self.provider.saveAllTasks()
            self.displayTasks(tasks: self.provider.allTasks)
        }
        
        var completeTitle: String = ""
        if task.isComplete {
            completeTitle = Constants.Titles.incompleteTitle
        } else {
            completeTitle = Constants.Titles.completeTitle
        }
        
        // Mark as Complete/Incomplete action
        let completeAction = UIAlertAction(title: completeTitle, style: .default) { Action in
            if !task.isComplete {
                task.isComplete = true
            } else {
                task.isComplete = false
            }
            self.provider.saveAllTasks()
            self.displayTasks(tasks: self.provider.allTasks)
        }
        
        // Remove action
        let removeAction = UIAlertAction(title: Constants.Titles.removeTitle, style: .destructive) { Action in
            self.showRemoveAlert()
        }
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        alert.addAction(completeAction)
        alert.addAction(removeAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Task presenter protocols
    
    func taskClicked() {
        updateTaskInList(task: provider.allTasks[selectedIndex])
    }
    
    func savedTask(task: Task) {
        addTaskToList(task: task)
    }
    
    func saveAllTasks() {
        
    }
    
    func checkedTask(taskId: Int) {
        taskClicked()
    }
    
    func uncheckedTask(taskId: Int) {
        
    }
    
    func deletedTask(taskId: Int) {
        provider.allTasks.remove(at: taskId)
        displayTasks(tasks: provider.allTasks)
    }
    
    // MARK: - Private methods
    
    private func configureView() {
        configureTable()
        configureTasks()
    }
    
    private func configureTable() {
        table = UITableView(frame: CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.height))
        table?.dataSource = self
        table?.delegate = self
        table?.register(UITableViewCell.self, forCellReuseIdentifier: Constants.taskCell)
        view.addSubview(table ?? UITableView())
    }
    
    private func configureTasks() {
        provider.findAll()
        displayTasks(tasks: provider.allTasks)
    }
    
    private func showRemoveAlert() {
        let alert = UIAlertController(title: Constants.Titles.removeTaskTitle,
                                      message: Constants.Descriptions.removeTaskMessage,
                                      preferredStyle: .alert)
        
        // Cancel action
        let cancelAction = UIAlertAction(title: Constants.Titles.cancelTitle, style: .cancel, handler: nil)
        
        // Yes action
        let yesAction = UIAlertAction(title: Constants.Titles.yesTitle, style: .destructive) { Action in
            self.deletedTask(taskId: self.selectedIndex)
        }
        alert.addAction(cancelAction)
        alert.addAction(yesAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Action methods
    
    @IBAction private func addButtonTapped() {
        let alert = UIAlertController(title: Constants.Titles.addTaskTitle,
                                      message: Constants.Descriptions.addTaskMessage,
                                      preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = Constants.Descriptions.placeholderMessage
            textField.text = ""
        }
        
        // Cancel action
        let cancelAction = UIAlertAction(title: Constants.Titles.cancelTitle, style: .cancel, handler: nil)
        
        // Save action
        let saveAction = UIAlertAction(title: Constants.Titles.saveTitle, style: .default) { Action in
            let newTask = Task()
            newTask.id = Int.random(in: 000001..<999999)
            newTask.description = alert.textFields?.first?.text
            self.savedTask(task: newTask)
        }
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return provider.allTasks.count
    }
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.taskCell, for: indexPath)
        let task = provider.allTasks[indexPath.row]
        cell.textLabel?.text = "\(task.id): \(task.description ?? "")"
        
        if task.isComplete {
            cell.backgroundColor = .green
        } else {
            cell.backgroundColor = .white
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndex = indexPath.row
        checkedTask(taskId: selectedIndex)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
