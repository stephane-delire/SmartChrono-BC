//
//  BtnBar.swift
//  SmartChrono-BC
//
//  Created by Delire Stéphane on 19/02/2023.
//

import SwiftUI

struct BtnBar: View {
    var body: some View {
        TabView{
            ViewChrono()
                .tabItem {
                    Image(systemName:"timer")
                    Text("Chrono")
                }
            ViewSync()
                .tabItem{
                    Image(systemName:"icloud")
                    Text("Sync")
                }
            ViewRecord()
                .tabItem{
                    Image(systemName:"folder")
                    Text("Record")
                }
            ViewSettings()
                .tabItem{
                    Image(systemName:"gear")
                    Text("Settings")
                }
            ViewHelp()
                .tabItem{
                    Image(systemName:"questionmark.circle")
                    Text("Help")
                }
        }
    }
}

struct BtnBar_Previews: PreviewProvider {
    static var previews: some View {
        BtnBar()
    }
}
