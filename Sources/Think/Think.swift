//
//  Think.swift
//  FlatReversi
//
//  Created by KodamaYoshinori on 2016/10/16.
//  Copyright © 2016 Yoshinori Kodama. All rights reserved.
//

import Foundation

public struct Hand : Hashable, Equatable {
    public var row: Int
    public var col: Int
    public var color: Pieces
    
    public init(row: Int, col: Int, color: Pieces) {
        self.row = row
        self.col = col
        self.color = color
    }

    public var hashValue: Int {
        get {
            let hash = row + col * 10 + color.toInt() * 6
            return hash
        }
    }
    
    public static func ==(lhs: Hand, rhs: Hand) -> Bool {
        return lhs.row == rhs.row && lhs.col == rhs.col && lhs.color == rhs.color
    }
}

public protocol Think {
    func think(_ color: Pieces, board: BoardRepresentation, info: Info) -> Hand
}
