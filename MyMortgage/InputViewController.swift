
// Убери делегаты из настроек, ты ими не пользуешься

import UIKit

class InputViewController: UIViewController {
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == Identifier.segueToOutputVC) {
            
            MortgageCalculatorImpl.shared.userMortgage.costWithoutMortgage = Int(initialCostTextField.text ?? "0") ?? 0
            MortgageCalculatorImpl.shared.userMortgage.initialPayment = Int(initialPaymentTextField.text ?? "0") ?? 0
            MortgageCalculatorImpl.shared.userMortgage.termOfMortgage = Int(termOfMortageTextField.text ?? "0") ?? 0
            MortgageCalculatorImpl.shared.userMortgage.monthlyPayment = Int(monthlyPaymentTextField.text ?? "0") ?? 0
            MortgageCalculatorImpl.shared.userMortgage.inflation = Int(inflationTextField.text ?? "0") ?? 0
            
            if !MortgageCalculatorImpl.shared.isValid {
                showAlert()
                return
            }
        }
    }
    
    @IBAction func calcButtonAction(_ sender: UIButton) {
        
        // Здесь можно передать в OutputVC MortgageCalculator. Иначе убрать.
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "Ошибка во входных данных", message: "Введите реальные данные по ипотеке от продавца или от банка. Срок ипотеки от 0 до 30 лет, инфляция от 0 до 1000 % в год", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
        }
}


