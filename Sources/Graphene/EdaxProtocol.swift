//
//  EdaxProtocol.swift
//  FlatReversi
//
//  Created by KodamaYoshinori on 2016/10/16.
//  Copyright © 2016 Yoshinori Kodama. All rights reserved.
//

import Foundation

public func handFromEdaxStr(edaxStr: String) -> Move {
    let pattern = "^([a-hA-H][1-8]|PS)$"
    if let matches = Regexp(pattern).matches(input: edaxStr) {
        if matches.count == 2 {
            let hand = matches[1]
            if hand.uppercased() == "PS" {
                return .Pass
            } else {
                return handFromStr(str: hand)
            }
        }
    }
    return .Invalid
}

public func handFromStr(str: String) -> Move {
    let b = str.uppercased()
    if let first = b.characters.first, let last = b.characters.last {
        var row = -1;
        var col = -1;
        switch first {
        case "A":
            col = 0
        case "B":
            col = 1
        case "C":
            col = 2
        case "D":
            col = 3
        case "E":
            col = 4
        case "F":
            col = 5
        case "G":
            col = 6
        case "H":
            col = 7
        default:
            break
        }
        switch last {
        case "1":
            row = 0
        case "2":
            row = 1
        case "3":
            row = 2
        case "4":
            row = 3
        case "5":
            row = 4
        case "6":
            row = 5
        case "7":
            row = 6
        case "8":
            row = 7
        default:
            break
        }
        return .Move(col, row)
    }
    return .Invalid
}

public enum Move {
    case Move(Int, Int)     // col, row
    case Pass
    case Invalid
}

public enum Result {
    case Game(Board)
    case Moved(Board)
    case Quit
}

public func processSfen(sfen: String, think: Think, board: Board, color: Pieces, info: Info) -> Result {
    var commands = sfen.components(separatedBy: " ")
    //    print(commands)
    switch commands[0] {
    case "init":
        let bb = SimpleBitBoard()
        bb.initialize(8, height: 8)
        return .Game(bb)
    case "quit":
        print("byebye!")
        return .Quit
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
            // TODO: show fv
            break;
        default:
            print("")
        }
    case "go":
        let boardRep = BoardBuilder.build(board)
        let hand = think.think(color, board: boardRep, info: info)
        if board.canPut(color, x: hand.col, y: hand.row) {
            _ = board.put(color, x: hand.col, y: hand.row, guides: false, returnChanges: false)
            return .Moved(board)
        } else {
            // Treat invalid put by think as pass
            return .Moved(board)
        }
    default:
        switch handFromEdaxStr(edaxStr: sfen) {
        case let .Move(col, row):
            if board.canPut(color, x: col, y: row) {
                _ = board.put(color, x: col, y: row, guides: false, returnChanges: false)
                return .Moved(board)
            } else {
                return .Game(board)
            }
        case .Pass:
            return .Moved(board)
        case .Invalid:
            print("undefined command..")
        }
    }
    
    return .Game(board)
}
