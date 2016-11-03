//
//  EdaxProtocol.swift
//  FlatReversi
//
//  Created by KodamaYoshinori on 2016/10/16.
//  Copyright © 2016 Yoshinori Kodama. All rights reserved.
//

import Foundation

public func isMove(hand: String) -> Bool {
    return false
}

public func isPass(hand: String) -> Bool {
    return false
}

public enum Result {
    case Game(Board)
    case Quit
}

public func processSfen(sfen: String, think: Think, board: Board) -> Result {
    var commands = sfen.components(separatedBy: " ")
    switch commands[0] {
    case "init":
        var bb = SimpleBitBoard()
        bb.initialize(8, height: 8)
        return Result.Game(bb)
    case "quit":
        print("byebye!")
        return Result.Quit
    case "undo":
        print("Not yet implemented")
    case "redo":
        print("Not yet implemented")
    case "verbose":
        switch commands[1] {
        case "1":
            print(board.toString())
            break;
        case "0":
            break;
        case "p":
            // show fv
            break;
        default:
            print("")
        }
    case "go":
        break
    case let hand where isMove(hand: hand):
        break
    case let hand where isPass(hand: hand):
        break
    default:
        print("undefined command..")
    }
    
    return Result.Game(board)
}
