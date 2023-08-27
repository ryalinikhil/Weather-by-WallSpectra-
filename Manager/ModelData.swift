//
//  ModelData.swift
//  TestWeather
//
//  Created by Sameer Nikhil on 26/08/23.
//

import Foundation


var previewWeather: ResponseBody = load("weatherdata.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}


 var previewWeather2: ResponseBody = load2("weatherdata.json")

 func load2<T: Decodable>(_ filename: String) -> T {
     let data: Data

     guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
         else {
             fatalError("Couldn't find \(filename) in main bundle.")
     }

     do {
         data = try Data(contentsOf: file)
     } catch {
         fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
     }

     do {
         let decoder = JSONDecoder()
         return try decoder.decode(T.self, from: data)
     } catch {
         fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
     }
 }

