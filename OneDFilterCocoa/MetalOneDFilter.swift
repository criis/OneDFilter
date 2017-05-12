//
//  MetalOneDFilter.swift
//  OneDFilterCocoa
//
//  Created by Christian Riis on 09/05/2017.
//  Copyright © 2017 Christian Riis. All rights reserved.
//

import Foundation

import Accelerate

/*
 Unfortunately there is no MetalPerformanceShaders on MacOS so this uses
 Accelerate instead. :-/
 
 If L is [l1, l2, l3, l4, l5] and W is [w1, w2, w3] I do this matrix multiplication:
 [ 0  l1 l2 ]
 | l1 l2 l3 |   [ w1 ]
 | l2 l3 l4 | * | w2 |
 | l3 l4 l5 |   [ w3 ]
 [ l4 l5 0  ]
*/

func noMetalOneDFilter(R: Int, L: [Double], W: [Double]) -> [Double] {
    let D: Int = 2 * R + 1
    assert(D == W.count, "W must be \(2 * R + 1) long")
    let zL = padL(count: R, L: L)
    var L_as_matrix: [Double] = [] // Accelerate uses a flat representation of matrices.
    for i in 0 ... zL.count - D {
        L_as_matrix += zL[i ..< i + D]
    }
    var multiplied = [Double](repeating: 0.0, count: L.count)
    vDSP_mmulD(L_as_matrix, 1, W, 1, &multiplied, 1, vDSP_Length(L.count), 1, vDSP_Length(D))
    var otherD: Double = Double(D) // I don't get why scalar division wants this instead of just Double(D).
    var result = [Double](repeating: 0.0, count: L.count)
    vDSP_vsdivD(multiplied, 1, &otherD, &result, 1, vDSP_Length(L.count))
    return result
}
