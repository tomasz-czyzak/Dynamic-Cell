//
//  String+Random.swift
//  Dynamic Cell
//
//  Created by Tomasz Czyzak on 20/10/2017.
//  Copyright © 2017 TC. All rights reserved.
//

import Foundation

extension String {

    fileprivate static let maxWords: UInt32 = 21 // 0..20
    fileprivate static let maxLettersInWord: UInt32 = 11 // 0..10
    fileprivate static let ascii_A: UInt32 = 97 // 'a' 
    fileprivate static let asciiRange: UInt32 = 26 // a..z

    static func generateRandomWords() -> String {
        let words = NSMutableString()
        for _ in 0..<Int(arc4random_uniform(maxWords)) {
            if words.length > 0 {
                words.append(" ")
            }
            for _ in 0..<Int(arc4random_uniform(maxLettersInWord)) {
                words.appendFormat("%C", (unichar)(ascii_A + arc4random_uniform(asciiRange)))
            }
        }
        return words as String
    }
    
}
