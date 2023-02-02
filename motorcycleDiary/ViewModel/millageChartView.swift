//
//  millageView.swift
//  APIOS_projekt
//
//  Created by Konrad Tęgowski on 25/01/2023.
//

import SwiftUI
import Charts
struct millageChartView: View {
    @ObservedObject var motorcycle: MotorcycleModel;
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        var data:[millageID] = motorcycle.getMillageData()
        if(data.isEmpty){
            Text("Wprowadź dane, aby zobaczyć wykres przebiegu")
                .multilineTextAlignment(.center)
        }
        else{
            List {
                Chart(data) {
                    LineMark(
                        x: .value("Data", $0.date),
                        y: .value("Przebieg", $0.millageValue)
                    )
                    PointMark(
                        x: .value("Data", $0.date),
                        y: .value("Przebieg", $0.millageValue)
                    )
                }
                .frame(height: 250)
            }
            .background(colorScheme == .dark ? Color.black: Color.white)
            .scrollContentBackground(.hidden)
        }
    }
}

