//
//  CheckBox.swift
//  TodoList
//
//  Created by Han on 2024/9/24.
//

import SwiftUI

struct CheckBox: View {
    @State var isChecked: Bool = false
    var onCheck: (Bool) -> Void
    
    var body: some View {
        Button(
            action: {
                isChecked.toggle()
                onCheck(isChecked)
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

#Preview {
    CheckBox(isChecked: false) {isChecked in print(isChecked)}
}
