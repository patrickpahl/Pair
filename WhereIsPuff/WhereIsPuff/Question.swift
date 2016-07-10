//
//  Question.swift
//  WhereIsPuff
//
//  Created by Patrick Pahl on 7/8/16.
//  Copyright © 2016 Patrick Pahl. All rights reserved.
//

import Foundation
import MapKit


class Question: NSObject {
    
    let name: String
    let imageName: String
    let wrongAnswer1: String
    let wrongAnswer2: String
    let correctAnswer: String
    let coordinates: CLLocationCoordinate2D
    let region: CLRegion
    
    init(name: String, wrongAnswer1: String, wrongAnswer2: String, correctAnswer: String, coordinates: CLLocationCoordinate2D, region: CLRegion){
        
        self.name = name
        self.imageName = name.lowercaseString
        self.wrongAnswer1 = wrongAnswer1
        self.wrongAnswer2 = wrongAnswer2
        self.correctAnswer = correctAnswer
        self.coordinates = coordinates
        self.region = region
    }
}



//MKAnnotation needed?