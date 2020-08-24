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

    var grid = [[Int]]()
    var column = 25
    var row = 25
    var count = 625

    override func viewDidLoad() {
        super.viewDidLoad()
        boardCollectionView.delegate = self
        boardCollectionView.dataSource = self
        initializeGrid(row: row, column: column)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    private func initializeGrid(row: Int, column: Int) {
        grid = Array(repeating: Array(repeating: 0, count: row), count: column)
    }

}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
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
//        let padding = sectionInsets.left * (25 + 1)
//        let width = 250 - padding
//        let widthPerItem = width / 25
        return CGSize(width: 10.0, height: 10.0)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CellCollectionViewCell else { return }
        cell.isAlive = true
        cell.backgroundColor = .black
    }
}
