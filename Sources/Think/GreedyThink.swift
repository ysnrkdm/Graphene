//
//  GreedyThink.swift
//  Graphene
//
//  Created by KodamaYoshinori on 2016/10/31.
//
//

import Foundation

public class GreedyThink: Think {
    public init() {}
    public func think(_ color: Pieces, board: BoardRepresentation, info: Info) -> Hand {
        var retx = 0
        var rety = 0
        let puttables = board.getPuttables(color)
        var maxNumReversibles = 0
        if puttables.count > 0 {
            for (px, py) in puttables {
                let reversible = board.getReversible(color, x: px, y: py)
                if maxNumReversibles < reversible.count {
                    (retx, rety) = (px, py)
                    maxNumReversibles = reversible.count
                }
            }
        }
        return Hand(row: rety, col: retx, color: color)
    }
}
