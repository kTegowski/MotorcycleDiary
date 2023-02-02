//
//  MainView.swift
//  APIOS_projekt
//
//  Created by Konrad Tegowski on 25/01/2023.
//

import Foundation

import SwiftUI

struct MainView: View {
    var moto:MotorcycleModel
    var Interval = IntervalModel()
    @State private var selection = 3
    @Binding var whatView: Bool;
    var body: some View {
        ZStack{
            VStack {
                	
                TabView(selection: $selection){
                    
                    AddIncident(motorcycle:moto)
                        .tabItem {
                            Label("Dodaj wydarzenie", systemImage: "square.and.arrow.up")
                            Text("Dodaj wydarzenie")
                        }
                        .tag(1)
                        .background(.gray)
                    MotorcycleCalendar(motorcycle: moto)
                        .tabItem {
                            Image(systemName: "leaf.fill")
                                .font(.title)
                            Text("Przeglądy")
                        }
                        .tag(2)
                    BasicInfoView(whatView: $whatView, interval: Interval, motorcycle: moto)
                        .tabItem {
                            Image("MotoIcons")
                                .resizable()
                            Text("Info")
                        }
                        .tag(3)
                    IntervalView(interval: Interval, motorcycle: moto)
                        .tabItem {
                            Image(systemName: "gearshape.2.fill")
                                .font(.title)
                            Text("Wymiany")
                        }
                        .tag(4)
                    millageChartView(motorcycle: moto)
                        .tabItem {
                            Image(systemName: "map.fill")
                                .font(.title)
                            Text("Przebieg")
                        }
                        .tag(5)
                    
                }
                .tint(Color.red)
            }
            .padding()
        }
    }
}




//var moto = MotorcycleModel(type: type, millage: 65700,
//                           productionyear: 1997, VINNumber: "TESTOWYVIN", brand: "Kawassaki",
//                           model: "ER-5", registrationNumber: "CRY-86E3");


