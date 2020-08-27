//
//  HomeViewController.swift
//  GameOfLife
//
//  Created by Lambda_School_Loaner_204 on 8/20/20.
//  Copyright © 2020 skysuzuki. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var boardCollectionView: UICollectionView!
    @IBOutlet weak var boardView: UIView!
    @IBOutlet weak var generationsLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!

    let game = GameOfLife(25, 25)
    private let cellSize = 14.0

    override func viewDidLoad() {
        super.viewDidLoad()
        boardCollectionView.delegate = self
        boardCollectionView.dataSource = self
        boardView.layer.borderWidth = 1.0
        game.delegate = self
    }

    private func updateViews() {
        if game.isRunning {
            playButton.setTitle("Pause", for: .normal)
        } else {
            playButton.setTitle("Play", for: .normal)
        }
    }

    @IBAction func playButtonPressed(_ sender: Any) {
        if game.isRunning { game.stop() }
        else { game.start() }
        updateViews()
    }

    @IBAction func resetButtonPressed(_ sender: Any) {
        game.reset()
        updateViews()
    }

    @IBAction func preset1ButtonPressed(_ sender: Any) {
        game.preset1()
        updateViews()
    }

}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return game.count()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CellCollectionViewCell else { return UICollectionViewCell() }

        cell.isAlive = false
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellSize, height: cellSize)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CellCollectionViewCell else { return }

        game.toggleCellAt(index: indexPath.row, isAlive: cell.isAlive)
        cell.isAlive.toggle()
    }
}

extension HomeViewController: GameOfLifeDelegate {
    func generationDidFinish(count: Int) {
        generationsLabel.text = "Generations: \(count)"
    }

    func foundNoNewGenerations(generations: Int, title: String) {
        game.stop()
        let alert = UIAlertController(title: title, message: "Total generations: \(generations)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel) { _ in
            self.game.reset()
            self.updateViews()
        })

        present(alert, animated: true, completion: nil)
    }

    func nextGeneration(indexPath: IndexPath, isAlive: Int) {
        guard let cell = boardCollectionView.cellForItem(at: indexPath) as? CellCollectionViewCell else { return }

        cell.isAlive = Bool(truncating: isAlive as NSNumber)
    }
}
