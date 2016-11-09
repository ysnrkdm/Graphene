//
//  Info.swift
//  FlatReversi
//
//  Created by KodamaYoshinori on 2016/10/16.
//  Copyright © 2016 Yoshinori Kodama. All rights reserved.
//

import Foundation

public protocol Info {
    func say(message: String)
}

func LOG(body: String!, function: String = #function, line: Int = #line) {
    let datestr = String(NSDate().description);
    print("[\(datestr) : \(function) @ \(line)] \(body)")
}

open class SimpleLogInfo : Info {
    public init(){}
    open func say(message: String) {
        LOG(body: message)
    }
}

open class NullInfo : Info {
    public init(){}
    open func say(message: String) {
        // Do nothing
    }
}
