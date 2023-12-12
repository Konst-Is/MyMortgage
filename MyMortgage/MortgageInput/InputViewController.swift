
// Убери делегаты из настроек, ты ими не пользуешься

import UIKit

final class InputViewController: UIViewController {
    
    @IBOutlet weak var calcButton: UIButton!
    @IBOutlet weak var initialCostTextField: UITextField!
    @IBOutlet weak var initialPaymentTextField: UITextField!
    @IBOutlet weak var termOfMortageTextField: UITextField!
    @IBOutlet weak var monthlyPaymentTextField: UITextField!
    @IBOutlet weak var inflationTextField: UITextField!
    
    var mortgageCalculator: MortgageCalculator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calcButton.layer.cornerRadius = 10
    }
    
    @IBAction func calcButtonAction(_ sender: UIButton) {
        let userMortgage = UserMortgage(costWithoutMortgage: extractInputNumber(input: initialCostTextField),
                                        initialPayment: extractInputNumber(input: initialPaymentTextField),
                                        termOfMortgage: extractInputNumber(input: termOfMortageTextField),
                                        monthlyPayment: extractInputNumber(input: monthlyPaymentTextField),
                                        inflation: extractInputNumber(input: inflationTextField))
        
        let result = mortgageCalculator.calculate(userMortgage: userMortgage)
        
        switch result {
        case .success(let calculationResult):
            let viewController = MortgageOutputBuilder().build()
            viewController.mortgageCalculatorResult = calculationResult
            self.navigationController?.pushViewController(viewController, animated: true)

        case .failure(let error):
            showAlert(error: error)
        }
    }
    
    private func extractInputNumber(input: UITextField) -> Int {
        return Int(input.text ?? "0") ?? 0
    }
    
    private func showAlert(error: MortgateCalculatorError) {
        // TODO: Handle error
        let alertController = UIAlertController(title: "Ошибка во входных данных",
                                                message: "Введите реальные данные по ипотеке от продавца или от банка. Срок ипотеки от 0 до 30 лет, инфляция от 0 до 1000 % в год",
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}


