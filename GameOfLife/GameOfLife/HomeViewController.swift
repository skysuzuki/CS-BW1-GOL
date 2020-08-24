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

    let game = GameOfLife(25, 25)
    private var startGame = false
    let nextGenerationGroup = DispatchGroup()

    override func viewDidLoad() {
        super.viewDidLoad()
        boardCollectionView.delegate = self
        boardCollectionView.dataSource = self
        game.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func playButtonPressed(_ sender: Any) {
        startGame = true
        game.play()
        //playGame()
    }

    @IBAction func stopButtonPressed(_ sender: Any) {
        startGame = false
    }

    func playGame() {
        //self.game.play()
//        while startGame {
//            //self.nextGenerationGroup.enter()
//            sleep(5)
//            self.game.play()
//        }
    }
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return game.count()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CellCollectionViewCell else { return UICollectionViewCell() }

        cell.backgroundColor = .white
        cell.layer.borderWidth = 0.5
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 10.0, height: 10.0)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CellCollectionViewCell else { return }
        if cell.isAlive {
            cell.isAlive.toggle()
            cell.backgroundColor = .white
        } else {
            cell.isAlive = true
            game.toggleCellAt(indexPath: indexPath)
            cell.backgroundColor = .black
        }
    }
}

extension HomeViewController: GameOfLifeDelegate {
    func nextGeneration(indexPath: IndexPath, alive: Int) {
        guard let cell = boardCollectionView.cellForItem(at: indexPath) else { return }
        if alive == 1 {
            cell.backgroundColor = .black
        } else {
            cell.backgroundColor = .white
        }
    }
}
