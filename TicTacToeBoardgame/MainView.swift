//
//  MainView.swift
//  TicTacToeBoardgame
//
//  Created by Apple New on 2022-02-15.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView{
            TabView{
                ContentView()
                    .tabItem{
                        Label("Board", systemImage: "checkerboard.rectangle")
                    }
                    
                SettingView()
                    .tabItem{
                        Label("Board", systemImage: "gear")
                    }
                
                
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
