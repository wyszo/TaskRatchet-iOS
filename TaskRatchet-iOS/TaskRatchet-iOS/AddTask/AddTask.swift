//
//  AddEditTask.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 28/02/2023.
//

import ComposableArchitecture
import SwiftUI

struct AddTask: ReducerProtocol {
    let addTaskClient: AddTaskClient
    
    struct State: Equatable {
        var newTask = NewTask()
    }
    
    enum Action: Equatable {
        
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        }
    }
}
