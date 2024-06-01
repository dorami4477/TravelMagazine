//
//  CustomAnnotation.swift
//  TravelMagazine
//
//  Created by 박다현 on 5/30/24.
//

import Foundation
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    @objc dynamic var coordinate: CLLocationCoordinate2D

    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
