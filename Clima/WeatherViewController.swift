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
    var iSeconds:Float = 100
    //Constants
    let WEATHER_URL = "https://api.openweathermap.org/data/2.5/weather"
    let APP_ID = /*"e377011e7a638e05c2d4605da24b1471"*/  /*"b2ce1f9835865cc14eb5baa1e577743a"*/  "e72ca729af228beabd5d20e3b7749713"
    

    //TODO: Declare instance variables: Done
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()

    
    //Linked IBOutlets
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!



    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        //TODO:Set up the location manager:
        //timer Object
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        timer = Timer.scheduledTimer(timeInterval:  0.5, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        timer?.invalidate()
    }
    @objc func timerElapsed () {
        iSeconds -= 1
        let timeInMasihWorld = weatherDataModel.timeInMasihWorld
        let timeAsString = String (format: "%.2d", timeInMasihWorld.hour) + " : " + String (format: "%.2d", timeInMasihWorld.minute) + " : " + String (format: "%.2d", timeInMasihWorld.second)
        self.timeLabel.text = timeAsString

        //timerLabel.text = "Time Remaining: \(seconds)"
        //When the timer has reached the 0...
//        if iSeconds <= 0 {
//            timer?.invalidate()
//            //timerLabel.textColor = UIColor.red
//            //timerLabel.font = UIFont.boldSystemFont(ofSize: 17)
//            //TODO: change the text of label to win/loos state based on checking is remained any unmatched card or not.
//            //TODO: Show the score
//        }
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
        weatherDataModel.conditionDM         = json["weather"][0]["id"].intValue
        weatherDataModel.weathrIconName      = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.conditionDM)
        updateUIWithWeatherData()
    }
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
        func updateUIWithWeatherData(){
        cityLabel.text        =               weatherDataModel.cityDM
        temperatureLabel.text =        "\(Int(weatherDataModel.tempratureDM)) ℃" // "°"
        weatherIcon.image     = UIImage(named:weatherDataModel.weathrIconName)
    }
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    //the didUpdateLocations method:
    var locationParameters = [String : String]()
    var api = String() // this will change to url as soon as I can
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count-1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationParameters = ["lat": "\((location.coordinate.latitude))", "lon": "\(location.coordinate.longitude)",  "appid" : self.APP_ID ]
            //api = "https://api.openweathermap.org/data/2.5/weather?lat=\(locationParameters["lat"]!)&lon=\(locationParameters["lon"]!)&appid=\(locationParameters["appid"]!)"
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


