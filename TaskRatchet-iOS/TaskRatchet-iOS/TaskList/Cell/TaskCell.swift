//
//  TaskCell.swift
//  TaskRatchet-iOS
//
//  Created by Thomas W. Dev on 16/11/2023.
//

import SwiftUI

struct TaskCell: View {
    let task: Task
    let completeCallback: () -> ()
    let editCallback: () -> ()

    private let viewModel: TaskCellViewModel
    
    init(task: Task, completeCallback: @escaping () -> (), editCallback: @escaping () -> ()) {
        self.task = task
        self.completeCallback = completeCallback
        self.editCallback = editCallback
        self.viewModel = TaskCellViewModel(task: task)
    }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button(viewModel.iconUnicode) {
                    completeCallback()
                }
                    .padding(.horizontal, 5.0)
                VStack(alignment: .leading) {
                    Text(task.task)
                    Text(viewModel.statusLine)
                        .foregroundColor(.gray)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10.0)
        .border(.gray, width: 1)
    }
}

