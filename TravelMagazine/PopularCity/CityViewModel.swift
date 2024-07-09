//
//  CityViewModel.swift
//  TravelMagazine
//
//  Created by 박다현 on 7/9/24.
//

import Foundation

class CityViewModel{
    
    var outputList = Observable(CityInfo().city)
    var inputSegment = Observable(0)
    
    init(){
        inputSegment.bind { _ in
            self.changeSegment()
        }
    }
    
    func changeSegment(){
        let cityInfo = CityInfo().city
        
        if inputSegment.value == 0{
            outputList.value = cityInfo

        }else if inputSegment.value == 1{
            outputList.value  = cityInfo.filter{ $0.domestic_travel }
            
        }else if inputSegment.value == 2{
            outputList.value  = cityInfo.filter{ $0.domestic_travel == false }
        }
    }
    
    func searchCity(searchText:String?){
        guard let searchText else { return }
 
        }

    
}
