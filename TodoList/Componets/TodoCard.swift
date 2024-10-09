//
//  NoteCard.swift
//  TodoList
//
//  Created by Han on 2024/9/24.
//

import SwiftUI

struct TodoCard: View {
    var todo: Todo
    var onCheck: (Bool) -> Void
    var onClick: () -> Void
    
    var body: some View {
        HStack {
            CheckBox(isChecked: todo.isFinish, onCheck: { isChecked in
                onCheck(isChecked)
            })
            .padding(10)
            Text((todo.isFinish) ? "~\(todo.title)~" : "\(todo.title)")
                    .font(.title)
                    .padding(5)
                    .foregroundStyle(.black)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Colors.itemBg)
        .swipeActions(edge: .leading, allowsFullSwipe: false, content: {
            Button(action: onClick) {
                Image(uiImage: UIImage(named: "svg_delete")!)
            }
        })
        .tint(.red)
    }
}

#Preview {
    TodoCard(todo: Todo(id: "123", title: "title", isFinish: false), onCheck: {_ in }, onClick: {})
}
