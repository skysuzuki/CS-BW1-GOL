//
//  GameOfLife.swift
//  GameOfLife
//
//  Created by Lambda_School_Loaner_204 on 8/24/20.
//  Copyright © 2020 skysuzuki. All rights reserved.
//

import Foundation

class GameOfLife {

    private var grid = [[Int]]()

    init(_ row: Int, _ column: Int) {
        grid = Array(repeating: Array(repeating: 0, count: row), count: column)
    }

    func count() -> Int {
        return grid.count * grid.count
    }
}
