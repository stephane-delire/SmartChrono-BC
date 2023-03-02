//
//  login.swift
//  SmartChrono-BC
//
//  Created by Delire Stéphane on 28/02/2023.
//

import SwiftUI
import Alamofire

struct login: View {
    
    @StateObject var record = Record()
    
    @State var userLogin:String = ""
    @State var userPassword:String = ""
    @State var userSettingUrl:String = ""
    @State var userSettingDB:String = ""
    
    @State var userShowPassword:Bool = false
    
    @State var loginState:Int = 0
    // 0 : Login
    // 1 : Settings
    // 2 : Working Settings
    // 3 : Error saving settings
    // 4 : Settings recorded
    // 5 : Try To authenticate
    // 6 : Success
    // 7 : Error authentication
    // TODO : Error URL
    
    // Obj
    var user = User()
    var settings = Settings()

//-----------------------------------------
    func loginToggleShowPassword(){
        if userShowPassword == false {
            userShowPassword = true
        } else {
            userShowPassword = false
        }
    }
    
    func hapticVibrateSuccess(){
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
    func hapticVibrateError(){
        UINotificationFeedbackGenerator().notificationOccurred(.error)
    }
    
    //Switch view
    func loginSwitchToMain(){
        loginState = 0
    }
    func loginSwitchToSettings(){
        loginState = 1
    }
    func loginSwitchToWorkingSettings(){
        loginState = 2
    }
    func loginSwitchToErrorSettings(){
        loginState = 3
    }
    func loginSwitchToSuccessSettings(){
        loginState = 4
    }
    func loginSwitchToTryAuthenticate(){
        user.login = userLogin
        user.saveUser()
        loginState = 5
    }
    func loginSwitchToSuccessAuthenticate(){
        loginState = 6
    }
    func loginSwitchToErrorAuthenticate(){
        loginState = 7
    }
    
    
//---Functions------------------------------
    // RetrieveAndUpdateSettings
    func retrieveAndUpdateSettings(){
        // Reload OBJ
        settings.reload()
        // Restate var
        userSettingUrl = settings.url
        userSettingDB = settings.DB
    }
    func saveSettings(){
        // Insert textfield value into object
        settings.url = userSettingUrl
        settings.DB = userSettingDB
        settings.saveSettings()
        loginState = 4
    }
    // RetrieveUserLogin
    func retrieveUserLogin(){
        user.reload()
        userLogin = user.login
    }
    // Authentication
    func tryToAuthenticate(){
        // Saving User's data
        user.login = userLogin
        user.password = userPassword
        user.saveUser()
        
        // Making request
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "User-Agent": "SmartChrono",
            "Connection": "keep-alive"
        ]
        let parameters: Parameters = [
            "jsonrpc": "2.0",
            "params": [
                "service": "common",
                "method": "login",
                "args": [settings.DB, user.login, user.password]
            ]
        ]
        
        AF.request(settings.url + "/jsonrpc", method: .post, parameters: parameters,encoding: JSONEncoding.prettyPrinted, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let json = value as? [String: Any] {
                        print("!Success JSON-RPC!")
                        if let result = json["result"] as? Int {user.id = result}
                        else {user.id = 0}
                        print("Retrieve user id : \(user.id)")
                        
                        if(user.id == 0){
                            print("error authenticate...")
                            loginSwitchToErrorAuthenticate()
                            return
                        }
                        else {
                            // Save user id for later use
                            user.saveUser()
                            // Switch view
                            loginSwitchToSuccessAuthenticate()
                        }
                    }
                case .failure(let error):
                    print(error)
                    loginSwitchToErrorAuthenticate()
                    return
                }
            }
    }
    
    var body: some View {
        //Login page
        if loginState == 0 {
            Group{
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
                    .padding(.bottom, -10)
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
                    .padding(.bottom, -10)
                    
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
                    
                    Button(action: loginSwitchToTryAuthenticate){
                        Text("LOGIN")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                            .background(Color("Turquoise"))
                            .frame(width:315, height: 32)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.white, lineWidth: 0)
                            )
                        
                    }
                    .background(Color("Turquoise"))
                    .cornerRadius(12)
                    .padding(.top, 32)
                    
                    Button(action: loginSwitchToSettings ){
                        Image(systemName: "gear")
                            .foregroundColor(Color.white)
                            .background(Color("Greys"))
                            .frame(width: 315, height: 32)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.white, lineWidth: 0)
                            )
                    }
                    .background(Color("Greys"))
                    .cornerRadius(12)
                    
                    Spacer()
                    
                }
                .padding()
                .frame(width: 375)
                .onAppear{
                    retrieveUserLogin()
                }
            }
        }
        
        // Settings
        if loginState == 1 {
            Group {
                VStack {
                    //Image logo
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                    
                    
                    HStack{
                        Text("Url")
                            .foregroundColor(Color("Greys"))
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    .frame(width: 315)
                    .padding(.bottom, -10)
                    
                    TextField("Url...", text:$userSettingUrl)
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
                        Text("Database")
                            .foregroundColor(Color("Greys"))
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    .frame(width: 315)
                    .padding(.bottom, -10)
                    
                    TextField("Url...", text:$userSettingDB)
                        .padding()
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .overlay(VStack{
                            Divider()
                                .overlay(Color("Greys"))
                                .frame(width: 315)
                                .offset(x:0, y:15)
                            
                        })
                    
                    Button(action: loginSwitchToWorkingSettings){
                        Text("SAVE")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                            .background(Color("Turquoise"))
                            .frame(width:315, height: 32)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.white, lineWidth: 0)
                            )
                        
                    }
                    .background(Color("Turquoise"))
                    .cornerRadius(12)
                    .padding(.top, 32)
                    
                    Button(action: loginSwitchToMain){
                        Image(systemName: "arrow.backward")
                            .foregroundColor(Color.white)
                            .background(Color("Greys"))
                            .frame(width: 315, height: 32)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.white, lineWidth: 0)
                            )
                    }
                    .background(Color("Greys"))
                    .cornerRadius(12)
                    
                    Spacer()
                }
                .padding()
                .frame(width: 375)
                .onAppear{
                    retrieveAndUpdateSettings()
                }
            }
        }
        
        // Working Settings
        if loginState == 2 {
            Group{
                VStack{
                    //Image logo
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                    
                    ProgressView()
                    
                    Spacer()
                }
                .padding()
                .frame(width: 375)
            }
            .onAppear{
                saveSettings()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    loginState = 4
                }
            }
        }
        
        // Error saving Settings
        if loginState == 3 {
            Group{
                VStack{
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                    
                    Spacer()
                    
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 40))
                        .foregroundColor(Color.red)
                    Text("Unable to save settings.")
                        .foregroundColor(Color.red)
                    
                    Button(action: loginSwitchToMain){
                        Image(systemName: "arrow.backward")
                            .foregroundColor(Color.white)
                            .background(Color("Greys"))
                            .frame(width: 315, height: 32)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.white, lineWidth: 0)
                            )
                    }
                    .background(Color("Greys"))
                    .cornerRadius(12)
                    
                    Spacer()
                }
                .padding()
                .frame(width: 375)
                .onAppear{hapticVibrateError()}
            }
        }
        
        // Success saving settings
        if loginState == 4 {
            Group{
                VStack{
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                    
                    Image(systemName: "checkmark.circle")
                        .font(.system(size: 40))
                        .foregroundColor(Color("Turquoise"))
                    Text("Settings saved.")
                    
                    Spacer()
                    
                    Button(action: loginSwitchToMain){
                        Image(systemName: "arrow.backward")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                            .background(Color("Greys"))
                            .frame(width:315, height: 32)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.white, lineWidth: 0)
                            )
                        
                    }
                    .background(Color("Greys"))
                    .cornerRadius(12)
                    .padding(.top, 32)
                    
                    Spacer()
                    
                }
                .padding()
                .frame(width: 375)
                .onAppear{hapticVibrateSuccess()}
            }
        }
        
        // Authenticate
        if loginState == 5 {
            Group{
                VStack{
                    //Image logo
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                    
                    ProgressView()
                    
                    //Spacer()
                    
                    Text("Authentication.")
                        .foregroundColor(Color("Greys"))
                    
                    Spacer()
                }
                .padding()
                .frame(width: 375)
                .onAppear{tryToAuthenticate()}
            }
        }
        
        // Error authentication
        if loginState == 7 {
            Group{
                VStack{
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                    
                    Spacer()
                    
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 40))
                        .foregroundColor(Color.red)
                    Text("Identification problem.\nPlease check your Login and Password.")
                        .foregroundColor(Color.red)
                        .multilineTextAlignment(.center)
                    
                    Button(action: loginSwitchToMain){
                        Image(systemName: "arrow.backward")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                            .background(Color("Greys"))
                            .frame(width:315, height: 32)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.white, lineWidth: 0)
                            )
                        
                    }
                    .background(Color("Greys"))
                    .cornerRadius(12)
                    .padding(.top, 32)
                    
                    Spacer()
                }
                .padding()
                .frame(width: 375)
                .onAppear{hapticVibrateError()}
            }
        }
        
        // Success authentication
        if loginState == 6 {
            Group{
                VStack{
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                    
                    Image(systemName: "person.crop.circle.badge.checkmark")
                        .font(.system(size: 40))
                        .foregroundColor(Color("Turquoise"))
                    Text("Success.")
                    
                    
                    Spacer()
                    
                    ProgressView()
                    
                    Spacer()
                    
                }
                .padding()
                .frame(width: 375)
                .onAppear{
                    hapticVibrateSuccess()
                    //loginState = 8
                    //On laisse un peu de temps pour afficher le bel écran que j'ai mit du temps à coder
                    //Mine de rien c'est ultra rapide...
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        loginState = 8
                    }
                }
                
            }
        }
        
        // TabView - BtnBar integration
        if loginState == 8 {
            TabView{
                ViewChrono(record:record)
                    .tabItem {
                        Image(systemName:"timer")
                        Text("Chrono")
                    }
                ViewSync()
                    .tabItem{
                        Image(systemName:"icloud")
                        Text("Sync")
                    }
                ViewRecord(records:record)
                    .tabItem{
                        Image(systemName:"folder")
                        Text("Record")
                    }
                ViewHelp()
                    .tabItem{
                        Image(systemName:"questionmark.circle")
                        Text("Help")
                    }
            }//End TabView
        }
    }//End view
}//End Struct

struct login_Previews: PreviewProvider {
    static var previews: some View {
        login()
    }
}
