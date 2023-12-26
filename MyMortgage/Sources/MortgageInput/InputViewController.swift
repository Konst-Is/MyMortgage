import UIKit

final class InputViewController: UIViewController, Coordinatable, Storyboardable {
    
    @IBOutlet private weak var calcButton: UIButton!
    @IBOutlet private weak var initialCostTextField: UITextField!
    @IBOutlet private weak var initialPaymentTextField: UITextField!
    @IBOutlet private weak var termOfMortageTextField: UITextField!
    @IBOutlet private weak var monthlyPaymentTextField: UITextField!
    @IBOutlet private weak var inflationTextField: UITextField!
    
    weak var mortgageCalculator: MortgageCalculator!
    weak var coordinator: Coordinator?
    
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
        
        clearFields()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    @IBAction
    private func calcButtonAction(_ sender: UIButton) {
        let userMortgage = UserMortgage(costWithoutMortgage: extractInputNumber(input: initialCostTextField),
                                        initialPayment: extractInputNumber(input: initialPaymentTextField),
                                        termOfMortgage: extractInputNumber(input: termOfMortageTextField),
                                        monthlyPayment: extractInputNumber(input: monthlyPaymentTextField),
                                        inflation: extractInputNumber(input: inflationTextField))
        
        let result = mortgageCalculator.calculate(userMortgage: userMortgage)
        
        switch result {
        case .success(let calculationResult):
            coordinator?.openMortgageOutput(mortgageCalculatorResult: calculationResult)

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
    
    private func clearFields() {
        initialCostTextField.text = ""
        initialPaymentTextField.text = ""
        termOfMortageTextField.text = ""
        monthlyPaymentTextField.text = ""
        inflationTextField.text = ""
    }
    
}
