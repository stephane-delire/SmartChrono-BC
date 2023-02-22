//
//  ViewSync.swift
//  SmartChrono-BC
//
//  Created by Delire Stéphane on 22/02/2023.
//

import SwiftUI

struct ViewSync: View {
    var body: some View {
            NavigationView{
                VStack{
                    Text("Sync")
                        .font(.title)
                    NavigationLink(destination: {ViewLaunchSync()},label:{
                        VStack{
                            Image(systemName: "icloud.and.arrow.up")
                                .foregroundColor(Color.black)
                                .font(.system(size: 30))
                        }
                        .frame(width: 75, height: 75)
                        .background(Color("backgroundButton"))
                        .clipShape(Circle())
                    })
                    Text("Press the button to synchronize projects and tasks, and send recorded data if present.")
                        .font(.caption)
                        .multilineTextAlignment(.center)
                }
        }
    }
}

struct ViewSync_Previews: PreviewProvider {
    static var previews: some View {
        ViewSync()
    }
}
