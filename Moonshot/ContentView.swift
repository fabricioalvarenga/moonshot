//
//  ContentView.swift
//  Moonshot
//
//  Created by FABRICIO ALVARENGA on 01/08/22.
//

import SwiftUI

struct ViewAsGrid: View {
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                MainView()
            }
            .padding([.horizontal, .bottom])
        }
    }
}

struct ViewAsList: View {
    var body: some View {
        List {
            Group {
                MainView()
            }
            .listRowBackground(Color.clear)
        }
        .onAppear {
            // Set the default to clear
            UITableView.appearance().backgroundColor = .clear
        }
    }
}

struct MainView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    var body: some View {
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
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.lightBackground)
                )
            }
        }
    }
}

struct ContentView: View {
    @State private var showingAsGrid = true
    
    var body: some View {
        NavigationView {
            if (showingAsGrid) {
                ViewAsGrid()
                    .navigationTitle("Moonshot")
                    .background(.darkBackground)
                    .preferredColorScheme(.dark)
                    .toolbar {
                        ToolbarItemGroup {
                            Button(showingAsGrid ? "View as list" : "View as grid") {
                                showingAsGrid.toggle()
                            }
                        }
                    }
            } else {
                ViewAsList()
                    .navigationTitle("Moonshot")
                    .background(.darkBackground)
                    .preferredColorScheme(.dark)
                    .toolbar {
                        ToolbarItemGroup {
                            Button(showingAsGrid ? "View as list" : "View as grid") {
                                showingAsGrid.toggle()
                            }
                        }
                    }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

