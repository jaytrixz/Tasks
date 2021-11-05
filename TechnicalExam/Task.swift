//
//  Task.swift
//  TechnicalExam
//
//  Created by Klein Noctis on 10/30/20.
//  Copyright © 2020 Klein Noctis. All rights reserved.
//

import Foundation


class Task : Codable {
    var id : Int = 0
    var isComplete : Bool = false
    var description : String? = ""
}
