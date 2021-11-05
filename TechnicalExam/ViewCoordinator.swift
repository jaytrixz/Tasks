//
//  ViewCoordinator.swift
//  TechnicalExam
//
//  Created by John Joseph Santos on 11/5/21.
//  Copyright © 2021 Klein Noctis. All rights reserved.
//

import Foundation
import UIKit

class ViewCoordinator {
    
    // MARK: - Constants
    struct Constants {
        static let showTasksView = "showTasksView"
    }
    
    // MARK: - Properties
    var controller: UIViewController
    
    
    // MARK: - Initializers
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    /// Displays the tasks view to the next screen
    func showTasksView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.controller.performSegue(withIdentifier: Constants.showTasksView, sender: nil)
        }
    }
}
