//
//  Test.swift
//  TodoList
//
//  Created by Han on 2024/9/25.
//

import SwiftUI

struct Test: View {
    @State private var showSheet: Bool = false
        
        var body: some View {
            VStack {
                List(0..<10) { index in
                    TodoCardTest()
                    .listRowInsets(EdgeInsets())
                    .listRowSpacing(.infinity)
                    .listRowBackground(Color.clear)
                }
                .listStyle(.grouped)
                .background(.clear)
            }
            .frame(maxWidth: .infinity)
            .overlay(alignment: .bottomTrailing, content: {
                FloatActionButtonTest(btnTitle: "Add", img: "svg_add")
                .padding(20)
            })
            .sheet(isPresented: $showSheet, content: {
                AddTaskTest()
                .presentationDetents([.height(300)])
                .presentationDragIndicator(.visible)
            })
        }
}

#Preview {
    Test()
}












struct CheckBoxTest: View {
    @State var isChecked: Bool = false
    
    var body: some View {
        Button(
            action: {
                isChecked.toggle()
            },
            label: {
                if (isChecked) {
                    Image(systemName: "checkmark.square.fill")
                        .font(.system(size: 30))
                        .foregroundStyle(.black)
                } else {
                    Image(systemName: "square")
                        .font(.system(size: 30))
                        .foregroundStyle(.black)
                }
            }
        )
    }
}

struct TodoCardTest: View {
    var body: some View {
        HStack {
            CheckBoxTest()
                .padding(10)
            Text("title")
                .font(.title)
                .padding(5)
                .foregroundStyle(.black)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(red: 171/255, green: 171/255, blue: 171/255))
        .swipeActions(edge: .leading, content: {
            Button(action: {}) {
                Image(uiImage: UIImage(named: "svg_delete")!)
            }
        })
        .tint(.red)
    }
}

struct FloatActionButtonTest: View {
    var btnTitle: String
    var img: String
    
    var body: some View {
        Button(action: {}, label: {
            HStack {
                Image(uiImage: UIImage(named: img)!)
                Text(btnTitle)
                    .foregroundStyle(.black)
            }
            .padding()
            .background(Colors.fabBg)
            .clipShape(RoundedRectangle(cornerRadius: 14))
        })
        .shadow(radius: 10)
    }
}

struct AddTaskTest: View {
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
                Button("Add") {}
                .padding()
                .background(Colors.itemBg)
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .foregroundStyle(.black)
                .padding()
            }
        }
    }
}
