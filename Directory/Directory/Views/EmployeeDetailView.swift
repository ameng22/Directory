//
//  EmployeeDetailView.swift
//  Directory
//
//  Created by Amen George on 2024-04-12.
//

import SwiftUI

struct EmployeeDetailView: View {
    let employee: Employee
    @StateObject private var viewModel = EmployeeViewModel()
    
    var employeeType: String {
        switch employee.employee_type {
        case "FULL_TIME":
            return "Full time"
        case "PART_TIME":
            return "Part time"
        case "CONTRACTOR":
            return "Contractor"
        case "UNKNOWN":
            return "Unknown"
        default:
            return "Unknown"
        }
    }
        
    @State private var employeeImage: UIImage? = nil
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10) {
                if let image = viewModel.photoCache.object(forKey: employee.photo_url_large as NSString) {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 300, height: 300)
                        .clipShape(Circle())
                } else {
                    AsyncImage(url: URL(string: employee.photo_url_large)!) { image in
                        image.resizable()
                    } placeholder: {
                        if viewModel.isLoading {
                            ProgressView()
                        } else {
                            Image(systemName: "person.fill")
                                .resizable()
                                .frame(width: 300, height: 300)
                                .clipShape(Circle())
                        }
                    }
                    .frame(width: 300, height: 300)
                    .clipShape(Circle())
                    .onAppear {
                        viewModel.getEmployeePhoto(urlString: employee.photo_url_large) { image in
                            self.employeeImage = image
                        }
                    }
                }

                DetailRow(title: "Name", value: employee.full_name)
                DetailRow(title: "Email", value: employee.email_address)
                DetailRow(title: "Phone", value: employee.phone_number ?? "")
                DetailRow(title: "Biography", value: employee.biography)
                DetailRow(title: "Team", value: employee.team )
                DetailRow(title: "Type", value: employeeType)
            }
            .padding()
        }
    }
}

struct DetailRow: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(title) :")
                    .fontWeight(.semibold)
                    .frame(width: 120, alignment: .leading) // Fixed width for title
                Text(value)
                    .multilineTextAlignment(.leading)
            }
            .padding(.vertical, 5)
            
            Divider()
        }
    }
}
