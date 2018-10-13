//
//  ViewController.swift
//  WeatherApp
//
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
    
    var timer:Timer?
    //Constants
    let WEATHER_URL = "https://api.openweathermap.org/data/2.5/weather"
    let APP_ID = /*"e377011e7a638e05c2d4605da24b1471"*/  /*"b2ce1f9835865cc14eb5baa1e577743a"*/  "e72ca729af228beabd5d20e3b7749713"
    
    
    //TODO: Declare instance variables: Done
    let locationManager     = CLLocationManager()
    let weatherDataModel    = WeatherDataModel()
    let clockManager       = ClockManager()
    
    var timeInMyWorld = (hour: 11, minute: 59, second: 59)
    var timerPeakTime = 1.0
    
    
    //Linked IBOutlets
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var secondHandImage: UIImageView!
    @IBOutlet weak var minuteHandImage: UIImageView!
    @IBOutlet weak var hourHandImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation() // -MARK:this will goes to viewWillapear in real device to let me know wher the user is.
        
        //TODO:Set up the location manager:
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        timer = Timer.scheduledTimer(timeInterval:  timerPeakTime, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        timer?.invalidate()
    }
    
    
    var previousSecond = 0
    @objc func timerElapsed () {
        let timeInMasihWorld = weatherDataModel.timeInMasihWorld
        let timeAsString = String (format: "%.2d", timeInMasihWorld.hour) + " : " + String (format: "%.2d", timeInMasihWorld.minute) + " : " + String (format: "%.2d", timeInMasihWorld.second)
        self.timeLabel.text = timeAsString
        
        let uiImagesViewArray = clockManager.handsPositioner(timeTouple: timeInMasihWorld, uIImageViewArray: [self.secondHandImage, self.minuteHandImage, self.hourHandImage])
        self.secondHandImage.transform  = uiImagesViewArray[0].transform
        self.minuteHandImage.transform  = uiImagesViewArray[1].transform
        self.hourHandImage.transform    = uiImagesViewArray[2].transform
        
    }
    
    func setClockhands(){
        timeInMyWorld = weatherDataModel.timeInMasihWorld
        UIView.animate(withDuration: 2.0, animations: {
            
            self.secondHandImage.transform = self.clockManager.aHandPositioner(handPosition: Double(self.timeInMyWorld.second), uIImageView: self.secondHandImage).transform
            
            self.minuteHandImage.transform = self.clockManager.aHandPositioner(handPosition: Double(self.timeInMyWorld.minute), uIImageView: self.minuteHandImage).transform
            
            self.hourHandImage.transform = self.clockManager.aHandPositioner(handPosition: Double(self.timeInMyWorld.hour) * 5 + Double(self.timeInMyWorld.minute) / 12, uIImageView: self.hourHandImage).transform
        })
    }
    
    //MARK: - Networking
    /***************************************************************/
    var weatherJSON = JSON()
    func getApiData(url: String, parameters : [String : String]  ) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
            if response.result.isSuccess {
                self.weatherJSON = JSON(response.result.value!)
                print(self.weatherJSON)
                self.updateWeather(json: self.weatherJSON)
            } else {
                print("Error: \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection Issue"
            }
        }
        
    }
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    func updateWeather (json : JSON){
        
        weatherDataModel.sunriseTimeInterval = json["sys"]  ["sunrise"].intValue
        weatherDataModel.sunsetTimeInterval  = json["sys"]  ["sunset" ].intValue
        
        weatherDataModel.tempratureDM        = json["main"] ["temp"].doubleValue - 273.15
        weatherDataModel.cityDM              = json["name"].stringValue
        updateUIWithWeatherData()
    }
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    func updateUIWithWeatherData(){
        cityLabel.text        =               weatherDataModel.cityDM
        temperatureLabel.text =        "\(Int(weatherDataModel.tempratureDM)) ℃" // "°"
        print("weather UI is updated")
        setClockhands()
        print(weatherDataModel.sunrise)
        print(weatherDataModel.sunset)
        timerPeakTime = Double(Int((weatherDataModel.extendRate) * 100)) / 100
        print(weatherDataModel.extendRate)
        print(timerPeakTime)
    }
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    //the didUpdateLocations method:
    var locationParameters = [String : String]()
    var apiM = String() // this will change to url as soon as I can
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count-1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationParameters = ["lat": "\((location.coordinate.latitude))", "lon": "\(location.coordinate.longitude)",  "appid" : self.APP_ID ]
            getApiData(url: WEATHER_URL, parameters: locationParameters)
            
        }
    }
    
    
    // the didFailWithError method:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
    
    
    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //the userEnteredANewCityName Delegate method:
    func UsereEnteredANewCityName(city: String) {
        locationParameters = ["q" : city, "appid" : APP_ID]
        getApiData(url: WEATHER_URL, parameters: locationParameters)
        updateUIWithWeatherData()
    }
    
    
    //the PrepareForSegue Method:
    override func prepare(for segue: UIStoryboardSegue, sender : Any?){
        if segue.identifier == "changeCityName" {
            let destinationVC = segue.destination as! ChangeCityViewController
            destinationVC.delegate = self
        }
    }
    
    
}


