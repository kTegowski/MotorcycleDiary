//
//  IntervalModel.swift
//  APIOS_projekt
//
//  Created by Konrad Tęgowski  on 27/01/2023.
//

import Foundation
class IntervalModel: ObservableObject,Codable{
    var oilInterval:Int
    var breakInterval: Int
    var OCInterval: Int
    var inspectionInterval: Int
    
    
    init() {
        oilInterval = 365
        breakInterval = 730
        OCInterval = 365
        inspectionInterval = 365
    }
    func getOilInterval() -> Int{
        return oilInterval
    }
    func getBreakInterval() -> Int{
        return breakInterval
    }
    
    func alertChangeOil(oil:String){
        if(oil != ""){
            oilInterval = Int(oil) ?? 0
        }}
    
    func alertChange(hamulce:String){
        if(hamulce != ""){
            breakInterval = Int(hamulce) ?? 0
        }
    }
    
}
