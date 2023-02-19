//
//  ViewRecord.swift
//  SmartChrono-BC
//
//  Created by Delire Stéphane on 19/02/2023.
//

import SwiftUI

struct ViewRecord: View {
    @State var records = Record()
    
    var body: some View {
        NavigationView{
            if records.data.isEmpty {
                VStack{
                    Text("No records")
                        .font(.title2)
                        .padding(.bottom, 50)
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(Color.green)
                        .font(.system(size: 50))
                }
                .navigationTitle("Records")
            } else {
                ForEach(records.data.indices, id: \.self) { index in
                    HStack {
                        Text("Record \(index + 1) : \(records.data[index].description)")
                        Button(action: {
                            records.data.remove(at: index)
                        }){
                            Image(systemName: "trash")
                        }
                    }
                    .navigationTitle("Records")
                }
            }
        }
    }
}

struct ViewRecord_Previews: PreviewProvider {
    static var previews: some View {
        ViewRecord()
    }
}


/*
 struct RecordsView: View {
     @State var records = Records()
     
     var body: some View {
         if records.data.isEmpty {
             Text("No records")
         } else {
             ForEach(records.data.indices, id: \.self) { index in
                 HStack {
                     Text("Record \(index + 1): \(records.data[index])")
                     Button("Delete") {
                         records.data.remove(at: index)
                     }
                 }
             }
         }
     }
 }

 */
