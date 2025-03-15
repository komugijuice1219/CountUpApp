//
//  OpeningView.swift
//  countup
//
//  Created by たお1219 on 2024/11/13.
//

import SwiftUI

struct OpeningView: View {
    @State private var showMainContent = false
    @State private var splashOpacity = 1.0 // fadeout
    
    // 设置动画时长
        private let animationDuration = 3.0 // 淡出动画时长（秒）
        private let splashDisplayDuration = 4.0 // 总的开场动画时长（秒）

    var body: some View {
        if showMainContent {
            ContentView()
        } else {
            SplashScreen(opacity: $splashOpacity)
                .onAppear {
                    // 设置淡出效果和延迟切换到主视图
                    withAnimation(.easeOut(duration: 2.5)) {
                        splashOpacity = 0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        showMainContent = true
                    }
                }
        }
    }
}
                           

                           struct SplashScreen: View {
                               @Binding var opacity: Double // 接收 OpeningView 的透明度控制

                               var body: some View {
                                   Image("opening") // 将 "splashImage" 替换为你的图片名称
                                       .resizable()
                                       .scaledToFill()
                                       .frame(width: 200, height: 200)
                                       .opacity(opacity) // 绑定透明度
                               }
                           }

                        

#Preview {
    OpeningView()
}
