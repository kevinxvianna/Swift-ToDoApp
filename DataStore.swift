//
//  datastore.swift
//  ToDo List
//
//  Created by kevin.quinalia on 18/05/22.
//

import Foundation
import SwiftUI
import Combine

struct TaskType: Identifiable {
    var id = String()
    var task = String()
}

class TaskStore: ObservableObject {
    @Published var tasks = [TaskType]()
}
