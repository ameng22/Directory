//
//  DirectoryApp.swift
//  Directory
//
//  Created by Amen George on 2024-04-12.
//

import Foundation

struct EmployeeData: Decodable {
    let employees: [Employee]
}

struct Employee: Identifiable, Decodable {
    
    let id: String
    let full_name: String
    let phone_number: String?
    let email_address: String
    let biography: String
    let photo_url_small: String
    let photo_url_large: String
    let team: String
    let employee_type: String

    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case full_name
        case phone_number
        case email_address
        case biography
        case photo_url_small
        case photo_url_large
        case team
        case employee_type
    }
}
