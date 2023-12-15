import UIKit

class OutputViewController: UIViewController {
    
    var mortgageCalculatorResult: MortgageCalculatorResult!
    
    @IBOutlet weak var popButton: UIButton!
    @IBOutlet weak var graphicButton: UIButton!
    @IBOutlet weak var initialCostLabel: UILabel!
    @IBOutlet weak var mortgageCostLabel: UILabel!
    @IBOutlet weak var inflatioCostLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        graphicButton.layer.cornerRadius = 10
        popButton.layer.cornerRadius = 10
        
        navigationItem.title = "Рассчёт"
        
        initialCostLabel.text = mortgageCalculatorResult.costWithoutMortgage.formatted
        mortgageCostLabel.text = mortgageCalculatorResult.totalCostWithoutInflation.formatted
        inflatioCostLabel.text = mortgageCalculatorResult.totalCostAdjustedForInflation.formatted
    }
    
    @IBAction func popButtonAction(_ sender: UIButton) {
        guard let navVC = navigationController else { return }
        navVC.popViewController(animated: true)
    }
    
    
    @IBAction func showChartButtonAction(_ sender: UIButton) {
        let viewController = DiagramBuilder().build()
        viewController.mortgageCalculatorResult = mortgageCalculatorResult
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}




