//
//  GameOfLife.swift
//  GameOfLife
//
//  Created by Lambda_School_Loaner_204 on 8/24/20.
//  Copyright © 2020 skysuzuki. All rights reserved.
//

import Foundation
import UIKit

protocol GameOfLifeDelegate: AnyObject {
    func nextGeneration(indexPath: IndexPath, isAlive: Int)
    func generationDidFinish(count: Int)
    func foundNoNewGenerations(generations: Int, title: String)
}

class GameOfLife {

    weak var delegate: GameOfLifeDelegate?
    private var gameTimer: Timer?
    private var generations = 0
    private let preset1Arr = [411, 386, 388, 413, 362, 337, 312, 287, 311, 335, 309,
                              313, 339, 365, 261, 236, 211, 212, 213, 238, 263]

    private var grid = [[Int]]()
    private var row = 0
    private var column = 0
    var isRunning = false

    init(_ row: Int, _ column: Int) {
        self.row = row
        self.column = column
        grid = Array(repeating: Array(repeating: 0, count: row), count: column)
    }

    // MARK: Helper functions

    func count() -> Int {
        return grid.count * grid.count
    }

    func toggleCellAt(index: Int, isAlive: Bool) {
        let row = Int(index / self.row)
        let column = index % self.column
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

    func reset() {
        stop()
        self.grid = Array(repeating: Array(repeating: 0, count: self.row), count: self.column)
        generations = 0
        buildNextGeneration(future: self.grid)
    }

    func preset1() {
        if isRunning {
            reset()
        }
        for num in preset1Arr {
            toggleCellAt(index: num, isAlive: false)
            delegate?.nextGeneration(indexPath: [0, num], isAlive: 1)
        }
    }

    // MARK: Private functions

    private func play() {
        var future = Array(repeating: Array(repeating: 0, count: self.row), count: self.column)

        for r in 1..<(self.row - 1) {
            for c in 1..<(self.column - 1) {
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

        if future == Array(repeating: Array(repeating: 0, count: self.row), count: self.column) {
            delegate?.foundNoNewGenerations(generations: generations, title: "Population has died out")
        } else if future == self.grid {
            delegate?.foundNoNewGenerations(generations: generations, title: "No new generations can be formed")
        } else {
            self.grid = future
            generations += 1
        }
        buildNextGeneration(future: future)
    }

    private func buildNextGeneration(future: [[Int]]) {
        for r in 0..<25 {
            for c in 0..<25 {
                let indexPath = IndexPath(row: (r * self.row) + (c % self.column), section: 0)
                delegate?.nextGeneration(indexPath: indexPath, isAlive: future[r][c])
            }
        }
        delegate?.generationDidFinish(count: generations)
    }

    private func playGame() {
        gameTimer?.invalidate()
        gameTimer = nil
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                self.play()
            }
        }
}

