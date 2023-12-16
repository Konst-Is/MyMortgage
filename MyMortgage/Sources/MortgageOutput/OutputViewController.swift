import UIKit

final class OutputViewController: UIViewController, Coordinatable, Storyboardable {
    
    var mortgageCalculatorResult: MortgageCalculatorResult!
    
    @IBOutlet private weak var graphicButton: UIButton!
    @IBOutlet private weak var initialCostLabel: UILabel!
    @IBOutlet private weak var mortgageCostLabel: UILabel!
    @IBOutlet private weak var inflatioCostLabel: UILabel!
    
    weak var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        graphicButton.layer.cornerRadius = 10
        
        navigationItem.title = "Рассчёт"
        
        initialCostLabel.text = mortgageCalculatorResult.costWithoutMortgage.formatted
        mortgageCostLabel.text = mortgageCalculatorResult.totalCostWithoutInflation.formatted
        inflatioCostLabel.text = mortgageCalculatorResult.totalCostAdjustedForInflation.formatted
    }
    
    @IBAction
    private func showChartButtonAction(_ sender: UIButton) {
        coordinator?.openDiagram(mortgageCalculatorResult: mortgageCalculatorResult)
    }
    
}
