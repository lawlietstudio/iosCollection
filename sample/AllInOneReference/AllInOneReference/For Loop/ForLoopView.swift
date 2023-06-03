//
//  ForLoopView.swift
//  AllInOneReference
//
//  Created by mark on 2023-05-19.
//

import SwiftUI

struct SampleModel: Identifiable, Hashable {
    var id: String
    {
        return sampleField
    }
    
    var sampleField: String
    var secondField: String?
}

struct ForLoopView: View {
    let sampleArray = ["one", "Two", "Three"]
    let sampleModelArray = [SampleModel(sampleField: "1"), SampleModel(sampleField: "2", secondField: "二"), SampleModel(sampleField: "3")]
    var items = ["Item 1", "Item 2", "Item 3"]
    
    var body: some View {
        VStack
        {
            
//            Button("click") {
//                loopingArray()
//            }
//            Divider()
            // (1)
            ForEach(sampleArray, id: \.self) {
                item in
                Text(item)
            }
            Divider()
            // (2)
            ForEach(0..<sampleArray.count, id: \.self) {
                Text(sampleArray[$0])
            }
            Divider()
            // (3)
            // https://www.hackingwithswift.com/forums/swiftui/compiler-warning-non-constant-range-argument-must-be-an-integer-literal/14878
            ForEach(sampleArray.indices, id: \.self) {
              Text(sampleArray[$0])
            }
            Divider()
            ForEach(sampleModelArray, id: \.self) {
                item in
                Text(item.sampleField)
            }
            Divider()
            ForEach(0..<sampleModelArray.count, id: \.self) {
                Text(sampleModelArray[$0].secondField ?? "not exist")
            }
            List(items, id: \.self) { item in
                Text(item)
            }
//            List(sampleArray, id: \.self) { array in
//                Text(array)
//            }
//            List(sampleArray, id: \.self) { item in
//                        Text(item)
//                    }
        }
    }
    
    func loopingArray()
    {
        for item in sampleArray
        {
            print(item)
        }
        for index in 0..<sampleArray.count
        {
            print(sampleArray[index])
        }
    }
}

struct ForLoopView_Previews: PreviewProvider {
    static var previews: some View {
        ForLoopView()
    }
}
