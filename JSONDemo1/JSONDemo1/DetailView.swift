//
//  DetailView.swift
//  JSONDemo1
//
//  Created by Park Kangwook on 2022/05/14.
//

import SwiftUI

struct DetailView: View {
    var person: Person
    var body: some View {
        VStack{
            Text("\(person.firstName) \(person.surname)")
                .bold()
            Text("\(person.gender)")
            Text("\(person.age)")
            Text("\(person.address.city)")
            Text("\(person.phoneNumbers[0].number)")
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(person: Person.sampleData)
    }
}
