//
//  Regex.swift
//  Graphite
//
//  Created by KodamaYoshinori on 2016/11/06.
//
//

import Foundation

class Regexp {
    let internalRegexp: NSRegularExpression
    let pattern: String
    
    init(_ pattern: String) {
        self.pattern = pattern
        self.internalRegexp = try! NSRegularExpression( pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
    }
    
    func isMatch(input: String) -> Bool {
        let matches = self.internalRegexp.matches(in: input, options: [], range:NSMakeRange(0, input.characters.count))
        return matches.count > 0
    }
    
    func matches(input: String) -> [String]? {
        if self.isMatch(input: input) {
            let nsString = input as NSString
            if let matches = self.internalRegexp.firstMatch(in: input, options: [], range: NSMakeRange(0, nsString.length)) {
                var results: [String] = []
                for i in 0 ..< matches.numberOfRanges {
                    results.append((input as NSString).substring(with: matches.rangeAt(i)))
                }
                return results
            }
        }
        return nil
    }
}
