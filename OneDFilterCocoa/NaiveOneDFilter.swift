//
//  NaiveOneDFilter.swift
//  OneDFilterCocoa
//
//  Created by Christian Riis on 09/05/2017.
//  Copyright © 2017 Christian Riis. All rights reserved.
//

import Foundation

// Pre- and append some zeroes to L to make it the correct length
func padL(count: Int, L: [Double]) -> [Double] {
    let zeroes = [Double](repeating: 0.0, count: count)
    return zeroes + L + zeroes
}

func naiveOneDFilter(R: Int, L: [Double], W: [Double]) -> [Double] {
    assert(2 * R + 1 == W.count, "W must be \(2 * R + 1) long")

    let zL = padL(count: R, L: L)

    var result: [Double] = []

    for i in R ..< zL.count - R {
        let slice = zL[i - R ... i + R]
        let dot = zip(slice, W).map { $0 * $1 }
        result.append(dot.reduce(0, +) / Double(W.count))
    }
    return result
}
