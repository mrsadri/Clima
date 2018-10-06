//
//  WeatherDataModel.swift
//  WeatherApp
//
//

import UIKit

class WeatherDataModel {

    //Moodel variables
    var tempratureDM        : Double    = 0
    var conditionDM         : Int       = 0
    var cityDM              : String    = ""
    var weathrIconName      : String    = ""
    var sunriseTimeInterval : Int       = 0
    var sunsetTimeInterval  : Int       = 0
    
    var sunrise : (Date:(year:Int,month:Int,day:Int),Time:(hour:Int,minute:Int,second:Int)){
        get{
            return timeIntervalSince1970ToDate(totalSeconds: sunriseTimeInterval)
        }
    }
    
    var sunset  : (Date:(year:Int,month:Int,day:Int),Time:(hour:Int,minute:Int,second:Int)){
        get{
            return timeIntervalSince1970ToDate(totalSeconds: sunsetTimeInterval)
        }
    }
    
    var dayLentghInSeconds : Int {
        get{
            return sunsetTimeInterval - sunriseTimeInterval
        }
    }
    
    var dayLentgh : (hour:Int,minute: Int,second: Int){
        get{
            return  secondsToDuration(totalSeconds: dayLentghInSeconds)
        }
    }

    var timeInMasihWorld : (hour:Int,minute: Int,second: Int){
        get{
            return (11,59,59)
        }
    }
    
    var extendRate:Double{
        get{
            return 43200/Double(dayLentghInSeconds)
        }
    }
    
    func secondsToDuration(totalSeconds:Int) -> (hour:Int,minute: Int,second: Int){
        var returner : (hour:Int,minute: Int,second: Int) = (0,0,0)
        returner = (totalSeconds/3600, (totalSeconds % 3600)/60 , (totalSeconds / 3600)%60 )
        return returner
    }
    
    func timeIntervalSince1970ToDate(totalSeconds:Int) -> (Date:(year:Int,month:Int,day:Int),Time:(hour:Int,minute:Int,second:Int)){
        var returner : (Date:(year:Int,month:Int,day:Int),Time:(hour:Int,minute:Int,second:Int)) = ((0,0,0),(0,0,0))
        let date = Date(timeIntervalSince1970: TimeInterval(totalSeconds))
        let calendar = Calendar.current
        
        returner.Time = (calendar.component(.hour   , from: date),
                         calendar.component(.minute , from: date),
                         calendar.component(.second , from: date))
        
        returner.Date = (calendar.component(.year   , from: date),
                         calendar.component(.month  , from: date),
                         calendar.component(.day    , from: date))
        
        return returner
    }
    //This method turns a condition code into the name of the weather condition image
    
    func updateWeatherIcon(condition: Int) -> String {
        
    switch (condition) {
    
        case 0...300 :
            return "tstorm1"
        
        case 301...500 :
            return "light_rain"
        
        case 501...600 :
            return "shower3"
        
        case 601...700 :
            return "snow4"
        
        case 701...771 :
            return "fog"
        
        case 772...799 :
            return "tstorm3"
        
        case 800 :
            return "sunny"
        
        case 801...804 :
            return "cloudy2"
        
        case 900...903, 905...1000  :
            return "tstorm3"
        
        case 903 :
            return "snow5"
        
        case 904 :
            return "sunny"
        
        default :
            return "dunno"
        }

    }
}
