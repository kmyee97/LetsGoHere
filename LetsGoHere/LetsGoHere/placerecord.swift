//
//  placerecord.swift
//  LetsGoHere
//
//  Created by Kahlil Yee on 11/17/19.
//  Copyright © 2019 Kahlil Yee. All rights reserved.
//

import Foundation
class placerecord
{
    var name:String? = nil
    var lat:String? = nil
    var long:String? = nil
    var addy:String? = nil
    var zip:String? = nil
    var city:String? = nil
    var state:String? = nil
    
    init(n:String, la:String, lo:String, ad:String, z:String, c:String, s:String) {
        self.name = n
        self.lat = la
        self.long = lo
        self.addy = ad
        self.zip = z
        self.city = c
        self.state = s
    }
}
