//
//  ChangeCityViewController.swift
//  WeatherApp
//
//

import UIKit


//Protocol declaration:
protocol ChangeCityDelegate {
   func UsereEnteredANewCityName(city: String)
}


class ChangeCityViewController: UIViewController {
    
    //Delegate variable:
    var delegate : ChangeCityDelegate?
    
    //Linked IBOutlets to the text field:
    @IBOutlet weak var changeCityTextField: UITextField!
    
    @IBAction func getWeatherPressed(_ sender: AnyObject) {
        
        
        
        //1 Get the city name the user entered in the text field
        let cityName = changeCityTextField.text!
        
        //2 If we have a delegate set, call the method userEnteredANewCityName
        delegate?.UsereEnteredANewCityName(city: cityName)
        
        //3 dismiss the Change City View Controller to go back to the WeatherViewController
        self.dismiss(animated: true) {
            //nothing to do
        }
        //self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
