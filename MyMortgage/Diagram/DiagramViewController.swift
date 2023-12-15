
import DGCharts
import UIKit

class DiagramViewController: UIViewController {
    
    @IBOutlet weak var popButton: UIButton!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    var mortgageCalculatorResult: MortgageCalculatorResult!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popButton.layer.cornerRadius = 10
        
        createTopChart()
        createBottomChart()
    }
    
    private func createTopChart() {
        
        let barChart = BarChartView(frame: CGRect(x: 20,
                                                  y: 140,
                                                  width: view.frame.size.width - 60,
                                                  height: view.frame.size.height / 4))
        
        let xAxis = barChart.xAxis
        xAxis.enabled = false
        xAxis.labelTextColor = NSUIColor(cgColor: UIColor.clear.cgColor)
        
        let leftAxis = barChart.leftAxis
        leftAxis.enabled = false
        
        let rightAxis = barChart.rightAxis
        rightAxis.enabled = false
        
        let legend = barChart.legend
        legend.enabled = true
        legend.xOffset = 10.0
        
        let costWithoutMortgage = mortgageCalculatorResult.costWithoutMortgage
        let costWithoutInflation = mortgageCalculatorResult.totalCostWithoutInflation
        let costWithInflation = mortgageCalculatorResult.totalCostAdjustedForInflation
        
        let entries1 = [BarChartDataEntry(x: Double(1), y: Double(costWithoutMortgage))]
        let entries2 = [BarChartDataEntry(x: Double(2), y: Double(costWithoutInflation))]
        let entries3 = [BarChartDataEntry(x: Double(3), y: Double(costWithInflation))]
        
        let chartDataSet1 = BarChartDataSet(entries: entries1, label: "без ипотеки, руб.")
        chartDataSet1.colors = [NSUIColor(red: 66 / 255,
                                          green: 150 / 255,
                                          blue: 236 / 255,
                                          alpha: 1)]
        
        let chartDataSet2 = BarChartDataSet(entries: entries2, label: "с ипотекой и без учёта инфляцииб руб.")
        chartDataSet2.colors = [NSUIColor(red: 63 / 255,
                                          green: 111 / 255,
                                          blue: 244 / 255,
                                          alpha: 1)]
        
        let chartDataSet3 = BarChartDataSet(entries: entries3, label: "с ипотекой и с учётом инфляции, руб.")
        chartDataSet3.colors = [NSUIColor(red: 13 / 255,
                                          green: 73 / 255,
                                          blue: 240 / 255,
                                          alpha: 1)]
        
        let dataSets: [BarChartDataSet] = [chartDataSet1, chartDataSet2, chartDataSet3]
        let data = BarChartData(dataSets: dataSets)
        barChart.data = data
        
        view.addSubview(barChart)
    }
    
    private func createBottomChart() {
        
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
        
        set.colors = [NSUIColor(cgColor: UIColor.blue.cgColor)]
        set.valueTextColor = NSUIColor(cgColor: UIColor.clear.cgColor)
        
        let data = BarChartData(dataSet: set)
        
        barChart.data = data
        
        view.addSubview(barChart)
    }
    
    
    @IBAction func popButtonAction(_ sender: UIButton) {
        
        guard let navVC = navigationController else { return }
        navVC.popViewController(animated: true)
        
    }
    
}
