//
//  AEBarGraphViewController.swift
//  AESwiftWorking_Example
//
//  Created by Adam on 2021/5/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import Charts

class AEBarGraphViewController: BaseViewController {
    private lazy var barChartView: BarChartView = {
        let barChartView = BarChartView()
        barChartView.delegate = self //设置代理
        barChartView.backgroundColor = UIColor(red: 230 / 255.0, green: 253 / 255.0, blue: 253 / 255.0, alpha: 1)
        barChartView.noDataText = "暂无数据" //没有数据时的文字提示
        barChartView.setExtraOffsets(left: 5, top: 10, right: 5, bottom: 5)
                
        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.alignment = .center
        
        let centerText = NSMutableAttributedString(string: "Charts\nby Daniel Cohen Gindi")
        centerText.setAttributes([.font : UIFont(name: "HelveticaNeue-Light", size: 13)!,
                                  .paragraphStyle : paragraphStyle], range: NSRange(location: 0, length: centerText.length))
        centerText.addAttributes([.font : UIFont(name: "HelveticaNeue-Light", size: 11)!,
                                  .foregroundColor : UIColor.gray], range: NSRange(location: 10, length: centerText.length - 10))
        centerText.addAttributes([.font : UIFont(name: "HelveticaNeue-Light", size: 11)!,
                                  .foregroundColor : UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)], range: NSRange(location: centerText.length - 19, length: 19))
//        barChartView.centerAttributedText = centerText;
//
//        barChartView.drawHoleEnabled = true
//        barChartView.rotationAngle = 0
//        barChartView.rotationEnabled = true
        barChartView.highlightPerTapEnabled = true
        
