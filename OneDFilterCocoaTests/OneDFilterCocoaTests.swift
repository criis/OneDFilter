//
//  OneDFilterCocoaTests.swift
//  OneDFilterCocoaTests
//
//  Created by Christian Riis on 09/05/2017.
//  Copyright © 2017 Christian Riis. All rights reserved.
//

import XCTest
@testable import OneDFilterCocoa

let bigL: [Double] = (1 ... 100000).map { _ in drand48() * 23 }
let bigR: Int = 8
let bigW: [Double] = (0 ..< 2 * bigR + 1).map { _ in drand48() * 50 }


class OneDFilterCocoaTests: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func closeEnough(have: [Double], want: [Double]) -> Bool {
        let small = Double(pow(10.0, -10.0))
        for (x, y)  in zip(have, want) {
            if fabs(x - y) >= small {
                dump(have)
                dump(want)
                return false
            }
        }
        return true
    }
    
    func testExample() {
        let have = naiveOneDFilter(R: 1, L: [2.0, 3.0, 4.0, 3.0, 2.0], W: [1.0, 2.0, 1.0])
        let want = [7 / Double(3), 4, 14 / Double(3), 4.0, 7 / Double(3)]
        XCTAssert(closeEnough(have: have, want: want))
        let have2 = noMetalOneDFilter(R: 1, L: [2.0, 3.0, 4.0, 3.0, 2.0], W: [1.0, 2.0, 1.0])
        XCTAssert(closeEnough(have: have2, want: want))
    }
    
    func testExample2() {
        let have = naiveOneDFilter(R: 1, L: [2.0, 2.0, 2.0, 2.0, 2.0], W: [1.0, 1.0, 1.0])
        let want = [4 / Double(3), 2, 2, 2, 4 / Double(3)]
        XCTAssert(closeEnough(have: have, want: want))
        let have2 = noMetalOneDFilter(R: 1, L: [2.0, 2.0, 2.0, 2.0, 2.0], W: [1.0, 1.0, 1.0])
        XCTAssert(closeEnough(have: have2, want: want))

    }
    
    func testExample3() {
        let have = naiveOneDFilter(R: 2, L: [2.0, 2.0, 2.0, 2.0, 2.0], W: [1.0, 1.0, 1.0, 1.0, 1.0])
        let want = [6 / Double(5), 8 / Double(5), 2, 8 / Double(5), 6 / Double(5)]
        XCTAssert(closeEnough(have: have, want: want))
        let have2 = noMetalOneDFilter(R: 2, L: [2.0, 2.0, 2.0, 2.0, 2.0], W: [1.0, 1.0, 1.0, 1.0, 1.0])
        XCTAssert(closeEnough(have: have2, want: want))

    }
    
    func testPerformanceNaive() {

        self.measure {
            
            naiveOneDFilter(R: bigR, L: bigL, W: bigW)
        }
    }
    
    func testPerformanceAccelerate() {
        self.measure {
            noMetalOneDFilter(R: bigR, L: bigL, W: bigW)
        }
    }
}
