//
//  MissionView.swift
//  Moonshot
//
//  Created by Alex Nguyen on 2023-05-25.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
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
                        .padding(.top)
                    
                    Text(mission.formattedLaunchDate)
                        .font(.title2)
                        .padding([.leading, .trailing, .top])
                    
                    ZStack {
                        Divider()
                        
                        HStack {
                            Image(systemName: "moonphase.full.moon")
                            Spacer()
                            Image(systemName: "moonphase.waxing.gibbous")
                            Spacer()
                            Image(systemName: "moonphase.first.quarter")
                            Spacer()
                            Image(systemName: "moonphase.waxing.crescent")
                            Spacer()
                            Image(systemName: "moonphase.new.moon")
                        }
                        .imageScale(.small)
                        .accessibilityHidden(true)
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                        
//                        Rectangle()
//                            .frame(height: 2)
//                            .foregroundColor(.lightBackground)
//                            .padding(.vertical)
                    }
                    .padding(.horizontal)
                    
                    ZStack {
                        Divider()
                        
                        HStack {
                            Image(systemName: "moonphase.new.moon")
                            Spacer()
                            Image(systemName: "moonphase.waxing.crescent")
                            Spacer()
                            Image(systemName: "moonphase.first.quarter")
                            Spacer()
                            Image(systemName: "moonphase.waxing.gibbous")
                            Spacer()
                            Image(systemName: "moonphase.full.moon")
                        }
                        .imageScale(.small)
                        .accessibilityHidden(true)
                    }
                    .padding()
                    
                    CrewView(crew: crew)
                    
                    /*
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
                            }
                        }
                    }
                     */
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            guard let astronaut = astronauts[member.name] else {
                fatalError("Missing \(member.name)")
            }
            
            return CrewMember(role: member.role, astronaut: astronaut)
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[1], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
