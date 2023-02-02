//
//  TableView.swift
//  APIOS_projekt
//
//  Created by Konrad Tegowski on 25/01/2023.
//

import SwiftUI

struct BasicInfoView: View {
    @Binding var whatView: Bool;
    @ObservedObject var interval: IntervalModel
    @State var oilInterval = ""
    @State var breakInterval = ""
    @State var ride = false;
    @ObservedObject var motorcycle: MotorcycleModel;
    @Environment(\.colorScheme) var colorScheme
    @State private var showingAlert = false
    var body: some View {
        ZStack{
            if(colorScheme == .dark){
                Color.black
                    .ignoresSafeArea()
            }
            else{
                Color.white
                    .ignoresSafeArea()
            }
           
            VStack{
                HStack{
                    Spacer()
                    Button{
                        showingAlert.toggle()
                    }
                    label: {colorScheme == .dark ? Image(systemName: "gearshape.fill") : Image(systemName: "gearshape")
                    }
                    .alert(Text("Wybierz parametry interwału"), isPresented: $showingAlert, actions: {
                        TextField("Interwał olejowy", text: $oilInterval)
                            .keyboardType(.numberPad)
                        TextField("Interwał hamulców ", text: $breakInterval)
                            .keyboardType(.numberPad)
                        Button("Zmień", action: {
                            interval.alertChange(hamulce: breakInterval)
                            interval.alertChangeOil(oil: oilInterval)
                            oilInterval = ""
                            breakInterval = ""
                        })
                        Button("Anuluj", role: .cancel, action: {})
                    })
                }
                Image(colorScheme == .dark ? "MotoPhotoInvert":"motoPhoto")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(ride ? 0.7 : 0.1)
                    .animation(.linear(duration: 3))
                    
                tableMoto(motorcycle: motorcycle)
                    .padding(.horizontal, 30.0)
                    .padding(.bottom, 15.0)
            }
            
            
            
        }
        .onAppear{ride = true}
    }
        
}
struct tableMoto: View{
    @ObservedObject var motorcycle: MotorcycleModel;
    @Environment(\.colorScheme) var colorScheme
    var body: some View{
        VStack {
            List{
                HStack{
                    Text("Marka pojazdu")
                    Spacer()
                    Text(motorcycle.getBrand())
                }

                HStack{
                    Text("Model pojazdu")
                    Spacer()
                    Text(motorcycle.getModel())
                }

                HStack{
                    Text("Rok produkcji")
                    Spacer()
                    Text(String(motorcycle.getProductionyear()))

                }
                HStack{
                    Text("Aktualny przebieg")
                    Spacer()
                    Text(String(motorcycle.getMillage()))
                }
                HStack{
                    Text("Numer rejestracyjny")
                    Spacer()
                    Text(motorcycle.getRegistrationNumber())

                }

                HStack{
                    Text("Numer VIN")
                    Spacer()
                    Text(motorcycle.getVINNumber())
                }

            }
            .background(colorScheme == .dark ? Color.black: Color.white)
            .scrollContentBackground(.hidden)
        }
    }
}

//struct TableView_Previews: PreviewProvider {
 //   static var previews: some View {
  //      TableView(motorcycle: moto);
   // }
//}
