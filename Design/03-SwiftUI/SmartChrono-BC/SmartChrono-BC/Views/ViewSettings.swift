//
//  ViewSettings.swift
//  SmartChrono-BC
//
//  Created by Delire Stéphane on 19/02/2023.
//

import SwiftUI

struct ViewSettings: View {
    
    @State private var userInput: String = ""
    
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    Text("URL")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.bottom, -15)
                    
                    TextField("", text: $userInput)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.primary))
                        .padding()
                    Text("Indicate the URL address to the Odoo server.")
                        .font(.caption)
                        .padding(.top, -15)
                }
                .padding(.bottom, 15)
                VStack{
                    Text("Login")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.bottom, -15)
                    
                    TextField("", text: $userInput)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.primary))
                        .padding()
                    Text("Indicate the login provided by the administrator.")
                        .font(.caption)
                        .padding(.top, -15)
                }
                .padding(.bottom, 15)
                
                VStack{
                    Text("Table name")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.bottom, -15)
                    
                    TextField("", text: $userInput)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.primary))
                        .padding()
                    Text("Indicate the DataBase table name.")
                        .font(.caption)
                        .padding(.top, -15)
                }
                .padding(.bottom, 15)
                
                Button(action: dummy){
                    Image(systemName:"square.and.arrow.down")
                        .foregroundColor(Color.black)
                        .font(.system(size: 30))
                }
                .frame(width: 75, height: 75)
                .background(Color("backgroundButton"))
                .clipShape(Circle())
            }
            .navigationTitle("Settings")
        }
    }
}

struct ViewSettings_Previews: PreviewProvider {
    static var previews: some View {
        ViewSettings()
    }
}
