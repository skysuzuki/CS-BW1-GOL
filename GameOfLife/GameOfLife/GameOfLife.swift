//
//  GameOfLife.swift
//  GameOfLife
//
//  Created by Lambda_School_Loaner_204 on 8/24/20.
//  Copyright © 2020 skysuzuki. All rights reserved.
//

import Foundation

protocol GameOfLifeDelegate: AnyObject {
    func nextGeneration(indexPath: IndexPath, isAlive: Int)
}

class GameOfLife {

    weak var delegate: GameOfLifeDelegate?
    var gameTimer: Timer?

    private var grid = [[Int]]()
    var isRunning = false

    init(_ row: Int, _ column: Int) {
        grid = Array(repeating: Array(repeating: 0, count: row), count: column)
    }

    func count() -> Int {
        return grid.count * grid.count
    }

    func toggleCellAt(indexPath: IndexPath, isAlive: Bool) {
        let row = Int(indexPath.row / 25)
        let column = indexPath.row % 25
        if isAlive { grid[row][column] = 0 } else {
            grid[row][column] = 1
        }
    }

    // MARK: Game functions

    func start() {
        isRunning = true
        playGame()
    }

    func stop() {
        gameTimer?.invalidate()
        gameTimer = nil
        isRunning = false
    }

    // MARK: Private functions

    private func play(completion: @escaping ([[Int]]) -> Void) {
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

        self.grid = future

        completion(future)
    }

    private func buildNextGeneration(future: [[Int]]) {
        for r in 0..<25 {
            for c in 0..<25 {
                let indexPath = IndexPath(row: (r * 25) + (c % 25), section: 0)
                delegate?.nextGeneration(indexPath: indexPath, isAlive: future[r][c])
            }
        }
    }

    private func playGame() {
        gameTimer?.invalidate()
        gameTimer = nil
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.play { (future) in
                self.buildNextGeneration(future: future)
            }
        }
    }
}
