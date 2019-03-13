//
//  SecondViewController.swift
//  Lekcija3
//
//  Created by Students on 13/03/2019.
//  Copyright © 2019 students. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var ml: UILabel!
    
    var mansTextsNoMainVC = "Nav teksta"
    override func viewDidLoad() {
        super.viewDidLoad()
        ml.text = mansTextsNoMainVC

    }


}
