//
//  RandomWithWeightsThink.swift
//  FlatReversi
//
//  Created by KodamaYoshinori on 2016/10/16.
//  Copyright © 2016 Yoshinori Kodama. All rights reserved.
//

import Foundation

open class RandomWithWeightsThink : Think {
    var zones: Zones
    
    public init(zones: Zones) {
        self.zones = zones
    }
    
    public func think(_ color: Pieces, board: BoardRepresentation, info: Info) -> Hand {
        var retx = 0
        var rety = 0
        
        let puttables = board.getPuttables(color)
        if puttables.count > 0 {
            let uzones = self.zones
            info.say(message: "\n" + uzones.toString())
            let coords = uzones.getTopNByRandomInPuttables(1, puttables: puttables)
            if coords.count > 0 {
                (retx, rety) = coords[0]
            }
        }
        
        return Hand(row: rety, col: retx, color: color)
    }
}
