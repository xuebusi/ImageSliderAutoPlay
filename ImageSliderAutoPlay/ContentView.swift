//
//  ContentView.swift
//  ImageSliderAutoPlay
//
//  Created by shiyanjun on 2024/10/19.
//

import SwiftUI

struct ContentView: View {
    // 计时器
    public let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    // 图片名称为"m0"至"m7"
    let images = (0...7).map({"m\($0)"})
    
    // 当前图片索引
    @State private var selection = 0
    
    var body: some View {
        TabView(selection : $selection){
            ForEach(images.indices, id: \.self){ index in
                Image(images[index])
                    .resizable()
                    .scaledToFit()
                    .id(index)
            }
        }
        // 分页
        .tabViewStyle(.page(indexDisplayMode: .always))
        // 分页指示器
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .onReceive(timer, perform: { _ in
            // 自动轮播动画
            withAnimation {
                selection = selection < images.count ? selection + 1 : 0
            }
        })
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
