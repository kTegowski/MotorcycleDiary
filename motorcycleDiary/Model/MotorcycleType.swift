//
//  MotorcycleType.swift
//  APIOS_projekt
//
//  Created by Konrad Tegowski on 25/01/2023.
//

import Foundation

enum MotorcycleType: Codable{
    case Turystyczny, Sportowy, Sportowo_turystyczny, Enduro,Chopper,Cruiser
    init(string : String){
        switch string{
        case "turystyczny" : self = .Turystyczny
        case "sportowy" : self = .Sportowy
        case "sportowo_turystyczny" : self = .Sportowo_turystyczny
        case "enduro" : self = .Enduro
        case "Chopper" : self = .Chopper
        case "Cruiser" : self = .Cruiser
        default: self = .Turystyczny
        }
    }
}

