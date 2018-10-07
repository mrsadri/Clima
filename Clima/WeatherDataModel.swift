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
            var returner : (hour:Int,minute:Int,second:Int) = (6,0,0)
            let date = Date()
            if (Int(date.timeIntervalSince1970) > sunriseTimeInterval && Int(date.timeIntervalSince1970) < sunsetTimeInterval){
                let distanceFromSunrise = secondsToDuration(totalSeconds: Int((date.timeIntervalSince1970 - Double(sunriseTimeInterval)) / extendRate))
                returner.hour += distanceFromSunrise.hour
                returner.minute += distanceFromSunrise.minute
                returner.second += distanceFromSunrise.second
            } else if (Int(date.timeIntervalSince1970) > sunsetTimeInterval){
                let distanceFromSunset = secondsToDuration(totalSeconds: Int((date.timeIntervalSince1970 - Double(sunsetTimeInterval)) * extendRate))
                returner = (18,0,0)
                returner.hour += (distanceFromSunset.hour > 6 ? distanceFromSunset.hour-24 : distanceFromSunset.hour)
                returner.minute += distanceFromSunset.minute
                returner.second += distanceFromSunset.second
            } else if (Int(date.timeIntervalSince1970) < sunriseTimeInterval){
                let distanceToSunrise = secondsToDuration(totalSeconds: Int((Double(sunriseTimeInterval) - (date.timeIntervalSince1970 )) * extendRate))
                returner = (5,59,59)
                returner.hour -= (distanceToSunrise.hour > 5 ? distanceToSunrise.hour+24 : distanceToSunrise.hour)
                returner.minute -= distanceToSunrise.minute
                returner.second -= distanceToSunrise.second
            }
            return returner
        }
    }
    
    var extendRate:Double{
        get{
            return Double(dayLentghInSeconds)/43200
        }
    }
    
    func secondsToDuration(totalSeconds:Int) -> (hour:Int,minute: Int,second: Int){
        var returner : (hour:Int,minute: Int,second: Int) = (0,0,0)
        returner = (totalSeconds/3600, (totalSeconds % 3600)/60 , (totalSeconds % 3600)%60 )
        return returner
    }
    
    func addTwoTimeTouple (first:(Int,Int,Int),second:(Int,Int,Int))-> (Int,Int,Int){
        var returner :(Int,Int,Int) = (0,0,0)
        returner = (first.0 + second.0 > 23 ? first.0 + second.0 - 24 : first.0 + second.0
            , first.1 + second.1, first.2 + second.2)
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
