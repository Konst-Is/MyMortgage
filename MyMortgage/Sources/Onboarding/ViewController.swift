import UIKit

final class ViewController: UIViewController, Coordinatable, Storyboardable {

    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var infoView: UIView!
    @IBOutlet private weak var settingLabel: UILabel!
    
    weak var coordinator: Coordinator?
    
    private let checkbox = CheckBoxButton(frame: CGRect(x: 130, y: 600, width: 30, height: 30))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Описание приложения"
        infoView.layer.cornerRadius = 10
        nextButton.layer.cornerRadius = 10

        infoLabel.text = """
        Инфляция - это процесс общего роста цен и обесценивания денег. Но можно ли заставить её работать на себя? Это приложение ответит на вопрос, почему покупать недвижимость в кредит сегодня выгодно, даже несмотря на то, что придётся заплатить две и даже более стоимости квартиры.
        
        Дело в том, что инфляция "съедает" не только накопления, но и долги. Допустим, вы купили квартиру в ипотеку сроком на 20 лет с ежемесячным платёжом 100000 руб. Пусть ежегодная инфляция составляет 8 %. Тогда через год этот платёж будет эквивалентен сегодняшним 93593 руб., а на 20-й - всего лишь 23171 руб. Если сделать полный расчёт, то благодаря инфляции стоимость недвижимости, купленной в ипотеку, может даже оказаться ниже её изначальной стоимости!
        
        Данная программа предназначена для оценки выгодности ипотечного кредита, исходя из некоторого среднего предположительного уровня инфляции. Выберите конкретный вариант недвижимости, например, на сайте ЦИАН, откройте на нём калькулятор ипотеки, введите первоначальный платёж, срок, процент по ипотеке и получите ежемесячный платёж. Все эти данные необходимо ввести в текстовые поля приложения.
        
        На выходе вы получите для анализа три стоимости недвижимости, приведённые к сегодняшним ценам: без ипотеки, с ипотекой без учёта инфляции, с ипотекой и с учётом инфляции, а также динамику уменьшения ежемесячных платежей по годам.
        """
        
        view.addSubview(checkbox)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapCheckbox))
        checkbox.addGestureRecognizer(gesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkbox.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 34),
            checkbox.trailingAnchor.constraint(equalTo: settingLabel.leadingAnchor, constant: 0),
            checkbox.widthAnchor.constraint(equalToConstant: 30),
            checkbox.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @IBAction
    private func didTapNextButton(_ sender: UIButton) {
        coordinator?.openMortgageInput()
    }
    
    @objc
    private func didTapCheckbox() {
        checkbox.toggle()
        UserSettingsManager.isOnboardingPassed = checkbox.isChecked
    }
    
}
