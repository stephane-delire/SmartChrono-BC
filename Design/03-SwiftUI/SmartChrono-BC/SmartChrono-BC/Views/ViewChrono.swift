//
//  ViewChrono.swift
//  SmartChrono-BC
//
//  Created by Delire Stéphane on 25/02/2023.
//

import SwiftUI

struct ViewChrono: View {
    
    func stateLogic() {
        var fileURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("project.json"))!
        var data = (try? Data(contentsOf: fileURL))!
        let decoder = JSONDecoder()
        let json = try? decoder.decode([Int: String].self, from: data)
        print(json)
    }
    
    var body: some View {
        VStack{
            
        }
        .onAppear{stateLogic()}
    }
}

struct ViewChrono_Previews: PreviewProvider {
    static var previews: some View {
        ViewChrono()
    }
}
