//
//  EmployeeRow.swift
//  Directory
//
//  Created by Amen George on 2024-04-12.
//


import SwiftUI

struct EmployeeRow: View {
    let employee: Employee
    @StateObject private var viewModel = EmployeeViewModel()

    var body: some View {
        HStack {
            if let image = viewModel.photoCache.object(forKey: employee.photo_url_large as NSString) {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            } else {
                AsyncImage(url: URL(string: employee.photo_url_large)!) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            }

            VStack(alignment: .leading) {
                Text(employee.full_name)
                    .font(.headline)
                Text(employee.team )
                    .font(.subheadline)
            }
        }
        .padding()
    }
}
