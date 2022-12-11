//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by OAA on 07/11/2022.
//

import Foundation

extension Bundle {
    
    // GENERIC (T is a placeholder meaning unknown type)
    // Instead of returning [String: Astronaut], we are returning just T
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf:url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        // When you see dates, check them in this exact format
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return loaded
    }
    
    // This bit of code above can be reused in many other projects as well!!
    // Also, Codable = Encodable + Decodable
    
    
}
