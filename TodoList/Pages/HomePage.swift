//
//  HomePage.swift
//  TodoList
//
//  Created by Han on 2024/9/24.
//

import SwiftUI

struct HomePage: View {
    @State private var toast: Toast? = nil
    @State private var showSheet: Bool = false
    @State private var todos: [Todo] = []
    private let todoManager: TodoManager = TodoManager()
    
    func loadTodos() {
        todos = todoManager.loadTodos()
    }
    
    func addTodo(todo: String) {
        todoManager.saveTodo(todo: todo)
        loadTodos()
        showToast(message: "Add Task Success")
    }
    
    func updateTodo(id: String, finished: Bool) {
        todoManager.updateTodo(id: id, finished: finished)
        loadTodos()
        showToast(message: finished ? "Finish" : "Unfinish")
    }
    
    func deleteTodo(id: String) {
        todoManager.deleteTodo(id: id)
        loadTodos()
        showToast(message: "Delete")
    }
    
    func showToast(message: String) {
        toast = nil
        toast = Toast(message: message)
    }
    
    var body: some View {
        VStack {
            List(todos, id: \.id) { todo in
                TodoCard(
                    todo: todo,
                    onCheck: { isChecked in
                        updateTodo(id: todo.id, finished: isChecked)
                        print("\(todo.title) \(isChecked)")
                    },
                    onClick: {
                        deleteTodo(id: todo.id)
                        print("\(todo.title) onClicked")
                    }
                )
                .listRowInsets(EdgeInsets())
                .listRowSpacing(.infinity)
                .listRowBackground(Color.clear)
            }
            .listStyle(.grouped)
        }
        .frame(maxWidth: .infinity)
        .background(Colors.bg)
        .overlay(alignment: .bottomTrailing, content: {
            FloatActionButton(btnTitle: "Add", img: "svg_add") {
                showSheet.toggle()
            }
            .padding(20)
        })
        .toastView(toast: $toast)
        .sheet(isPresented: $showSheet, content: {
            AddTask { todo in
                addTodo(todo: todo)
                showSheet.toggle()
            }
            .presentationDetents([.height(300)])
            .presentationDragIndicator(.visible)
        })
        .onAppear {
            loadTodos()
        }
    }
}

#Preview {
    HomePage()
}
