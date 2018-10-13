//
//  ClockManager.swift
//  Clima
//
//  Created by MSadri on 10/12/18.
//  Copyright © 2018 London App Brewery. All rights reserved.
//
import UIKit
import Foundation

class ClockManager {
    
    func aHandPositioner(handPosition: Double, uIImageView: UIImageView) -> UIImageView {
        let returner = UIImageView()
        
        // get current angel of UIImageView:
        let currentAngelDegree : Double = Double ((atan2f(Float(uIImageView.transform.b), Float(uIImageView.transform.a))) * Float(180 / Double.pi))
        let newAngelDegree : Double = handPosition * 6
        let rotationAngelRadian = Double (newAngelDegree - currentAngelDegree) * Double.pi / 180
        
        // rotate the view and store it
        returner.transform = uIImageView.transform.rotated(by: CGFloat(rotationAngelRadian))
        
        return returner
    }
    
    
    
    func handsPositioner(timeTouple: (hour: Int, minute: Int, second: Int) , uIImageViewArray:[UIImageView]) -> [UIImageView] {
        var returner = [uIImageViewArray[0], uIImageViewArray[1], uIImageViewArray[2]]
        
        returner[0] = self.aHandPositioner(handPosition: Double(timeTouple.second), uIImageView: uIImageViewArray[0])
       
        if timeTouple.second == 0 {
            returner[1] = self.aHandPositioner(handPosition: Double(timeTouple.minute), uIImageView: uIImageViewArray[1])
            
            if timeTouple.second == 0 {
                returner[2] = self.aHandPositioner(handPosition: Double(timeTouple.hour) * 5 , uIImageView: uIImageViewArray[2])
            }
        }

        
        return returner
    }
    
    
    
    
    
    
    
//    func secondPointer(second : Int, uIImageView: UIImageView) -> UIImageView{
//        let returner = UIImageView()
//        
//        // get current angel of UIImageView:
//        let currentAngelDegree : Int = Int ((atan2f(Float(uIImageView.transform.b), Float(uIImageView.transform.a))) * Float(180 / Double.pi))
//        print(currentAngelDegree)
//        let newAngelDegree : Int = second * 6
//        let rotationAngelRadian = Double (newAngelDegree - currentAngelDegree) * Double.pi / 180
//        
//        // rotate the view and store it
//        returner.transform = uIImageView.transform.rotated(by: CGFloat(rotationAngelRadian))
//        return returner
//    }
}