        let l = barChartView.legend
        l.horizontalAlignment = .center
        l.verticalAlignment = .bottom
        l.orientation = .vertical
        l.drawInside = false
        l.xEntrySpace = 0
        l.yEntrySpace = 0
        l.yOffset = 7
        view.addSubview(barChartView)
        barChartView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
//                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                // Fallback on earlier versions
                make.top.equalTo(self.topLayoutGuide.snp.top).offset(0)
//                make.bottom.equalTo(self.topLayoutGuide.snp.bottom).offset(0)
            }
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        
        return barChartView
    }()
    
    private lazy var sliderX: UISlider = {
        let sliderX = UISlider()
//        sliderX.value = 12
        sliderX.setValue(12, animated: true)
        sliderX.minimumValue = 3
        sliderX.maximumValue = 100
        sliderX.addTarget(self, action: #selector(slidersValueChanged(_:)), for: .valueChanged)
        view.addSubview(sliderX)
        sliderX.snp.makeConstraints { (make) in
            make.top.equalTo(barChartView.snp.bottom).offset(20)
            make.left.equalTo(20)
            make.height.equalTo(40)
        }
        return sliderX
    }()
    private lazy var sliderY: UISlider = {
        let slider = UISlider()
        slider.value = 50;
        slider.minimumValue = 1
        slider.maximumValue = 200
        slider.addTarget(self, action: #selector(slidersValueChanged(_:)), for: .valueChanged)
        view.addSubview(slider)
        slider.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                //make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                // Fallback on earlier versions
                //make.top.equalTo(self.topLayoutGuide.snp.top).offset(0)
                make.bottom.equalTo(self.topLayoutGuide.snp.bottom).offset(0)
            }
            make.left.equalTo(20)
            make.height.equalTo(40)
            make.top.equalTo(sliderX.snp.bottom).offset(10)
        }
        return slider
    }()
    
    private lazy var sliderTextX: UILabel = {
        let name = UILabel()
        name.text = "\(Int(sliderX.value))"
        view.addSubview(name)
        name.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(sliderX)
            make.left.equalTo(sliderX.snp.right).offset(10)
            make.right.equalTo(-20)
            make.height.equalTo(40)
        }
        return name
    }()
    private lazy var sliderTextY: UILabel = {
        let name = UILabel()
        name.text = "\(Int(sliderY.value))"
        view.addSubview(name)
        name.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(sliderY)
            make.left.equalTo(sliderY.snp.right).offset(10)
            make.right.equalTo(-20)
            make.height.equalTo(40)
        }
        return name
    }()
    

    


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configEvent() {
        super.configEvent()
        
        
        //为柱形图提供数据
//        barChartView.data = setData()
        //设置动画效果，可以设置X轴和Y轴的动画效果
        barChartView.animate(yAxisDuration: 1.0)
    }
    
    override func configUI() {
        super.configUI()
        
        
        navigationItem.title = "BarGraph Study"
        let _ = barChartView
        let _ = sliderX
        let _ = sliderY
        sliderX.value = 12
        sliderY.value = 50
        let _ = sliderTextX
        
        let _ = sliderTextY
        
        updateChartData()
    }
    
    func updateChartData() {
//        if self.shouldHideData {
//            barChartView.data = nil
//            return
//        }
        
        self.setDataCount(Int(sliderX.value) + 1, range: UInt32(sliderY.value))
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        let start = 1
        
        let yVals = (start..<start+count+1).map { (i) -> BarChartDataEntry in
            let mult = range + 1
            let val = Double(arc4random_uniform(mult))
            if arc4random_uniform(100) < 25 {
                return BarChartDataEntry(x: Double(i), y: val, icon: UIImage(named: "icon"))
            } else {
                return BarChartDataEntry(x: Double(i), y: val)
            }
        }
        
        var set1: BarChartDataSet! = nil
        if let set = barChartView.data?.dataSets.first as? BarChartDataSet {
            set1 = set
            set1.replaceEntries(yVals)
            barChartView.data?.notifyDataChanged()
            barChartView.notifyDataSetChanged()
        } else {
            set1 = BarChartDataSet(entries: yVals, label: "The year 2017")
            set1.colors = ChartColorTemplates.material()
            set1.drawValuesEnabled = false
            
            let data = BarChartData(dataSet: set1)
            data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
            data.barWidth = 0.9
            barChartView.data = data
        }
        
//        barChartView.setNeedsDisplay()
    }

    
    //为柱形图设置数据
    func setData() -> BarChartData? {
        let xVals_count = 12 //X轴上要显示多少条数据
        let maxYVal: Double = 100 //Y轴的最大值
        //X轴上面需要显示的数据
        var xVals: [AnyHashable] = []
        for i in 0..<xVals_count {
            xVals.append("\(i + 1)月")
        }
        //对应Y轴上面需要显示的数据
        var yVals: [BarChartDataEntry] = []
        for i in 0..<xVals_count {
            let mult = maxYVal + 1
            let val = Double(arc4random_uniform(UInt32(mult)))
            let entry = BarChartDataEntry(x: Double(i), yValues: [val])// (value: val, xIndex: i)
            yVals.append(entry)
        }
        //创建BarChartDataSet对象，其中包含有Y轴数据信息，以及可以设置柱形样式
        let set1 = BarChartDataSet(entries: yVals, label: nil)
//        set1.barSpace = 0.2 //柱形之间的间隙占整个柱形(柱形+间隙)的比例
        set1.drawValuesEnabled = true //是否在柱形图上面显示数值
        set1.highlightEnabled = false //点击选中柱形图是否有高亮效果，（双击空白处取消选中）
        set1.colors = ChartColorTemplates.material() //设置柱形图颜色
        //将BarChartDataSet对象放入数组中
        var dataSets: [IChartDataSet] = []
        dataSets.append(set1)
        //创建BarChartData对象, 此对象就是barChartView需要最终数据对象
        let data = BarChartData(dataSet: dataSets as? IChartDataSet)/// (xVals: xVals, dataSets: dataSets)
//        data.valueFont = UIFont(name: "HelveticaNeue-Light", size: 10.0) //文字字体
//        data.valueTextColor = UIColor.orange //文字颜色
        let formatter = NumberFormatter()
        //自定义数据显示格式
        formatter.numberStyle = .decimal
        formatter.positiveFormat = "#0.0"
//        data.valueFormatter = formatter
        return data
    }


}

extension AEBarGraphViewController: ChartViewDelegate {
    func chartValueSelected(_ barChartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        NSLog("chartValueSelected");
    }
    
    func chartValueNothingSelected(_ barChartView: ChartViewBase) {
        NSLog("chartValueNothingSelected");
    }
    
    func chartScaled(_ barChartView: ChartViewBase, scaleX: CGFloat, scaleY: CGFloat) {
        
    }
    
    func chartTranslated(_ barChartView: ChartViewBase, dX: CGFloat, dY: CGFloat) {
        
    }
}

extension AEBarGraphViewController {
    // MARK: - Actions
    @objc func slidersValueChanged(_ sender: Any?) {
        sliderTextX.text = "\(Int(sliderX.value + 2))"
        sliderTextY.text = "\(Int(sliderY.value))"
        
        self.updateChartData()
    }
}
