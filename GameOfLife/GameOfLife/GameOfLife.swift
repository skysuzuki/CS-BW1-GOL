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

    func toggleCellAt(indexPath: IndexPath) {
        let row = Int(indexPath.row / 25)
        let column = indexPath.row % 25
        grid[row][column] = 1
    }

    func play() {
        var future = Array(repeating: Array(repeating: 0, count: 25), count: 25)

        for r in 1..<(25 - 1) {
            for c in 1..<(25 - 1) {
                var aliveNeighbors = 0
                for i in -1...1 {
                    for j in -1...1 {
                        aliveNeighbors += self.grid[r + i][c + j]
                    }
                }

                aliveNeighbors -= self.grid[r][c]

                // Cell is alone and dies
                if self.grid[r][c] == 1 && aliveNeighbors < 2 {
                    future[r][c] = 0
                } else if grid[r][c] == 1 && aliveNeighbors > 3 {
                    // Cell dies due to over population
                    future[r][c] = 0
                } else if grid[r][c] == 0 && aliveNeighbors == 3 {
                    // A new cell is born
                    future[r][c] = 1
                } else {
                    // Stays the same
                    future[r][c] = self.grid[r][c]
                }
            }
        }

        NotificationCenter.default.post(name: Notification.Name("nextGeneration"), object: self, userInfo: ["future": future])
    }
}
