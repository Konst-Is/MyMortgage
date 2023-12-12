import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var settingLabel: UILabel!
    
    var mortgageCalculator: MortgageCalculator!
    
    private let checkbox = CheckBoxButton(frame: CGRect(x: 130, y: 600, width: 30, height: 30))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Больше не показывать первый экран? \(UserSettingsManager.missInformation)")
        
        infoView.layer.cornerRadius = 10
        nextButton.layer.cornerRadius = 10

        infoLabel.text = """
        Инфляция - это процесс общего роста цен и обесценивания денег. Но можно ли заставить её работать на себя? Почему покупать недвижимость в период кризиса выгоднее через ипотеку, даже несмотря на то, что придётся заплатить две и даже более стоимости квартиры?
        
        Дело в том, что инфляция "съедает" не только наши накопления, но и наши долги. Допустим, ваш ежемесячный ипотечный платёж составляет 100000 руб., а ежегодная инфляция 8 %. Тогда через год эта сумма будет эквивалентна сегодняшним 93593 руб., а на 20-й - всего лишь 23171 руб. С каждым годом ваши долговые обязательства уменьшаются.
        
        Данная программа предназначена для оценки выгодности ипотечного кредита, исходя из некоторого предположительного уровня инфляции. Выберите конкретный вариант недвижимости, например, на сайте ЦИАН, откройте на нём калькулятор ипотеки, введите первоначальный платёж, срок, процент по ипотеке и получите ежемесячный платёж. Все эти данные необходимо ввести в текстовые поля приложения.
        
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
    
    @objc func didTapCheckbox() {
        checkbox.toggle()
        UserSettingsManager.missInformation = checkbox.isChecked
    }
}

