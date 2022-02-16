//
//  SettingView.swift
//  TicTacToeBoardgame
//
//  Created by Apple New on 2022-02-15.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        
        List{
            Section{
                SettingItemView(title: "Level")
                SettingItemView(title: "Model")
            }
            
            Section{
                SettingItemView(title: "Language")
                SettingItemView(title: "FAQ")
                SettingItemView(title: "About us")
            }
        }
    }
}

struct SettingItemView: View{
    var title: String
    var body: some View {
        NavigationLink{
            Text("title")
                
        } label: {
            Text(title)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
