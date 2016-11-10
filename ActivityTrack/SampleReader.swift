//
//  SampleReader.swift
//  ActivityTrack
//
//  Created by Daniel Holzmann on 03.11.16.
//  Copyright © 2016 Daniel Holzmann. All rights reserved.
//

import UIKit

class SampleReader: NSObject {
    
    static func readDataFromFile(file:String) -> String!{
        var heartRates = [String]()
        var myStrings = [String]()
        var counter = 0;
        if let path = Bundle.main.path(forResource: file, ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .ascii)
                 myStrings = data.components(separatedBy: .newlines)
                print(myStrings.joined(separator: ", "))
            } catch {
                print(error)
            }
        }
        for str in myStrings {
            if counter % 2 == 0 {
               let lineVals = str.components(separatedBy: ",")
                heartRates.append(lineVals[2])
                print(lineVals[2])
            }
        }
        
        
        
        guard let filepath = Bundle.main.path(forResource: "lichtenberg", ofType: "txt")
            else {
                return nil
        }
        do {
            let contents = try String(contentsOfFile: filepath)
            return contents
        } catch {
            print("File Read Error for file \(filepath)")
            return nil
        }
        
    }

}
