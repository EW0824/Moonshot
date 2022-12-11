//
//  Color-Theme.swift
//  Moonshot
//
//  Created by OAA on 07/11/2022.
//

import Foundation
import SwiftUI

// Used very precisely/specifically where SwiftUI expects a shapestyle to be given
extension ShapeStyle where Self == Color {
    static var darkBackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }
    
    static var lightBackground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }
}
 

