//
//  CellCollectionViewCell.swift
//  GameOfLife
//
//  Created by Lambda_School_Loaner_204 on 8/21/20.
//  Copyright © 2020 skysuzuki. All rights reserved.
//

import UIKit

class CellCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var icon: UILabel!
    
    var isAlive = false {
        didSet {
            if isAlive { self.icon.text = "🦠"/*self.backgroundColor = .black*/ }
            else { self.icon.text = "☠️"/*self.backgroundColor = .white*/ }
        }
    }

    
}
