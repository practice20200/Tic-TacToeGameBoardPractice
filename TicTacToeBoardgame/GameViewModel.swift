//
//  GameViewModel.swift
//  TicTacToeBoardgame
//
//  Created by Apple New on 2022-02-15.
//

import SwiftUI

final class GameViewModel: ObservableObject {

    let colums: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isGameboardDisabled: Bool = false
    @Published var alertItem: AlertItem?
    
    func processPlayerMove(for position: Int){
        
        //===========Human side=============
        //check if square is already occupied or not
        if isSquareOcupied(in: moves, for: position) { return }
        
        // initialize human move by that index
        moves[position] = Move(player: .human, boardIndex: position)
        
        //check wether human win
        if checkWinCondition(for: .human, in: moves){
            alertItem = AlertContext.humanWin
            print("You win!")
            return
        }
        
        // check whether the game ended in a draw
        if checkForDraw(in: moves){
            alertItem = AlertContext.draw
            print("Draw")
        }
        
        isGameboardDisabled = true
        
        //===========computer side=============
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            let computerPosition = determineComputerMovePosition(in: moves)
            moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
            
            isGameboardDisabled = false
            
            if checkWinCondition(for: .computer, in: moves){
                print("You lose")
                return
            }
            if checkForDraw(in: moves){
                print("Draw")
            }
        }
        
    }
    
    func resetGame(){
        moves = Array(repeating: nil, count: 9)
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
    
    func determineComputerMovePosition(in moves: [Move?]) -> Int{
        
        let winPattern: Set<Set<Int>> = [
            [0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]
        ]
        let computerMoves = moves.compactMap{$0}.filter {$0.player == .computer}
        let computerPositions = Set(computerMoves.map {$0.boardIndex})
        
        for pattern in winPattern{
            let winPositions = pattern.subtracting(computerPositions)
            if winPositions.count == 1 {
                let isAvailable = !isSquareOcupied(in: moves, for: winPositions.first!)
                if isAvailable { return winPositions.first! }
            }
        }
        
        let humanMoves = moves.compactMap{$0}.filter {$0.player == .human}
        let humanPositions = Set(humanMoves.map {$0.boardIndex})
        
        for pattern in winPattern{
            let winPositions = pattern.subtracting(humanPositions)
            if winPositions.count == 1 {
                let isAvailable = !isSquareOcupied(in: moves, for: winPositions.first!)
                if isAvailable { return winPositions.first!}
            }
        }
        
        let centerSquare = 4
        if isSquareOcupied(in: moves, for:  centerSquare){
            return centerSquare
        }
//
        var movePosition = Int.random(in: 0..<9)
        while isSquareOcupied(in: moves, for: movePosition){
            movePosition = Int.random(in: 0..<9)
        }
        return movePosition
    }
}
