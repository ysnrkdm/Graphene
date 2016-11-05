//
//  TreeSearchWithPerturbationThink.swift
//  Graphene
//
//  Created by KodamaYoshinori on 2016/10/31.
//
//

import Foundation

public class TreeSearchWithPerturbationThink : Think {
    var zones: Zones? = nil
    var pnsLessThan: Int = 0
    var searchDepth: Int = 1
    
    var wPossibleMoves: [Double] = [1.0]
    var wEdge: [Double] = [1.0]
    var wFixedPieces: [Double] = [1.0]
    var wOpenness: [Double] = [1.0]
    var wBoardEvaluation: [Double] = [1.0]
    
    var randomThreshold: Double = 0.1
    
    var evaluator = ClassicalEvaluator()
    var sst = NegaAlphaSearch()
    
    public init(zones: Zones, pnsLessThan: Int, searchDepth: Int, wPossibleMoves: [Double], wEdge: [Double], wFixedPieces: [Double], wOpenness: [Double], wBoardEvaluation: [Double], randomThreshold: Double) {
        self.zones = zones
        self.pnsLessThan = pnsLessThan
        self.searchDepth = searchDepth
        
        self.wPossibleMoves = wPossibleMoves
        self.wEdge = wEdge
        self.wFixedPieces = wFixedPieces
        self.wOpenness = wOpenness
        self.wBoardEvaluation = wBoardEvaluation
        
        self.randomThreshold = randomThreshold
        
        evaluator.configure(wPossibleMoves, wEdge: wEdge, wFixedPieces: wFixedPieces, wOpenness: wOpenness, wBoardEvaluation: wBoardEvaluation, zones: zones)
    }
    
    public func think(_ color: Pieces, board: BoardRepresentation, info: Info) -> Hand {
        var retx = 0
        var rety = 0
        
        let puttables = board.getPuttables(color)
        
        if board.getNumVacant() < pnsLessThan {
            let solver = SimpleProofSolver()
            let answer = solver.solve(board.clone(), forPlayer: color)
            NSLog("Solving by PNS search...")
            if ((answer.proof == .blackWin && color == .black) || (answer.proof == .whiteWin && color == .white)) && answer.moves.count > 0 {
                (retx, rety) = answer.moves[0]
                NSLog("Found PV! Answer is \(retx), \(rety)")
                return Hand(row: rety, col: retx, color: color)
            }
            NSLog("No PV found. Doing random.")
        }
        
        let ra: Double = Double(arc4random()) / Double(UINT32_MAX)
        if randomThreshold > ra {
            NSLog("Doing random play.")
            if puttables.count > 0 {
                if let uzones = zones {
                    let coords = uzones.getTopNByRandomInPuttables(1, puttables: puttables)
                    if coords.count > 0 {
                        (retx, rety) = coords[0]
                    }
                }
            }
        } else {
            if puttables.count > 0 {
                let res = sst.search(board.clone(), forPlayer: color, evaluator: evaluator, depth: searchDepth)
                NSLog("Searched -- " + res.toString())
                info.say(message: res.toShortString())
                let coords = res.pv
                if coords.count > 0 {
                    (retx, rety) = coords[0]
                }
            }
        }
        
        return Hand(row: rety, col: retx, color: color)
    }
}
