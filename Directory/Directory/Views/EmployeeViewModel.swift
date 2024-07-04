//
//  EmployeeViewModel.swift
//  Directory
//
//  Created by Amen George on 2024-04-12.
//

import SwiftUI
import Foundation

class EmployeeViewModel: ObservableObject {
    @Published var employees: [Employee] = []
    @Published var isLoading: Bool = false
    @Published var isError: Bool = false
    
    @AppStorage("hasOnboarded") var hasOnboarded: Bool = false
    
    let photoCache = NSCache<NSString, UIImage>()
    
    init() {
        fetchEmployees()
    }
    
    func fetchEmployees() {
        isLoading = true
        isError = false
        
        let url = URL(string: "https://s3.amazonaws.com/sq-mobile-interview/employees.json")!
        print("Fetching data from URL: \(url)")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            if let error = error {
                print("Error Fetching data: \(error.localizedDescription)")
                self.isError = true
                return
            }
            
            guard let data = data else {
                print("No data received")
                self.isError = true
                return
            }
            
            print("Received data: \(String(data: data, encoding: .utf8) ?? "Data could not be printed")")
            
            do {
                print("fetching data")
                let decodedData = try JSONDecoder().decode(EmployeeData.self, from: data)
                DispatchQueue.main.async {
                    self.employees = decodedData.employees
                    print("Fetched \(decodedData.employees.count) employees")
                }
            } catch {
                print("Error decoding data: \(error)")
                self.isError = true
            }
        }.resume()
    }
    
    func getEmployeePhoto(urlString: String, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = photoCache.object(forKey: urlString as NSString) {
            completion(cachedImage)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            self.photoCache.setObject(image, forKey: urlString as NSString)
            completion(image)
        }.resume()
    }
}
