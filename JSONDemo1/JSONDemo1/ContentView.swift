//
//  ContentView.swift
//  JSONDemo1
//
//  Created by Park Kangwook on 2022/05/14.
//

import SwiftUI

struct ContentView: View {
    ///Person의 allPeople을 가져와야함. 왜냐하면 allPeople이 JSON을 불러온 데이터라서.
    private var people: [Person] = Person.allPeople
    
    var body: some View {
        NavigationView{
            List{
                                ///model에서 id값을 따로 지정하지 않았기 때문에 여기서 설정. id를 firstName의 value로 쓰겠다는 말
                ForEach(people, id: \.firstName) { person in
                    NavigationLink(destination: DetailView(person: person)){
                        VStack(alignment: .leading) {
                            Text("\(person.firstName) \(person.surname)")
                            Text("\(person.phoneNumbers[0].number)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                    }
                    
                }
            }.navigationTitle("PhoneBook")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
