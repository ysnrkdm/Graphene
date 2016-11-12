//
//  EdaxProtocol.swift
//  FlatReversi
//
//  Created by KodamaYoshinori on 2016/10/16.
//  Copyright © 2016 Yoshinori Kodama. All rights reserved.
//

import Foundation

public func handFromEdaxStr(edaxStr: String) -> Move {
    if edaxStr.uppercased() == "PS" {
        return .Pass
    } else {
        return moveFromStr(str: edaxStr)
    }
}

public func moveFromStr(str: String) -> Move {
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
        if (row == -1 || col == -1) {
            return .Invalid
        } else {
            return .Move(col, row)
        }
    }
    return .Invalid
}

public func strFromMove(move: Move) -> String {
    switch move {
    case let .Move(col, row):
        var first = ""
        switch col {
        case 0:
            first = "A"
        case 1:
            first = "B"
        case 2:
            first = "C"
        case 3:
            first = "D"
        case 4:
            first = "E"
        case 5:
            first = "F"
        case 6:
            first = "G"
        case 7:
            first = "H"
        default:
            first = "X"
        }
        let last = String.init(row + 1)
        return first + last
    case .Pass:
        return "PS"
    case .Invalid:
        return "Invalid"
    }
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

public func processSfen(playerName: String, sfen: String, think: Think, board: Board, color: Pieces, info: Info) -> Result {
    var commands = sfen.components(separatedBy: " ")
    //    print(commands)
    switch commands[0] {
    case "init":
        let bb = SimpleBitBoard()
        bb.initialize(8, height: 8)
        print("")
        return .Game(bb)
    case "quit":
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
        print("")
        print("")
        let boardRep = BoardBuilder.build(board)
        if (boardRep.isAnyPuttable(color)) {
            let hand = think.think(color, board: boardRep, info: info)
            if board.canPut(color, x: hand.col, y: hand.row) {
                _ = board.put(color, x: hand.col, y: hand.row, guides: false, returnChanges: false)
                let handStr = strFromMove(move: .Move(hand.col, hand.row))
                print(">\(playerName) plays \(handStr)")
                return .Moved(board)
            } else {
                // Treat invalid put by think as pass
                print(">\(playerName) plays PS")
                return .Moved(board)
            }
        } else {
            // Treat invalid put by think as pass
            print(">\(playerName) plays PS")
            return .Moved(board)
        }
    default:
        print("\n")
        switch handFromEdaxStr(edaxStr: sfen) {
        case let .Move(col, row):
            if board.canPut(color, x: col, y: row) {
                _ = board.put(color, x: col, y: row, guides: false, returnChanges: false)
                print("You play \(sfen)")
                return .Moved(board)
            } else {
                return .Game(board)
            }
        case .Pass:
            print("You play \(sfen)")
            return .Moved(board)
        case .Invalid:
            print("undefined command..")
        }
    }
    
    return .Game(board)
}
