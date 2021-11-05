//
//  ViewController.swift
//  TechnicalExam
//
//  Created by Klein Noctis on 10/30/20.
//  Copyright © 2020 Klein Noctis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var presenter: ViewPresenterProtocol?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        showTasksView()
        /**
         *   Tasks
         *   1. Add a UIImageView and UILabel below it using autolayout
         *   2. Change the text to your favorite quote
         *   3. Set it to any image that best illustrate the quote provided
         *   4. Display this screen for 3 seconds and then using storyboard either with UINavigationController or any navigate to TaskViewController
         *
        **/
    }
    
    // MARK: - Private methods
    
    /// Configures and initializes the view
    private func configureView() {
        presenter = ViewPresenter(controller: self)
    }
    
    /// Displays the tasks view to the next screen
    private func showTasksView() {
        guard let presenter = presenter else { return }
        presenter.showTasksView()
    }
}

