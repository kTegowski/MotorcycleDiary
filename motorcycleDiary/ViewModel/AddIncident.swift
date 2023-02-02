//
//  AddIncident.swift
//  APIOS_projekt
//
//  Created by Konrad Tęgowski on 25/01/2023.
//

import SwiftUI

struct AddIncident: View {
    @State private var name: String = ""
    @State private var cost: String = ""
    @State private var millage: String = ""
    @State var date = Date();
    
    var dropDownList = ["Wymiana oleju", "Opłata OC", "Przegląd techniczny", "Wymiana układu hamuclowego"]
    var motorcycle:MotorcycleModel;
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack{
            
            VStack{
                Spacer()
                List{
                        HStack{
                            Text("Wprowadź nazwę")
                            Spacer()
                            TextField("Nazwa wydarzenia",
                                      text: $name)
                            .multilineTextAlignment(.trailing)
                            Menu {
                                ForEach(dropDownList, id: \.self){ event in
                                    Button(event) {
                                        name = event
                                    }
                                }
                            } label: {
                                Image(systemName: "chevron.down")
                                                        .foregroundColor(Color.red)
                                                        .padding(0)
                            }
                        }
                    HStack{
                        Text("Wprowadź koszt")
                        Spacer()
                        TextField("Koszt",
                                  text: $cost)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                    }
                    
                    DatePicker(
                        "Wybierz datę",
                        selection: $date,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.compact)
                    HStack{
                        Text("Wprowadź przebieg")
                        Spacer()
                        TextField("Przebieg",
                                  text: $millage)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                    }
                    
                }
            }
            .background(colorScheme == .dark ? Color.black: Color.white)
            .scrollContentBackground(.hidden)
            Spacer()
            HStack{
                Spacer()
                Button("Utwórz zdarzenie") {
                    do{
                        try addIncident()
                    }catch{
                        print("error")
                    }

                }
                .padding(.top, 75)
                .buttonStyle(.borderedProminent)
                .tint(.red)
                .buttonBorderShape(.roundedRectangle(radius: 20))
                Spacer()
            }
            Spacer()
        }
    }
    func addIncident() throws ->Void{
        let costFloat = cost.replacingOccurrences(of: ",", with: ".")
        let incident = Incident(name: name, date: date, cost: costFloat, millage: millage)
        motorcycle.addIncident(incident: incident)
        motorcycle.sortIncidentTable()
        name = ""
        date = Date()
        cost = ""
        millage = ""
        try saveToJson(motorcycle: motorcycle)
    }
    
    func saveToJson(motorcycle:MotorcycleModel) throws -> Void{
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(motorcycle)
        let json = String(data: jsonData, encoding: String.Encoding.utf8)
        let file = "backup.json"
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
             do {
                 let fileURL = dir.appendingPathComponent(file)
                 try json!.write(to: fileURL, atomically: true, encoding: .utf8)
             } catch {
                 print("error:\(error)")
             }
        }
    }
}



