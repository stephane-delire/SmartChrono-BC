//
//  SyncManager.swift
//  SmartChrono-BC
//
//  Created by Delire Stéphane on 22/02/2023.
//

import SwiftUI
import Foundation

var syncState:Int = 0
var settings:Settings?

func launchSync() {
    syncState = 0
    settings = Settings()
    syncState = 1
}


struct SyncManager: View {
    
    @State var count = 0
    
    var body: some View{
        Text("count : " + String(count))
            .onAppear{
                let Timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){
                    _ in count += 1
                }
            }
    }
}

struct SyncManager_Previews: PreviewProvider {
    static var previews: some View {
        SyncManager()
    }
}
