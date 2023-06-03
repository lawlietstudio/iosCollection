//
//  ListVIew.swift
//  AllInOneReference
//
//  Created by mark on 2023-05-19.
//

import SwiftUI

struct ListVIew: View {
    let sampleArray = ["one", "Two", "Three"]
    var items = ["Item 1", "Item 2", "Item 3"]
    let sampleModelArray = [SampleModel(sampleField: "1"), SampleModel(sampleField: "2", secondField: "二"), SampleModel(sampleField: "3")]

    var body: some View {
        VStack {
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
            ForEach(0..<sampleModelArray.count, id: \.self) {
                Text(sampleModelArray[$0].secondField ?? "not exist")
            }
            Divider()
            Divider()
            List(items, id: \.self) { item in
                Text(item)
            }
        }
    }
}

struct ListVIew_Previews: PreviewProvider {
    static var previews: some View {
        ListVIew()
    }
}
