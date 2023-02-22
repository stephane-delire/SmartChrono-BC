//
//  AskPsw.swift
//  SmartChrono-BC
//
//  Created by Delire Stéphane on 22/02/2023.
//

import SwiftUI

struct AskPsw: View {
    
    @State var password:String = ""
    
    var body: some View {
        NavigationView{
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
                
                Button(action: { dummy() }) {
                    Image(systemName: "arrow.forward")
                        .foregroundColor(Color.black)
                        .font(.system(size: 30))
                }
                .frame(width: 75, height: 75)
                .background(Color("backgroundButton"))
                .clipShape(Circle())
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct AskPsw_Previews: PreviewProvider {
    static var previews: some View {
        AskPsw()
    }
}
