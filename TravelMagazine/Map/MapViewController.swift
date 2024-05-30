//
//  MapViewController.swift
//  TravelMagazine
//
//  Created by 박다현 on 5/30/24.
//

import UIKit
import MapKit

class MapViewController: UIViewController{

    var restaurantData:[Restaurant]?{
        didSet{
            selectedData = restaurantData
        }
    }
    var selectedData:[Restaurant]?
    var annotations: [MKAnnotation] = []
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNav()
        configureMap()
        makeAnnotaion()
    }

    
    func configureNav(){
        let filter = UIBarButtonItem(title: "filter", style: .plain, target: self, action: #selector(filterButtonClicked))
        navigationItem.rightBarButtonItem = filter
    }

    //필터 액션
    @objc func filterButtonClicked(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let all = UIAlertAction(title: "전체보기", style: .default){ action in
            self.mapView.removeAnnotations(self.annotations)
            self.selectedData = self.restaurantData
            self.makeAnnotaion()
            self.mapView.addAnnotations(self.annotations)

        }
        let korean = UIAlertAction(title: "한식", style: .default){ action in
            alertAction(action)
        }
        let cafe = UIAlertAction(title: "카페", style: .default){ action in
            alertAction(action)
        }
        let chinese = UIAlertAction(title: "중식", style: .default){ action in
            alertAction(action)
        }
        let japanese = UIAlertAction(title: "일식", style: .default){ action in
            alertAction(action)
        }
        let snack = UIAlertAction(title: "분식", style: .default){ action in
            alertAction(action)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        func alertAction(_ sender:UIAlertAction){
            self.mapView.removeAnnotations(self.annotations)
            self.selectedData = self.restaurantData?.filter{ $0.category == sender.title! }
            self.makeAnnotaion()
            self.mapView.addAnnotations(self.annotations)
        }
        
        alert.addAction(all)
        alert.addAction(korean)
        alert.addAction(cafe)
        alert.addAction(chinese)
        alert.addAction(japanese)
        alert.addAction(snack)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }

}

// MARK: - map
extension MapViewController{
    func configureMap(){
        let center = CLLocationCoordinate2D(latitude: 37.517412, longitude: 126.889131)
        mapView.region = MKCoordinateRegion(center: center, latitudinalMeters: 1500, longitudinalMeters: 1500)
    }
    
    func makeAnnotaion(){
        annotations = []
        selectedData?.forEach({ item in
            let pin = CustomAnnotation(title: item.name,
                                       subtitle: item.category,
                                       coordinate: CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude))
            annotations.append(pin)
        })
        mapView.addAnnotations(annotations)
    }
}


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
