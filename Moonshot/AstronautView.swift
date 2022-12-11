//
//  AstronautView.swift
//  Moonshot
//
//  Created by OAA on 21/11/2022.
//

import SwiftUI

struct AstronautView: View {
    
    
    let astronaut: Astronaut;
    
    
    var body: some View {
        ScrollView{
            VStack{
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                    
                // Image edge to edge, not text
                Text(astronaut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}






struct AstronautView_Previews: PreviewProvider {
    
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronaut.json")
    
    
    static var previews: some View {
        // Force unwrap! It's definitely safe.
        AstronautView(astronaut: astronauts["armstrong"]!)
    }
}
