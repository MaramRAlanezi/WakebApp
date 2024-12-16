//
//  splashscreenview.swift
//  WakebApp
//
//  Created by Wajan Altalhan on 11/06/1446 AH.
//

import SwiftUI

struct splashscreenview: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack{
                Color.color
                    .ignoresSafeArea()
            VStack{
                VStack{
                    Image("logo2")
                    Text("Grow With Every Word")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 2.5)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
                }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    withAnimation{
                        self.isActive = true  }
                }
            }
            }
        }
      
    }
}

#Preview {
    splashscreenview()
}
