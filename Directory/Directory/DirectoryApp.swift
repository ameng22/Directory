//
//  DirectoryApp.swift
//  Directory
//
//  Created by Amen George on 2024-04-12.
//

import SwiftUI

@main
struct DirectoryApp: App {
    @State var hasOnboarded: Bool = UserDefaults.standard.bool(forKey: "hasOnboarded")

    var body: some Scene {
        WindowGroup {
            if hasOnboarded {
                ContentView()
                    .onChange(of: UIApplication.shared.applicationState) { _ in
                        if UIApplication.shared.applicationState == .active {
                            self.hasOnboarded = false
                            UserDefaults.standard.set(false, forKey: "hasOnboarded")
                        }
                    }
            } else {
                OnboardingView()
            }
        }
    }
}
