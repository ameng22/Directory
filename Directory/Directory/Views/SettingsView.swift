//
//  SettingsView.swift
//  Directory
//
//  Created by Amen George on 2024-04-13.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            
            Text("Employee List")
                .font(.largeTitle)
                .padding()
            Text("This is an employee directory app that shows a list of employees fetched from a directory with searchable capabalities")
                .font(.headline)
                .padding()

            Text("By: Amen George")
                .font(.headline)
                .padding()

            Text("ID: 1174137")
                .font(.subheadline)
                .padding()

            Spacer()
        }
        .navigationTitle("Settings")
    }
}
