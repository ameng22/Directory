//
//  EmployeeListView.swift
//  Directory
//
//  Created by Amen George on 2024-04-12.
//

import SwiftUI

struct EmployeesListView: View {
    @ObservedObject var viewModel = EmployeeViewModel()
    @State private var searchText = ""
    
    var filteredEmployees: [Employee] {
        if searchText.isEmpty {
            return viewModel.employees
        } else {
            return viewModel.employees.filter {
                $0.full_name.localizedCaseInsensitiveContains(searchText) ||
                $0.team.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(filteredEmployees) { employee in
                        NavigationLink(destination: EmployeeDetailView(employee: employee)) {
                            EmployeeRow(employee: employee)
                        }
                    }
                    if !filteredEmployees.isEmpty {
                        Text(" \(filteredEmployees.count) Employees")
                            .font(.subheadline)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .background(Color(UIColor.systemBackground))
                            .foregroundColor(.gray)
                            .listRowInsets(EdgeInsets())
                    }else{
                        Text("Empty")
                    }
                }
                .navigationTitle("Employees")
                .searchable(text: $searchText)
            }
        }
        .onAppear {
            viewModel.fetchEmployees()
        }
    }
}
