//
//  AboutViewController.swift
//  GameOfLife
//
//  Created by Lambda_School_Loaner_204 on 8/26/20.
//  Copyright © 2020 skysuzuki. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var rulesTextView: UITextView!
    @IBOutlet weak var aboutTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    private func updateViews() {
        rulesTextView.text = """
        For any live cell\n
        1. If it has fewer than two live neighbors dies, as if by underpopulation.\n
        2. If it has two or three live neighbors lives to next generation.\n
        3. If it has three or more live neighbors dies from overpopulation.\n\n
        For any dead cell\n
        1. If if has three live neighbors becomes alive from reproduction
        """

        aboutTextView.text = """
        The Game of Life, is a cellular automaton devised by the British mathematician John Horton Conway in 1970. It is a zero-player game, meaning that its evolution is determined by its initial state, requiring no further input. One interacts with the Game of Life by creating an initial configuration and observing how it evolves.
        """
    }

}
