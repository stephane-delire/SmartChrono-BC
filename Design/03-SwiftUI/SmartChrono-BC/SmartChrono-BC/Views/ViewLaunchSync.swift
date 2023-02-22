//
//  ViewLaunchSync.swift
//  SmartChrono-BC
//
//  Created by Delire Stéphane on 22/02/2023.
//

import SwiftUI

struct ViewLaunchSync: View {
    @State private var stateManage: Int = 0
    @State private var password: String = ""
    
    var body: some View {
        if stateManage == 0 {
            VStack {
                Text("Password")
                    .font(.title)
                    .padding(.bottom, -15)
                TextField("", text: $password)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.primary))
                    .padding()
                Text("Enter your password to connect to the Odoo server")
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .padding(.top, -15)
                
                Button(action: { stateManage += 1 }) {
                    Image(systemName: "arrow.forward")
                        .foregroundColor(Color.black)
                        .font(.system(size: 30))
                }
                .frame(width: 75, height: 75)
                .background(Color("backgroundButton"))
                .clipShape(Circle())
            }
        } else {
            VStack {
                if stateManage == 1 {
                        Text("Loading settings")
                        let settings = Settings()
                        stateManage += 1
                }
                if stateManage == 2 {
                    Text("2")
                }
                ProgressView()
            }
        }
    }
}


struct ViewLaunchSync_Previews: PreviewProvider {
    static var previews: some View {
        ViewLaunchSync()
    }
}
