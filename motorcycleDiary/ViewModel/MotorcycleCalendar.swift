//
//  motoCalendar.swift
//  APIOS_projekt
//
//  Created by Konrad Tegowski on 25/01/2023.
//

import SwiftUI

struct MotorcycleCalendar: View {
    @ObservedObject var motorcycle:MotorcycleModel;
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack{
            Spacer()
            Text("Czas do najbliższego przeglądu i OC")
            List{
                HStack{
                    Text("Do opłaty następnego OC pozostało: ")
                    Spacer()
                    Text(calculateDateBetween(_:motorcycle.getDateOfLastOC()))
                        .multilineTextAlignment(.trailing)
                }
                HStack{
                    Text("Do następnego przeglądu technicznego pozostało: ")
                    Spacer()
                    Text(calculateDateBetween(_:motorcycle.getDateOfLastPT()))
                        .multilineTextAlignment(.trailing)
                }
            }
            .background(colorScheme == .dark ? Color.black: Color.white)
            .scrollContentBackground(.hidden)
        }
    }
}
func calculateDateBetween(_ from: Date?) -> String{
    if(from != nil){
        var dateComponent = DateComponents()
        dateComponent.year = 1;
        let dateTo = Calendar.current.date(byAdding: dateComponent, to: from!)
        return String(Calendar.current.dateComponents([.day], from: Date(), to: dateTo!).day!)
    }

        return "Nie określono daty początkowej wydarzenia"
    }
    
