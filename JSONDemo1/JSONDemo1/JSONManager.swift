//
//  JSONManager.swift
//  JSONDemo1
//
//  Created by Park Kangwook on 2022/05/14.
//

import Foundation

///이거 만들 때 Quicktype 사이트 쓰면 자동으로 코드 생성해줌. 하나씩 손으로 칠 필요 X
struct Person: Codable {
    let firstName, surname, gender: String
    let age: Int
    let address: Address
    let phoneNumbers: [PhoneNumber]
    
    static let allPeople: [Person] = Bundle.main.decode(file: "example.json")
    ///코딩하면서 유용하게 볼 sample data를 만들어줌
    static let sampleData: Person = allPeople[0]
}

struct Address: Codable {
    let streetAddress, city, state, postalCode: String
}

struct PhoneNumber: Codable {
    let type, number: String
}

// MARK: Decoder
///이걸 해줬기 때문에 우린 JSON의 데이터를 읽을 수 있다고 함
extension Bundle {
    func decode<T: Decodable>(file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find \(file) in the project!")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load \(file) in the project!")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode \(file) in the project!")
        }
        ///Bundle의 decode 함수를 통해서 어쨌든 loadedData가 나온다! 
        return loadedData
    }
}
