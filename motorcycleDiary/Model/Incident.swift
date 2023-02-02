//
//  Incident.swift
//  APIOS_projekt
//
//  Created by Konrad Tegowski on 26/01/2023.
//

import Foundation
class Incident: Codable{
    private var name: String;
    private var date: Date;
    private var cost: Float;
    private var millage: Int;
    
    init(name: String, date: Date, cost: String, millage: String) {
        self.name = name
        self.date = date
        self.cost = Float(cost) ?? 0.0;
        self.millage = Int(millage) ?? 0;
    }
    
    func getName() -> String {
        return name;
    }
    func getDateByString() -> String{
        	let DateFormatter = DateFormatter()
        DateFormatter.dateFormat = "dd/MM/YY"
        return DateFormatter.string(from: date)
    }
    func getDate() -> Date{
        return date
    }
    func getCost() -> String{
        return String(cost)
    }
    
    func getMillage() ->Int{
        return millage
    }


}
