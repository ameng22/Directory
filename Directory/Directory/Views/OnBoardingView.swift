//
//  OnBoardingView.swift
//  Directory
//
//  Created by Amen George on 2024-04-12.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasOnboarded") var hasOnboarded: Bool = false
    @State private var isActive: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.lightBlue]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Employees List")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                    
                    Image("logo")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .background(Circle().fill(Color.white).shadow(radius: 5))
                        .padding()
                    
                    Text("This is an employee directory app that shows a list of employees fetched from a directory with searchable capabilities")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                    
                    NavigationLink(destination: ContentView(), isActive: $isActive) {
                        Text("Continue")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.blue)
                            .cornerRadius(10)
                            .padding()
                    }
                    .isDetailLink(false)
                    .opacity(0) // Hidden, but still functional
                    
                    Button("Continue") {
                        hasOnboarded = true
                        UserDefaults.standard.set(true, forKey: "hasOnboarded")
                        isActive = true
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.blue)
                    .cornerRadius(10)
                    .padding()
                }
            }
        }
    }
}

extension Color {
    static let lightBlue = Color(hex: "#ADD8E6")
    
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0

        if scanner.scanHexInt64(&rgbValue) {
            let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
            let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
            let blue = Double(rgbValue & 0x0000FF) / 255.0
            self.init(red: red, green: green, blue: blue)
            return
        }
        self.init(red: 0, green: 0, blue: 0)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
