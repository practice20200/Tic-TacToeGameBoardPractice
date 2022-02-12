//
//  ContentView.swift
//  TicTacToeBoardgame
//
//  Created by Apple New on 2022-02-11.
//

import SwiftUI

struct ContentView: View {
    @State private var moves: [Move?] = Array(repeating: nil, count: 9)
    
    
    let colums: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                
                Spacer()
                
                LazyVGrid(columns: colums){
                    ForEach(0..<9) { i in
                        ZStack{
                            Circle()
                                .foregroundColor(.blue).opacity(0.5)
                                .frame(width: 80, height: 80)
                            Image(systemName: moves[i]?.indicator ?? "")
                                .resizable()
                                .frame(width: 40, height: 40, alignment: .center)
                                .foregroundColor(.white)
                        }.onTapGesture {
                            //===========Human side=============
                            //check if square is already occupied or not
                            if isSquareOcupied(in: moves, for: i){ return }
                            
                            // initialize human move by that index
                            moves[i] = Move(player: .human, boardIndex: i)
                            
                            //check wether human win
                            if checkWinCondition(for: .human, in: moves){
                                print("You win!")
                                return
                            }
                            
                            // check whether the game ended in a draw
                            if checkForDraw(in: moves){
                                print("Draw")
                            }
                            
                            //===========computer side=============
                            
                        }
                    }
                }
                
                Spacer()
                
            }
        }
        
        
    }
    
    func isSquareOcupied(in moves: [Move?], for index : Int ) -> Bool{
        return moves.contains(where: {$0?.boardIndex == index})
    }
    
    func checkWinCondition(for player: Player, in moves:[Move?]) -> Bool {
        let winPattern: Set<Set<Int>> = [
            [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]
        ]
        
        let playerMoves = moves.compactMap{$0}.filter {$0.player == player}
        let playerPositions = Set(playerMoves.map {$0.boardIndex})
        for pattern in winPattern where pattern.isSubset(of: playerPositions) {return true}
        return false
    }
    
    func checkForDraw(in moves: [Move?]) -> Bool{
        return moves.compactMap {$0}.count == 9
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


enum Player {
    case human, computer
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String{
        return player == .human ? "xmark" : "circle"
    }
}
