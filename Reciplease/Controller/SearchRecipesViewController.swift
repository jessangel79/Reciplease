//
//  SearchRecipesViewController.swift
//  Reciplease
//
//  Created by Angelique Babin on 09/10/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import UIKit

class SearchRecipesViewController: UIViewController {

    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet var allButtons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        customInterfaceSearch(allButtons: allButtons)
    }
}
