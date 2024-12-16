//
//  ContentView.swift
//  WakebApp
//
//  Created by Maram Rabeh  on 10/06/1446 AH.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            Text("ContentView")
                .foregroundColor(.white)
                .font(.system(size: 30))
            
        }
    }
}

#Preview {
    ContentView()
}
