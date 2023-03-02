//
//  ViewRecord.swift
//  SmartChrono-BC
//
//  Created by Delire Stéphane on 19/02/2023.
//

import SwiftUI

struct ViewRecord: View {
    @ObservedObject var records: Record
    

    //Test function delete when needed
    func test(index:Int){
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
                                records.saveData()
                            }){
                                Image(systemName: "trash")
                            }
                        }
                        .onAppear{}
                        .padding()
                    }
                 
                }
                .navigationTitle("Records")
            }
        }
        .onAppear{}
    }
}

struct ViewRecord_Previews: PreviewProvider {
    static var previews: some View {
        ViewRecord(records: Record())
    }
}
