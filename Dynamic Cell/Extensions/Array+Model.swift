//
//  Array+Model.swift
//  Dynamic Cell
//
//  Created by Tomasz Czyzak on 20/10/2017.
//  Copyright © 2017 TC. All rights reserved.
//

import Foundation

extension Array where Element == String {
    
    fileprivate static let maxRows = 10

    static func buildModelWith(elements: Int) -> [String] {
        var model = [String]()
        for _ in 0..<elements {
            model.append(String.generateRandomWords())
        }
        return model
    }
}
