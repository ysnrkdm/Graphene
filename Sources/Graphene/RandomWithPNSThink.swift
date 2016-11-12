//
//  RandomWithPNSThink.swift
//  Graphene
//
//  Created by KodamaYoshinori on 2016/10/31.
//
//

import Foundation

open class RandomWithPNSThink : Think {
    var zones: Zones? = nil
    var pnsLessThan: Int = 0
    
    public init(zones: Zones, pnsLessThan: Int) {
        self.zones = zones
        self.pnsLessThan = pnsLessThan
    }

    public func think(_ color: Pieces, board: BoardRepresentation, info: Info) -> Hand {
        let puttables = board.getPuttables(color)
        var retx = 0
        var rety = 0
        
        if board.getNumVacant() < pnsLessThan {
            let solver = SimpleProofSolver()
            let answer = solver.solve(board.clone(), forPlayer: color)
            info.say(message: "Solving by PNS search...")
            if ((answer.proof == .blackWin && color == .black) || (answer.proof == .whiteWin && color == .white)) && answer.moves.count > 0 {
                (retx, rety) = answer.moves[0]
                info.say(message: "Found PV! Answer is \(retx), \(rety)")
                return Hand(row: rety, col: retx, color: color)
            }
        }
        
        info.say(message: "No PV found. Doing random.")
        if puttables.count > 0 {
            if let uzones = zones {
                let coords = uzones.getTopNByRandomInPuttables(1, puttables: puttables)
                if coords.count > 0 {
                    (retx, rety) = coords[0]
                }
            }
        }
        
        return Hand(row: rety, col: retx, color: color)
    }
}
