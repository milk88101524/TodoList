//
//  FloatActionButton.swift
//  TodoList
//
//  Created by Han on 2024/9/24.
//

import SwiftUI

struct FloatActionButton: View {
    var btnTitle: String
    var img: String
    var onClick: () -> Void
    
    var body: some View {
        Button(action: onClick, label: {
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

#Preview {
    FloatActionButton(btnTitle: "Add", img: "svg_add") {}
    FloatActionButton(btnTitle: "Delete", img: "svg_delete") {}
}
