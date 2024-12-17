//
//  BoardingPage.swift
//  WakebApp
//
//  Created by Maram Rabeh  on 17/12/2024.
//

import SwiftUI

struct BoardingPage: View {
    var body: some View {
        ZStack {
            
            Color(.offWhite)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Top Section with Skip Button
                HStack {
                    Button(action: {
                        print("Skip pressed")
                    }) {
                        Text("SKIP")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .bold))
                    }
                    Spacer()
                    Button(action: {
                        print("Next pressed")
                    }) {
                        Image(systemName: "chevron.right") // Arrow icon
                            .foregroundColor(.black)
                            .font(.system(size: 20, weight: .bold))
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 40)
                
                Spacer()
                
                // Welcome Text
                Text("Welcome to Wakeb!")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                
                // Subtitle Text
                Text("Scan, edit, and enhance text seamlessly with Wakeb's smart features!")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 30)
                
                Spacer()
                
                // Page Control Dots
                HStack(spacing: 8) {
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 8, height: 8)
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 8, height: 8)
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 8, height: 8)
                }
                .padding(.bottom, 40)
             
            }
        }
    }
}
        #Preview {
            BoardingPage()
        }
