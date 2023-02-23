//
//  ViewSettings.swift
//  SmartChrono-BC
//
//  Created by Delire Stéphane on 19/02/2023.
//

import SwiftUI

struct ViewSettings: View {
    
    var settings = Settings()
    
    @State var inputURL:String = ""
    @State var inputlogin:String = ""
    @State var inputDB:String = ""
    
    @State var saveState:Bool = false
    
    func initializeView(){
        inputURL = settings.url
        inputlogin = settings.login
        inputDB = settings.DB
        saveState = false
    }
    
    func saveSettings(){
        settings.url = inputURL
        settings.login = inputlogin
        settings.DB = inputDB
        
        settings.saveSettings()
        saveState = true
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
    
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    Text("URL")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.bottom, -15)
                    
                    TextField("", text: $inputURL)
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
                    
                    TextField("", text: $inputlogin)
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
                    Text("Database name")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.bottom, -15)
                    
                    TextField("", text: $inputDB)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.primary))
                        .padding()
                    Text("Indicate the DataBase name.")
                        .font(.caption)
                        .padding(.top, -15)
                }
                .padding(.bottom, 15)
                
                Button(action: saveSettings){
                    if(saveState == false){
                        Image(systemName:"square.and.arrow.down")
                            .foregroundColor(Color.black)
                            .font(.system(size: 30))
                    } else {
                        Image(systemName: "checkmark")
                            .foregroundColor(Color.green)
                            .font(.system(size: 30))
                    }
                }
                .frame(width: 75, height: 75)
                .background(Color("backgroundButton"))
                .clipShape(Circle())
            }
            .navigationTitle("Settings")
        }
        .onAppear{initializeView()}
    }
}

struct ViewSettings_Previews: PreviewProvider {
    static var previews: some View {
        ViewSettings()
    }
}
