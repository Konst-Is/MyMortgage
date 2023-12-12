//
//  OutputViewController.swift
//  MyMortgage
//
//  Created by Константин on 05.12.2023.
//

import UIKit

class OutputViewController: UIViewController {
    
    var mortgageCalculator: MortgageCalculator! 
    
    @IBOutlet weak var popButton: UIButton!
    @IBOutlet weak var graphicButton: UIButton!
    @IBOutlet weak var initialCostLabel: UILabel!
    @IBOutlet weak var mortgageCostLabel: UILabel!
    @IBOutlet weak var inflatioCostLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        graphicButton.layer.cornerRadius = 10
        popButton.layer.cornerRadius = 10
        
        mortgageCalculator = MortgageCalculatorImpl.shared
        
        let mortgageCalcResult = mortgageCalculator.mortgageCalcResult
        
        initialCostLabel.text = "\(mortgageCalcResult.costWithoutMortgage.formatted)"
        mortgageCostLabel.text = "\(mortgageCalcResult.totalCostWithoutInflation.formatted)"
        inflatioCostLabel.text = "\(mortgageCalcResult.totalCostAdjustedForInflation.formatted)"
        
    }
    
    @IBAction func popButtonAction(_ sender: UIButton) {
        guard let navVC = navigationController else { return }
        let prevVC = navVC.viewControllers[navVC.viewControllers.count - 2] as! InputViewController
        prevVC.initialCostTextField.text = ""
        prevVC.initialPaymentTextField.text = ""
        prevVC.termOfMortageTextField.text = ""
        prevVC.monthlyPaymentTextField.text = ""
        prevVC.inflationTextField.text = ""
        navVC.popViewController(animated: true)
    }
}
