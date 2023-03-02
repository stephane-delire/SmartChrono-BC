//
//  BtnBar.swift
//  SmartChrono-BC
//
//  Created by Delire Stéphane on 19/02/2023.
//

import SwiftUI

struct BtnBar: View {
    
    @StateObject var record = Record()
    
    var body: some View {
        
        TabView{
            ViewChrono(record:record)
                .tabItem {
                    Image(systemName:"timer")
                    Text("Chrono")
                }
            ViewSync(record:record)
                .tabItem{
                    Image(systemName:"icloud")
                    Text("Sync")
                }
            ViewRecord(records:record)
                .tabItem{
                    Image(systemName:"folder")
                    Text("Record")
                }
            /*ViewSettings()
             .tabItem{
             Image(systemName:"gear")
             Text("Settings")
             }*/
            ViewHelp()
                .tabItem{
                    Image(systemName:"questionmark.circle")
                    Text("Help")
                }
        }//End TabView

    }
}

struct BtnBar_Previews: PreviewProvider {
    static var previews: some View {
        BtnBar()
    }
}
