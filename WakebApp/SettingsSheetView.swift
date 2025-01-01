//
//  SettingsSheetView.swift
//  WakebApp
//
//  Created by Diala Abdulnasser Fayoumi on 01/07/1446 AH.
//

import SwiftUI

struct SettingsSheetView: View {
    @Binding var fontSize: Double
    @Binding var wordSpacing: Double
    @Binding var lineSpacing: Double // Added binding for line spacing
    @Binding var pageBackgroundColor: Color
    @Binding var selectedFont: String
    
    let availableFonts = [
        "Arial",
        "Noto Sans Arabic",
        "Lexie Readable",
        "Maqroo-Regular",
        "OpenDyslexic"
    ]
    
    var body: some View {
        VStack {
            // Font Selection Section
            HStack {
                Text("Font type:")
                    .foregroundColor(Color.black)
                    .font(.body)
                    .padding(.trailing, 10)
                
                Menu {
                    ForEach(availableFonts, id: \.self) { font in
                        Button(action: {
                            selectedFont = font
                        }) {
                            Text(font)
                                .foregroundColor(.black)
                        }
                    }
                } label: {
                    HStack {
                        Text(" \(selectedFont)")
                            .foregroundColor(.black)
                        Image(systemName: "chevron.down")
                            .foregroundColor(.black)
                    }
                    .padding([.leading, .trailing])
                    .background(Color.white)
                    .cornerRadius(10)
                }
            }
            .padding()
            
            // Font Size Slider
            VStack {
                Text("Font Size: \(Int(fontSize))")
                    .foregroundColor(Color.black)
                    .padding(.bottom, 10)
                Slider(value: $fontSize, in: 14...24, step: 1)
                    .padding([.leading, .trailing])
                    .accentColor(Color("Sage"))
            }
            
            // Word Spacing Slider
            VStack {
                Text("Word Spacing: \(String(format: "%.2f", wordSpacing))")
                    .foregroundColor(Color.black)
                    .padding(.bottom, 10)
                Slider(value: $wordSpacing, in: 0...8, step: 0.1)
                    .padding([.leading, .trailing])
                    .accentColor(Color("Sage"))
            }
            
            // Line Spacing Slider
            VStack {
                Text("Line Spacing: \(String(format: "%.2f", lineSpacing))")
                    .foregroundColor(Color.black)
                    .padding(.bottom, 10)
                Slider(value: $lineSpacing, in: 0...20, step: 0.5)  // Adjust max value as needed
                    .padding([.leading, .trailing])
                    .accentColor(Color("Sage"))
            }
            
            // Page Background Color Picker
            VStack {
                Text("Background Color:")
                    .foregroundColor(Color.black)
                    .padding(.bottom, 10)
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 20) {
                    let backgroundColors: [Color] = [
                            Color("offwhite"),    // Default offwhite
                            Color("LightBrown"),  // Light brown
                            Color("yellowy"),     // Medium brown
                            Color("lightgray")    // Light gray
                        ]
                        let colorNames: [LocalizedStringKey] = [
                            "Original", "Calm", "Focus", "Paper"
                        ]
                    
                    ForEach(0..<backgroundColors.count, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(backgroundColors[index])
                            .frame(height: 70)
                            .overlay(
                                VStack {
                                    Text(colorNames[index])
                                        .font(.caption)
                                        .foregroundColor(Color.black)
                                        .padding(.top, 25)
                                    Spacer()
                                }
                            )
                            .padding(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 17)
                                    .stroke(pageBackgroundColor == backgroundColors[index] ? Color("Sage") : Color.white, lineWidth: 2)
                            )
                            .onTapGesture {
                                pageBackgroundColor = backgroundColors[index]
                            }
                    }
                }
                .padding([.leading, .trailing])
            }
        }
    }
}
