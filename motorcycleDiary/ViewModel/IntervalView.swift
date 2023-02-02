//
//  IntervalView.swift
//  APIOS_projekt
//
//  Created by Konrad Tegowski on 25/01/2023.
//

import SwiftUI

struct IntervalView: View {
    @ObservedObject var interval: IntervalModel
    @ObservedObject var motorcycle: MotorcycleModel
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack{
            Spacer()
            Text("Zbliżające sie wymiany")
            List{
                HStack{
                    Text("Układ hamulcowy: ")
                    Spacer()
                    Text(calculateDateBetween(_:motorcycle.getLastIntervalEvent("Wymiana układu hamuclowego"),days: interval.getBreakInterval()))
                    .multilineTextAlignment(.trailing)
                }
                HStack{
                    Text("Serwis olejowy: ")
                    Spacer()
                    Text(calculateDateBetween(_:motorcycle.getLastIntervalEvent("Wymiana oleju"), days: interval.getOilInterval()))
                        .multilineTextAlignment(.trailing)
                }
            }
            .background(colorScheme == .dark ? Color.black: Color.white)
            .scrollContentBackground(.hidden)
        }
    }
    func calculateDateBetween(_ from: Date?,days: Int) -> String{
        if(from != nil){
            var dateComponent = DateComponents()
            dateComponent.day = days;
            let dateTo = Calendar.current.date(byAdding: dateComponent, to: from!)
            return String(Calendar.current.dateComponents([.day], from: Date(), to: dateTo!).day!)
        }

            return "Nie określono daty początkowej wydarzenia"
        }
}

