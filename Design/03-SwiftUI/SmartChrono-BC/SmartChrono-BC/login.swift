//
//  login.swift
//  SmartChrono-BC
//
//  Created by Delire Stéphane on 28/02/2023.
//

import SwiftUI

struct login: View {
    
    @State var userLogin:String = ""
    @State var userPassword:String = ""
    
    @State var userShowPassword:Bool = false
    
    func loginToggleShowPassword(){
        if userShowPassword == false {
            userShowPassword = true
        } else {
            userShowPassword = false
        }
    }
    
    var body: some View {
        VStack{
            
            //Image logo
            Image("Logo")
                .resizable()
                .scaledToFit()
            
            HStack{
                Text("Login")
                    .foregroundColor(Color("Greys"))
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .frame(width: 315)
            TextField("Login...", text:$userLogin)
                .padding()
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .overlay(VStack{
                    Divider()
                        .overlay(Color("Greys"))
                        .frame(width: 315)
                        .offset(x:0, y:15)
                        
                })
            
            
            HStack{
                Text("Password")
                    .foregroundColor(Color("Greys"))
                    .multilineTextAlignment(.leading)
                Spacer()
                
                if userShowPassword {
                    Button(action: loginToggleShowPassword){
                        Image(systemName: "eye.slash")
                            .foregroundColor(Color("Turquoise"))
                    }
                } else {
                    Button(action: loginToggleShowPassword){
                        Image(systemName: "eye")
                            .foregroundColor(Color("Turquoise"))
                    }
                }
            }
            .frame(width: 315)
            
            //Show hide password
            if userShowPassword == false {
                SecureField("Password...", text:$userPassword)
                    .padding()
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .overlay(VStack{
                        Divider()
                            .overlay(Color("Greys"))
                            .frame(width: 315)
                            .offset(x:0, y:15)
                            
                    })
            } else {
                TextField("Password...", text: $userPassword)
                    .padding()
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .overlay(VStack{
                        Divider()
                            .overlay(Color("Greys"))
                            .frame(width: 315)
                            .offset(x:0, y:15)
                            
                    })
            }
            
            Button(action: dummy){
                Text("LOGIN")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .background(Color("Turquoise"))
                    .frame(width:315, height: 32)
                    .cornerRadius(16)
                
            }
            .cornerRadius(16)
            .background(Color("Turquoise"))
            .padding(.top, 32)
            
            
            Spacer()
            
        }
        .padding()
        .frame(width: 375)
    }
}

struct login_Previews: PreviewProvider {
    static var previews: some View {
        login()
    }
}
