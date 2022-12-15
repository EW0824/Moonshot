//
//  ContentView.swift
//  Moonshot
//
//  Created by OAA on 19/10/2022.
//

import SwiftUI



struct GridLayout: View {
    
    // Just declaring the type is sufficient
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    let columns: [GridItem]
    
    
    var body: some View {
        
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.lightBackground)
                    )
                    // Overlay is responsible for adding borders!
                    
                }
            }
            .padding([.horizontal, .bottom])
        }
//        .navigationTitle("Moonshot")
        .background(.darkBackground)
        .preferredColorScheme(.dark)

    }
}


struct ListLayout: View {
    
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    let columns: [GridItem]
    
    
    var body: some View {
        
            
        List {
            
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    HStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width:75, height:75)
//                            .padding()
                        
                        VStack(alignment: .trailing){
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.5))

                            
                        }
                        .frame(maxWidth: 200, alignment: .trailing)

                    }

                }
                .listRowBackground(Color.lightBackground)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(.lightBackground))
                
            }
            
        }
        .listStyle(.plain)
        .padding(.horizontal)
//        .clipShape(RoundedRectangle(cornerRadius:10))
//        .overlay(RoundedRectangle(cornerRadius: 10)
//            .stroke(.lightBackground))
        .background(Color.darkBackground)
        .preferredColorScheme(.dark)

    
    }
    
}




struct ContentView: View {
    
    // Specify type of variable. Otherwise it cannot infer from T.
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    // We can then apply it to decode Mission easily
    let missions: [Mission] = Bundle.main.decode("missions.json")

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    @State private var showingGrid = true
    
    
    
    var body: some View {
        NavigationView {
            
            Group {
                if showingGrid {
                    GridLayout(astronauts: astronauts, missions: missions, columns: columns)
                } else {
                    ListLayout(astronauts: astronauts, missions: missions, columns: columns)
                }
            }
            .navigationTitle("Moonshot")
            .toolbar {
                Button((showingGrid) ? "List View" : "Grid View") {
                    showingGrid.toggle()
                }
            }
        
        }
//        .background(.darkBackground)
    }

}
    





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
