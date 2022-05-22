//
//  Helpers.swift
//  PokemonDemo
//
//  Created by Park Kangwook on 2022/05/18.
//

import Foundation
///json 파일을 읽기 위한 과정
extension Bundle {
    ///decode라는 함수에 제네릭 사용
    ///<T: Decodable>  에서 T : 플레이스 홀더 타입 (아무거나 다 컴온. 에러 안띄울게), Decodable: T에 대한 특징 설정하는 거 인듯
    func decode<T:Decodable>(file: String) -> T {
        ///guard문 + 옵셔널 바인딩
        ///url이란 상수 설정하고, 이놈이 이런 특징이 있으면 그냥 진행. 만약 빠진게 있다면 (nil) fatalError 띄워라
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode \(file) from bundle.")
        }
        
        return loadedData
    }
    ///decode 함수의 전체적인 흐름
    ///let url = self.url(forResource: file, withExtension: nil)
    ///let data = try? Data(contentsOf: url)
    ///let decoder = JSONDecoder()
    ///let loadedData = try? decoder.decode(T.self, from: data)
    ///return loadedData
    ///만약 순서에서 하나라도 빠진 게 존재하면 fatal Error 띄워라! 를 guard문과 옵셔널 바인딩을 통해 구현함

    ///FetchData라는 이름의 함수에 제네릭 사용
    ///<T: Decodable> 에서 T : 플레이스 홀더, Decodable
    ///매개변수 종류 : url, model, completion, failure
    ///매개변수 타입 설정 시 @escaping() -> () : escaping 클로저 사용
    ///-목적 : 함수를 외부에서 사용하겠다 (원래 안됨. 함수가 선언된 곳에서만 사용될 수 있는데 외부에서도 사용하고 싶음.
    ///-비동기 처리 HTTP 요청 처리시 자주 사용된다
    func FetchData<T: Decodable>(url: String, model: T.Type, completion: @escaping(T) -> (), failure: @escaping(Error) -> ()) {
        guard let url = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                //if there is an error, return the error
                if let error = error { failure(error)}
                return }
            
            do {
                let serverData = try JSONDecoder().decode(T.self, from: data)
                //Return the data successfully from the server
                completion((serverData))
            } catch {
                //if there is an error, return the error
                failure(error)
            }
        }.resume()
    }
}
