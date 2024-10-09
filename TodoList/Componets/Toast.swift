//
//  Toast.swift
//  TodoList
//
//  Created by Han on 2024/9/24.
//

import SwiftUI

// 定義 Toast 資料結構，包含消息、持續時間和寬度
struct Toast: Equatable {
    var message: String           // 要顯示的消息
    var duration: Double = 3.5    // Toast 顯示的時間，預設 3.5 秒
    var width: CGFloat = .infinity // Toast 視圖的寬度，預設為無限寬
}

// Toast 視圖組件，負責顯示消息
struct ToastView: View {
    var message: String          // 要顯示的消息
    var width: CGFloat = .infinity // 視圖的最大寬度
    
    var body: some View {
        HStack(alignment: .center) {
            Text(message)
                .padding()
            Spacer()
        }
        .padding(3)
        .frame(maxWidth: width)
        .background(Color.black.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(10)
    }
}

// ToastModifier 是一個自定義的 ViewModifier，負責控制 Toast 的顯示和隱藏邏輯
struct ToastModifier: ViewModifier {
    @Binding var toast: Toast?   // 綁定的 Toast 物件，用來控制是否顯示
    @State private var workItem: DispatchWorkItem? // 用於控制延遲隱藏的任務
    
    // body 函數，將 Toast 視圖疊加在主要的內容視圖上
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity) // 主要內容視圖占滿可用空間
            .overlay( // 疊加 Toast 視圖於內容視圖上
                ZStack {
                    mainToastView() // 顯示主要的 Toast 視圖
                }.animation(.spring(), value: toast) // 當 toast 狀態變化時，用彈簧動畫顯示或隱藏
            )
            .onChange(of: toast) { // 當 toast 狀態改變時觸發顯示邏輯
                showToast()
            }
    }
    
    // 主 Toast 視圖的定義
    @ViewBuilder func mainToastView() -> some View {
        if let toast { // 如果 toast 不為 nil，則顯示 Toast 視圖
            VStack {
                Spacer() // 使用 Spacer 將 Toast 放在畫面底部
                ToastView(message: toast.message, width: toast.width) // 使用傳入的消息與寬度構建 Toast
            }
        }
    }
    
    // 顯示 Toast，並在一段時間後自動消失
    private func showToast() {
        guard let toast = toast else { return } // 如果沒有 toast 則直接返回
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred() // 觸發震動反饋
        
        if toast.duration > 0 { // 如果 Toast 設定的持續時間大於 0
            workItem?.cancel() // 取消之前的工作項目，避免重疊
            
            let task = DispatchWorkItem { // 定義一個工作項目
                dismissToast() // 任務執行時隱藏 Toast
            }
            
            workItem = task // 設定當前的工作項目
            DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration) {
                task.perform() // 在 duration 時間後執行該工作項目
            }
        }
    }
    
    // 隱藏 Toast，並清理工作項目
    private func dismissToast() {
        withAnimation { // 使用動畫來隱藏 Toast
            toast = nil // 將 toast 設置為 nil，隱藏視圖
        }
        
        workItem?.cancel() // 取消延遲隱藏的工作項目
        workItem = nil // 清除工作項目
    }
}

// View 擴展，用來在任何 View 上套用 ToastModifier
extension View {
    // 自定義修飾符，便於在 View 中輕鬆調用
    func toastView(toast: Binding<Toast?>) -> some View {
        self.modifier(ToastModifier(toast: toast)) // 將 ToastModifier 應用到當前視圖
    }
}

// 參考至 https://www.youtube.com/watch?v=vTg6Iyr7LEk&t=214s
