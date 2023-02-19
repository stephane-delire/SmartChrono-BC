//
//  HelpBox.swift
//  SmartChrono-BC
//
//  Created by Delire Stéphane on 19/02/2023.
//

import SwiftUI

struct HelpBox: View {
    var body: some View {
        VStack(spacing: 0) {
            // Premier container
            HStack {
                Image("Burniaux Consulting")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
                    .padding(.leading, 16)
                Spacer()
            }
            .background(Color.white)
            
            // Deuxième container
            HStack {
                Spacer()
                Text("Un petit texte 😁")
                    .foregroundColor(Color.white)
                    .frame(height:100)
                    .background(Color(red: 53/255, green: 151/255, blue: 156/255))
                    .font(.headline)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .frame(width: .infinity)
            .background(Color(red: 53/255, green: 151/255, blue: 156/255))
            
            // Troisième container
            HStack {
                Spacer()
                Text("✉️ Francois @ burniaux.com \n📞 +32 486 895 990")
                    .foregroundColor(Color(red: 53/255, green: 151/255, blue: 156/255))
                    .frame(height:100)
                    .background(Color(red: 56/255, green: 62/255, blue: 69/255))
                    .font(.headline)
                    .multilineTextAlignment(.trailing)
                    .padding(.trailing, 16)
            }
            .frame(width: .infinity)
            .background(Color(red: 56/255, green: 62/255, blue: 69/255))
        }
    }
}

struct HelpBox_Previews: PreviewProvider {
    static var previews: some View {
        HelpBox()
    }
}
