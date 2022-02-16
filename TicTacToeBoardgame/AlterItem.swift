//
//  AlterItem.swift
//  TicTacToeBoardgame
//
//  Created by Apple New on 2022-02-15.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertContext {
    static let humanWin = AlertItem(title: Text("You win!"),
                                    message: Text("You crashed it!."),
                                    buttonTitle: Text("Thanks"))
    static let computerWin = AlertItem(title: Text("You Lost"),
                                       message: Text("Try Again."),
                                       buttonTitle: Text("Let me try it again"))
    static let draw = AlertItem(title: Text("Draw"),
                                message: Text("It was close."),
                                buttonTitle: Text("Try Again"))
}
