//
//  ViewContract.swift
//  TechnicalExam
//
//  Created by John Joseph Santos on 11/5/21.
//  Copyright © 2021 Klein Noctis. All rights reserved.
//

import Foundation
import UIKit

protocol ViewPresenterProtocol {
    var presenter: ViewPresenterProtocol? { get set }
    
    /// Displays the tasks view to the next screen
    func showTasksView()
}
