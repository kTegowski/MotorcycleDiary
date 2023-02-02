//
//  newMotorcycleView.swift
//  motorcycleDiary
//
//  Created by Konrad Tęgowski on 31/01/2023.
//

import SwiftUI

struct newMotorcycleView: View {
    @Binding var whatView:Bool
    @Binding var moto: MotorcycleModel?
    @Environment(\.colorScheme) var colorScheme
    @State private var brand: String = ""
    @State private var model: String = ""
    @State private var productionyear: String = ""
    @State private var millage: String = ""
    @State private var registrationNumber: String = ""
    @State private var VINnumber: String = ""
    @State private var type: String = ""
    @State private var isActive = false
    var dropDownList = ["turystyczny","sportowy","sportowo_turystyczny","enduro","Chopper","Cruiser"]
    
    
    
    var body: some View {
            VStack {
                Spacer()
                Text("Uzupełnij dane swojego pojazdu")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                List{
                    HStack{
                        Text("Marka pojazdu")
                        Spacer()
                        TextField("Marka",
                                  text: $brand)
                        .multilineTextAlignment(.trailing)
                    }
                    
                    HStack{
                        Text("Model pojazdu")
                        Spacer()
                        TextField("Model",text: $model)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack{
                        Text("Rok produkcji")
                        Spacer()
                        TextField("Rok", text: $productionyear)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                        
                    }
                    HStack{
                        Text("Aktualny przebieg")
                        Spacer()
                        TextField("Przebieg", text: $millage)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack{
                        Text("Numer rejestracyjny")
                        Spacer()
                        TextField("Rejestracja", text: $registrationNumber)
                            .multilineTextAlignment(.trailing)
                        
                    }
                    
                    HStack{
                        Text("Numer VIN")
                        Spacer()
                        TextField("VIN", text: $VINnumber )
                            .multilineTextAlignment(.trailing)
                    }
                    HStack{
                        Text("Typ motocykla")
                        Spacer()
                        Menu {
                            ForEach(dropDownList, id: \.self){ event in
                                Button(event) {
                                    type = event
                                }
                            }
                        } label: {
                            Text(type)
                                .foregroundColor(Color.red)
                                .multilineTextAlignment(.trailing)
                            Image(systemName: "chevron.down")
                                .foregroundColor(Color.red)
                                .padding(0)
                        }
                    }
                }
                .background(colorScheme == .dark ? Color.black: Color.white)
                .scrollContentBackground(.hidden)
                    Button("Stwórz nowy pojazd")
                    {
                        let motorcycle = MotorcycleModel(type: MotorcycleType(string: type), millage: Int(millage) ?? 0, productionyear: Int(productionyear) ?? 0, VINNumber: VINnumber, brand: brand, model: model, registrationNumber: registrationNumber)
                        try! saveToJson(motorcycle: motorcycle)
                        moto = motorcycle
                        whatView = true
                    }
                    .padding(25)
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                    .buttonBorderShape(.roundedRectangle(radius: 20))
                
                
               
            }
            
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
