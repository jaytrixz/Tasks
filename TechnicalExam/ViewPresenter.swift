//
//  ViewPresenter.swift
//  TechnicalExam
//
//  Created by John Joseph Santos on 11/5/21.
//  Copyright © 2021 Klein Noctis. All rights reserved.
//

import Foundation
import UIKit

class ViewPresenter : ViewPresenterProtocol {
    var presenter: ViewPresenterProtocol?
    var coordinator: ViewCoordinator?
    
    // MARK: - Initializers
    init(controller: ViewController ) {
        controller.presenter = self
        coordinator = ViewCoordinator(controller: controller)
    }
    
    // MARK: - Protocols
    /// Displays the tasks view to the next screen
    func showTasksView() {
        guard let coordinator = coordinator else { return }
        coordinator.showTasksView()
    }
}
