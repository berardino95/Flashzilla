//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by CHIARELLO Berardino - ADECCO on 08/05/23.
//

import Foundation

//Adding a function in Bundle class that can locate the file, load the file and decode the data
extension Bundle{
        
    //<T> means we want to make a generic method. In this case T must conforme to Decodable because we can use only Decodable struct to decode data. The method return some T (type). We can use T whenever we want use generic passed in the function.
    func decode<T: Decodable>(_ file: String) -> T {
        //creating url to retrive file from bundle
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        //loading file with url
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle")
        }
        
        let decoder = JSONDecoder()
        
        //Decode data from json
        guard let decodedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode")
        }
        
        return decodedData
    }
    
}
