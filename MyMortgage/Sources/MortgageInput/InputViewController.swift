
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
    
    private lazy var alertController: UIAlertController = {
        let alertController = UIAlertController(title: "Пожалуйста, введите корректные данные",
                                                message: nil,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)
        return alertController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.title = "Ввод данных"
        
        calcButton.layer.cornerRadius = 10
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initialCostTextField.text = ""
        initialPaymentTextField.text = ""
        termOfMortageTextField.text = ""
        monthlyPaymentTextField.text = ""
        inflationTextField.text = ""
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
        alertController.message = error.description
        present(alertController, animated: true)
    }
    
}
