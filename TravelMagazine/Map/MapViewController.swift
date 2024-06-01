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
    
    //카테고리 이름 가지고 오기
    var categoryTitle:Set<String>{
        var set:Set<String> = []
        restaurantData?.forEach{
            set.insert($0.category)
        }
        return set
    }
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

        let all = UIAlertAction(title: "전체보기", style: .default){ _ in
            self.mapView.removeAnnotations(self.annotations)
            self.selectedData = self.restaurantData
            self.makeAnnotaion()
            self.mapView.addAnnotations(self.annotations)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
       
        categoryTitle.forEach{ cateName in
            let newAlerts = UIAlertAction(title: cateName, style: .default){ alertAction($0) }
            alert.addAction(newAlerts)
        }
       
        func alertAction(_ sender:UIAlertAction){
            self.mapView.removeAnnotations(self.annotations)
            self.selectedData = self.restaurantData?.filter{ $0.category == sender.title! }
            self.makeAnnotaion()
            self.mapView.addAnnotations(self.annotations)
        }
        
        alert.addAction(all)
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



