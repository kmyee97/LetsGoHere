//
//  places.swift
//  LetsGoHere
//
//  Created by Kahlil Yee on 11/17/19.
//  Copyright © 2019 Kahlil Yee. All rights reserved.
//

import Foundation

class places
{
    // dictionary that stores place records
    var places : [Int:placerecord] = [Int:placerecord] ()
    init(){}
    func add(_ theName:String, _ loc1:String, _ loc2:String, _ index:Int, _ address:String, _ zipcode:String, _ city:String, _ state:String)
    {
        let pRecord =  placerecord(n: theName, la: loc1, lo: loc2, ad: address, z: zipcode, c: city, s: state)
        places[index] = pRecord
        
    }
    func getDict() -> [Int:placerecord]
    {
        return places
    }
    func getCount() -> Int
    {
        return places.count
    }
}
