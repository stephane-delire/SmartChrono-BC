//
//  ViewRecord.swift
//  SmartChrono-BC
//
//  Created by Delire Stéphane on 19/02/2023.
//

import SwiftUI

struct ViewRecord: View {
    @State var records = Record()
    
    //Test function delete when needed
    func test(index:Int){
        print(records.data[index])
    }
    
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
                VStack{
                    ForEach(records.data.indices, id: \.self) { index in
                        HStack {
                            
                            Text("Record \(index) : \(records.data[index]["date"]!) - Project : \(records.data[index]["project"]!) - Duration : \(records.data[index]["duration"]!)" as String)
                            
                            Spacer()
                            
                            Button(action: {
                                records.data.remove(at: index)
                            }){
                                Image(systemName: "trash")
                            }
                        }
                        .onAppear{test(index: index)}
                        .padding()
                    }
                }
                .navigationTitle("Records")
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
