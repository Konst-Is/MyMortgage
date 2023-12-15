import DGCharts
import UIKit

class DiagramViewController: UIViewController {
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    var mortgageCalculatorResult: MortgageCalculatorResult!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Диаграммы"
        
        createCostChart()
        createMonthlyPaymentsChart()
    }
    
    private func createCostChart() {
        let barChart = BarChartView(frame: CGRect(x: 20,
                                                  y: view.frame.size.height / 4 - 60,
                                                  width: view.frame.size.width - 60,
                                                  height: view.frame.size.height / 4))
        
        let xAxis = barChart.xAxis
        xAxis.enabled = false
        xAxis.labelTextColor = UIColor.clear
        
        let leftAxis = barChart.leftAxis
        leftAxis.enabled = false
        
        let rightAxis = barChart.rightAxis
        rightAxis.enabled = false
        
        let legend = barChart.legend
        legend.enabled = true
        legend.xOffset = 10.0
        
        let dataSets = barChartModels.enumerated().map { (index, model) in
            let entry = [BarChartDataEntry(x: Double(index), y: Double(model.value))]
            let chartDataSet = BarChartDataSet(entries: entry, label: model.title)
            chartDataSet.colors = [model.color]
            return chartDataSet
        }

        let data = BarChartData(dataSets: dataSets)
        barChart.data = data
        
        view.addSubview(barChart)
    }
    
    private func createMonthlyPaymentsChart() {
        let barChart = BarChartView(frame: CGRect(x: 20,
                                                  y: view.frame.size.height / 2 + 60,
                                                  width: view.frame.size.width - 60,
                                                  height: view.frame.size.height / 4))
        
        let legend = barChart.legend
        legend.enabled = true
        legend.xOffset = 0.0
        
        let monthlyPayments = mortgageCalculatorResult.monthlyPaymentsAdjustedForInflation
        var entries = [BarChartDataEntry]()
        for x in 0..<monthlyPayments.count {
            entries.append(BarChartDataEntry(x: Double(x), y: Double(monthlyPayments[x])))
        }
        let set = BarChartDataSet(entries: entries,
                                  label: "Ежемесячный платёж в зависимости от года, руб.")
        
        set.colors = [UIColor.deepBlue]
        set.valueTextColor = UIColor.clear
        
        let data = BarChartData(dataSet: set)
        
        barChart.data = data
        
        view.addSubview(barChart)
    }
    
    private var barChartModels: [BarChartModel] {
        return [
            BarChartModel(value: mortgageCalculatorResult.costWithoutMortgage,
                          title: "без ипотеки, руб.",
                          color: UIColor.lightBlue),
            BarChartModel(value: mortgageCalculatorResult.totalCostWithoutInflation,
                          title: "с ипотекой и без учёта инфляцииб руб.",
                          color: UIColor.middleBlue),
            BarChartModel(value: mortgageCalculatorResult.totalCostAdjustedForInflation,
                          title: "с ипотекой и с учётом инфляции, руб.",
                          color: UIColor.deepBlue)
            ]
    }
    
}

private extension UIColor {
    
    static var deepBlue: Self {
        return createFrom(red: 13, green: 73, blue: 240, alpha: 1)
    }
    
    static var middleBlue: Self {
        return createFrom(red: 63, green: 11, blue: 244, alpha: 1)
    }
    
    static var lightBlue: Self {
        return createFrom(red: 66, green: 155, blue: 236, alpha: 1)
    }
    
}
