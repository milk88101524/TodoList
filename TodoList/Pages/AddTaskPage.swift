//
//  AddTask.swift
//  TodoList
//
//  Created by Han on 2024/9/24.
//

import SwiftUI

struct AddTask: View {
    var onClick: (String) -> Void
    
    @State private var task: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Add Task")
                    .font(.title)
                    .padding()
                Spacer()
            }
            .padding()
            TextField("Enter Task", text: $task)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 14).stroke(lineWidth: 1))
                .padding()
            HStack {
                Spacer()
                Button("Add") {
                    onClick(task)
                }
                .padding()
                .background(Colors.itemBg)
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .foregroundStyle(.black)
                .padding()
            }
        }
    }
}

#Preview {
    AddTask() { _ in
        
    }
}
