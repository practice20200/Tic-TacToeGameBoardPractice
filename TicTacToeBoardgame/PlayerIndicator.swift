//
//  PlayerIndicator.swift
//  TicTacToeBoardgame
//
//  Created by Apple New on 2022-02-15.
//

import SwiftUI


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
