//
//  DiagramViewController.swift
//  MyMortgage
//
//  Created by Константин on 05.12.2023.
//

import UIKit

class DiagramViewController: UIViewController {

    @IBOutlet weak var popButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        popButton.layer.cornerRadius = 10
    }
    

    @IBAction func popButtonAction(_ sender: UIButton) {
        guard let navVC = navigationController else { return }
        navVC.popViewController(animated: true)
    }
    
}
