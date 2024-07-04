//
//  ContentView.swift
//  Directory
//
//  Created by Amen George on 2024-04-12.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            EmployeesListView(viewModel: EmployeeViewModel())
                .tabItem {
                    Label("Employees", systemImage: "person.3")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}
