//
//  MissionView.swift
//  Moonshot
//
//  Created by OAA on 21/11/2022.
//

import SwiftUI

// Wraps around the object astronaut because of the role
// Declaring this in public so both horizontal scroll view and mission view can access it.
struct CrewMember {
    let role: String
    let astronaut: Astronaut
}


struct HorizontalScrollView: View {
    
    let crew: [CrewMember]
    
    var body: some View {

        // Could add the text Crew and triangle here, but it's probably easier to keep the spacing consistent

        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink{
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(Capsule())
                                .overlay(
                                    // Small stroke, inside of the stroke (normal stroke is half inside half outside
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                )
                            
                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                
                                Text(crewMember.role)
                                    .foregroundColor(.secondary)
                                
                            }
                            
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        
    }
}






struct MissionView: View {
    
//    struct CrewMember {
//        let role: String
//        let astronaut: Astronaut
//    }
    
    let mission: Mission
    let crew: [CrewMember]
    
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding()
                    
                    Text(mission.formattedLaunchDate)
                        .font(.headline.italic())
                    
                    
                    VStack(alignment: .leading) {
                        
                        Rectangle()
                            .frame(height:2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)
                        
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        
                        Text(mission.description)
//                            .padding(.vertical)
                        
                        Rectangle()
                            .frame(height:2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)

                        // Kept in here (although its logically next to the scrollview, to keep padding consistent and aligned.
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        

                    }
                    // stay away from border of screen
                    .padding(.horizontal)
                    
                    // Scrollview is outside of the VStack because it works better being edge to edge
                    HorizontalScrollView(crew: crew)
                        .padding(.vertical)
                    
                }
                .padding(.bottom)
            }
            
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    // Custom Initializer
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            // If we are able to find person's name in astranut dictionary
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
                    
        }
    }
    
}








struct MissionView_Previews: PreviewProvider {
    
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[3], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
