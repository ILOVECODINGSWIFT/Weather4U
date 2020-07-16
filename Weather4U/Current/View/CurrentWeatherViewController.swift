//
//  CurrentWeatherViewController.swift
//  Weather4U
//
//  Created by administrator on 16/07/20.
//  Copyright © 2020 ILoveCodingSwift. All rights reserved.
//

import UIKit

class CurrentWeatherViewController: UIViewController {

    fileprivate let model = WeatherViewModel()

    @IBOutlet weak var contentView : UIView!
    @IBOutlet weak var icon : UIImageView!
    @IBOutlet weak var locationName : UILabel!
    @IBOutlet weak var currentTemp : UILabel!
    @IBOutlet weak var wind : UILabel!
    private var lng : String!
    private var lat : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        // Do any additional setup after loading the view.
    }
    
    class func create(lat : String , lng : String )->CurrentWeatherViewController
        {
            let _vc = CurrentWeatherViewController(nibName: "CurrentWeatherViewController", bundle: nil)
            _vc.lat = lat
            _vc.lng = lng
            
            return _vc
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        model.getCurrentWeather(lat: lat, lng: lng)
    }
    
    @IBAction func tempUnitChanged(_ sender: UISegmentedControl)
    {
        if sender.selectedSegmentIndex == 0
        {
            self.currentTemp.text = convertTemp(temp: model.currentWeather?.main.temp ?? 0 , from: .kelvin, to: .celsius)
        }
        else
        {
            self.currentTemp.text = convertTemp(temp: model.currentWeather?.main.temp ?? 0 , from: .kelvin, to: .fahrenheit)
        }
    }
    
    func convertTemp(temp: Double, from inputTempType: UnitTemperature, to outputTempType: UnitTemperature) -> String {
        let mf = MeasurementFormatter()

      mf.numberFormatter.maximumFractionDigits = 0
      mf.unitOptions = .providedUnit
      let input = Measurement(value: temp, unit: inputTempType)
      let output = input.converted(to: outputTempType)
      return mf.string(from: output)
    }
}


extension CurrentWeatherViewController: WeatherViewModelProtocol {
    func didUpdateCurrentWeather() {
        
        self.contentView.isHidden = false
        self.contentView.backgroundColor = .white

        self.locationName.text = model.currentWeather?.name ?? ""
        self.currentTemp.text = convertTemp(temp: model.currentWeather?.main.temp ?? 0 , from: .kelvin, to: .celsius)
        self.wind.text = "Winds : \(model.currentWeather?.wind.speed ?? 0) m/s"

        if model.currentWeather?.weather.count ?? 0 > 0
        {
            let url = URL(string: "https://openweathermap.org/img/wn/\(model.currentWeather?.weather[0].icon ?? "")@2x.png")
            let data = try? Data(contentsOf: url!)
            self.icon.image = UIImage(data: data!)
        }
    }
}


