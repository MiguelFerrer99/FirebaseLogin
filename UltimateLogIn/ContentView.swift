//
//  ContentView.swift
//  UltimateLogIn
//
//  Created by Miguel Ferrer Fornali on 23/11/2020.
//

import SwiftUI

struct ContentView: View {
    
    @State var logueado = false
    
    var body: some View {
        
        ZStack {
            if logueado {
                Inicio(logueado: self.$logueado)
            } else {
                Login(logueado: self.$logueado)
            }
        }.animation(.linear)
        .onAppear {
            if UserDefaults.standard.object(forKey: "logueado") != nil {
                logueado = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
