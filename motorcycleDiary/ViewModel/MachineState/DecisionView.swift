//
//  decisionView.swift
//  motorcycleDiary
//
//  Created by Konrad Tęgowski on 01/02/2023.
//

import SwiftUI

struct DecisionView: View {
    @State var moto: MotorcycleModel?;
    @Binding var whatView: Bool;
    var body: some View {
        if(!whatView){
            newMotorcycleView(whatView: $whatView, moto: $moto)
        }
        else{
            MainView(moto: moto!, whatView: $whatView)
        }
    }
}
