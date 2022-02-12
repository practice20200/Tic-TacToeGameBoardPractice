//
//  ContentView.swift
//  TicTacToeBoardgame
//
//  Created by Apple New on 2022-02-11.
//

import SwiftUI

struct ContentView: View {
    
    let colums: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        VStack{
            
            Spacer()
            
            LazyVGrid(columns: colums){
                ForEach(0..<9) { i in
                    ZStack{
                        Circle()
                            .foregroundColor(.blue).opacity(0.5)
                            .frame(width: 80, height: 80)
                        Image(systemName: "circle")
                            .resizable()
                            .frame(width: 40, height: 40, alignment: .center)
                            .foregroundColor(.white)
                    }
                }
            }
            
            Spacer()
            
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
