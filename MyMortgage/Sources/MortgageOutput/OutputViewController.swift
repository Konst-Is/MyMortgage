import UIKit

class OutputViewController: UIViewController, Coordinatable {
    
    var mortgageCalculatorResult: MortgageCalculatorResult!
    
    @IBOutlet weak var graphicButton: UIButton!
    @IBOutlet weak var initialCostLabel: UILabel!
    @IBOutlet weak var mortgageCostLabel: UILabel!
    @IBOutlet weak var inflatioCostLabel: UILabel!
    
    weak var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        graphicButton.layer.cornerRadius = 10
        
        navigationItem.title = "Рассчёт"
        
        initialCostLabel.text = mortgageCalculatorResult.costWithoutMortgage.formatted
        mortgageCostLabel.text = mortgageCalculatorResult.totalCostWithoutInflation.formatted
        inflatioCostLabel.text = mortgageCalculatorResult.totalCostAdjustedForInflation.formatted
    }
    
    @IBAction func showChartButtonAction(_ sender: UIButton) {
        coordinator?.openDiagram(mortgageCalculatorResult: mortgageCalculatorResult)
    }
    
}
