//
//  CrewView.swift
//  Moonshot
//
//  Created by Alex Nguyen on 2023-05-26.
//

import SwiftUI

struct CrewView: View {
    let crew: [MissionView.CrewMember]
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Crew")
                .font(.title.bold())
                .padding(.horizontal)
                .padding(.bottom, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(crew, id: \.role) { crewMember in
                        NavigationLink {
                            AstronautView(astronaut: crewMember.astronaut)
                        } label: {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 104, height: 72)
                                    .clipShape(Capsule())
                                    .overlay(
                                        Capsule()
                                            .strokeBorder(.white, lineWidth: 1)
                                    )
                                
                                VStack {
                                    Text(crewMember.astronaut.name)
                                        .foregroundColor(.white)
                                        .font(.headline)
                                    
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .accessibilityRemoveTraits(.isButton)
                    }
                }
            }
        }
    }
}

struct CrewView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static let crew = missions[0].crew.map { member in
        guard let astronaut = astronauts[member.name] else {
            fatalError("Missing \(member.name)")
        }
        
        return MissionView.CrewMember(role: member.role, astronaut: astronaut)
    }
        
    static var previews: some View {
        CrewView(crew: crew)
            .preferredColorScheme(.dark)
    }
}
