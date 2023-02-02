//
//  Motorcycle.swift
//  APIOS_projekt
//
//  Created by Konrad Tegowski on 25/01/2023.
//

import Foundation
import Charts
import SwiftUI

class MotorcycleModel: ObservableObject, Codable{
    private var type: MotorcycleType;
    @Published private var millage: Int;
    private var productionyear: Int;
    private var VINNumber: String;
    private var brand: String;
    private var model: String;
    private var registrationNumber: String;
    @Published private var incidentTable:[Incident] = [];
    enum CodingKeys: String, CodingKey {
            case type
            case millage
            case productionyear
            case VINNumber
            case brand
            case model
            case registrationNumber
            case indcidentTable
        
        }
    init(type: MotorcycleType, millage: Int, productionyear: Int, VINNumber: String, brand: String, model: String, registrationNumber: String) {
        self.type = type
        self.millage = millage
        self.productionyear = productionyear
        self.VINNumber = VINNumber
        self.brand = brand
        self.model = model
        self.registrationNumber = registrationNumber
    }
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decode(MotorcycleType.self, forKey: .type)
        millage = try  values.decode(Int.self, forKey: .millage)
        productionyear = try  values.decode(Int.self, forKey: .productionyear)
        VINNumber = try  values.decode(String.self, forKey: .VINNumber)
        brand = try  values.decode(String.self, forKey: .brand)
        model = try  values.decode(String.self, forKey: .model)
        registrationNumber = try  values.decode(String.self, forKey: .registrationNumber)
        incidentTable = try values.decode([Incident].self, forKey: .indcidentTable)
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(millage, forKey: .millage)
        try container.encode(productionyear, forKey: .productionyear)
        try container.encode(VINNumber, forKey: .VINNumber)
        try container.encode(brand, forKey: .brand)
        try container.encode(model, forKey: .model)
        try container.encode(registrationNumber, forKey: .registrationNumber)
        try container.encode(incidentTable, forKey: .indcidentTable)
    }
    
    func getType() -> MotorcycleType{
        return type;
        }
    func getMillage() -> Int{
        return millage;
    }
    func getProductionyear() -> Int{
        return productionyear;
    }
    func getVINNumber() -> String{
        return VINNumber;
    }
    func getBrand() -> String{
        return brand;
    }
    func getModel() -> String{
        return model;
    }
    func getRegistrationNumber() -> String{
        return registrationNumber;
    }
    func addIncident(incident:Incident) -> Void{
        incidentTable.append(incident);
        if(millage < incident.getMillage()){
            millage = incident.getMillage()
        }
    }
    func getIncidnetTable()->[Incident]{
        return incidentTable;
    }
    func getMillageData()->[millageID]{
        var data:[millageID] = []
        for incident in incidentTable {
            data.append(millageID(date: incident.getDateByString(), millageValue: incident.getMillage()))
        }
        
        return data
    }
    
    func sortIncidentTable()->Void{
        incidentTable  = incidentTable.sorted(by: {$0.getDate().compare($1.getDate()) == .orderedAscending })
    }
    
    func getDateOfLastOC() -> Date?{
        var value: Date? = nil
        for elements in incidentTable{
            if(elements.getName() == "Opłata OC"){
                value = elements.getDate()
            }
        }
        return value
    }
    func getDateOfLastPT() -> Date?{
        var value: Date? = nil
        for elements in incidentTable{
            if(elements.getName() == "Przegląd techniczny"){
                value = elements.getDate()
            }
        }
        return value
    }
    func getLastIntervalEvent(_ name: String)->Date?{
        var value: Date?
        for element in incidentTable{
            if(element.getName() == name){
                value = element.getDate()
            }
        }
        return value
    }

}


struct millageID: Identifiable {
    var id = UUID()
    var date: String
    var millageValue: Int
}

