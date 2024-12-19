//
//  BoardingPage.swift
//  WakebApp
//
//  Created by Maram Rabeh  on 17/12/2024.
//

import SwiftUI

struct BoardingPage: View {
    init() {
        
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.greeen
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.lighttGray
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor(.offWhite))
                    .ignoresSafeArea()
                
                TabView {
                    
                    OnboardingPageView(
                        title: "Welcome to Wakeb!",
                        description: "Scan, edit, and enhance text seamlessly with Wakeb's smart features!",
                        imageName: "text.viewfinder",
                        
                        showStartButton: false,
                        showSkipButton: true
                    )
                    .tag(0)
                    
                    
                    OnboardingPageView(
                        title: "Scan and Upload Text",
                        description: "Easily scan documents using your camera or upload files from your device.",
                        imageName: "doc.viewfinder",
                        showStartButton: false,
                        showSkipButton: true
                    )
                    .tag(1)
                    
                    
                    OnboardingPageView(
                        
                        title: "Customize Your Reading Experience",
                        description: "Adjust fonts, spacing, and more for accessible and personalized reading experience.",
                        imageName: "slider.horizontal.3",
                        showStartButton: true,
                        showSkipButton: false
                        
                    )
                    .tag(2)
                    .padding(.top, 240)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            }
        }
             
    }
}
    
    struct OnboardingPageView: View {
        var title: String
        var description: String
        var imageName: String
        var showStartButton: Bool
        var showSkipButton: Bool
        
        var body: some View {
            
            VStack {
                ZStack {
                    HStack {
                        if showSkipButton {
                                Button(action: {
                                   
                                }) {
                                    NavigationLink(destination: HomePage()){
                                    Text("SKIP")
                                        .foregroundColor(.black)
                                        .font(.system(size: 16, weight: .bold))
                                }
                                Spacer()
                                
                                    .padding(.horizontal, 20)
                                    .padding(.top, 40)
                            }
                        }
                    }
                    
                }
                
                Spacer()
                
                
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.greeen)
                
                
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                
                Text(description)
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                    .padding(.top, 10)
                
                Spacer()
                
                if showStartButton {
                    Button(action: {
                      //  print("Start pressed")
                    }) {
                        NavigationLink(destination: HomePage()){
                            Text("START")
                                .foregroundColor(.greeen)
                                .font(.system(size: 20, weight: .bold))
                            // .padding()
                            
                        }
                    }
                    .padding(.bottom, 130)
                }
            }
        }
    }

        #Preview {
            BoardingPage()
}
