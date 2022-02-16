//
//  ContentView.swift
//  TicTacToeBoardgame
//
//  Created by Apple New on 2022-02-11.
//

import SwiftUI

struct ContentView: View {
   @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                
                Spacer()
                
                LazyVGrid(columns: viewModel.colums){
                    ForEach(0..<9) { i in
                        ZStack{
                            Circle()
                                .foregroundColor(.blue).opacity(0.5)
                                .frame(width: 80, height: 80)
                            Image(systemName: viewModel.moves[i]?.indicator ?? "")
                                .resizable()
                                .frame(width: 40, height: 40, alignment: .center)
                                .foregroundColor(.white)
                        }.onTapGesture {
                            viewModel.processPlayerMove(for: i)
                        }
                    }
                }
                
                Spacer()
                
            }.disabled(viewModel.isGameboardDisabled)
                .alert(item: $viewModel.alertItem) { alertItem in
                    Alert(title: alertItem.title,
                                message: alertItem.message,
                                dismissButton: .default(alertItem.buttonTitle, action: viewModel.resetGame))
                }
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


