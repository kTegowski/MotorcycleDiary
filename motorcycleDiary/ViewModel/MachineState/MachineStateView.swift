//
//  MachineStateView.swift
//  motorcycleDiary
//
//  Created by Konrad Tęgowski on 31/01/2023.
//

import SwiftUI

struct MachineStateView: View {
    @State private var isLoading = false
    @State private var whatView:Bool = false;
    var moto = try! readFromFile(filename: "backup.json")
    let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    var body: some View {
        if(moto != nil || moto?.getModel() != ""){
            @State var whatView = true
            return DecisionView(moto: moto!, whatView: $whatView)
        }
        return DecisionView(moto: moto, whatView: $whatView)
        
    }
    
    
    
}
    
    
func readFromFile(filename fileName: String) throws -> MotorcycleModel?{
    
   if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        do {
            let fileURL = dir.appendingPathComponent(fileName)
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(MotorcycleModel.self, from: data)
            return jsonData
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}
