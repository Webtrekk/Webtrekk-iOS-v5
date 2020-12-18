//
//  PageViewController.swift
//  MappIntelligenceDemoApp
//
//  Created by Miroljub Stoilkovic on 02/12/2020.
//  Copyright © 2020 Mapp Digital US, LLC. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func trackPage(_ sender: Any) {
        MappIntelligence.shared()?.trackPage(with: self, andEvent: nil)
    }

    @IBAction func trackProduct(_ sender: Any) {
        let ecommerceProperties = MIEcommerceProperties(customProperties: [540 : "ecommerce1;ecommerce2"])
        let product1 = MIProduct()
        product1.name = "Product1Name"
        product1.cost = 20
        product1.quantity = 34
        product1.categories = [1: "Shorts", 2: "Men", 44: "Clothes"]
        let product2 = MIProduct()
        product2.categories = [1: "T-Shirts", 45: "Jackets"]
        let product3 = MIProduct()
        product3.categories = [2: "Women", 46: "Winter"]
        product3.cost = 348
        ecommerceProperties.status = .addedToBasket
        ecommerceProperties.products = [product1, product2, product3];
        ecommerceProperties.currency = "EUR"
        ecommerceProperties.paymentMethod = "creditCard"
        
        let pageEvent = MIPageViewEvent(name: "TrackProductTest")
        pageEvent.ecommerceProperties = ecommerceProperties
        
        MappIntelligence.shared()?.trackPage(pageEvent)
    }
    
    @IBAction func trackCustomPage(_ sender: Any) {
        
        //page properties
        let params:[NSNumber : String] = [20: "cp20Override;cp21Override;cp22Override"]
        let categories:NSMutableDictionary = [10: ["test"]]
        let searchTerm = "testSearchTerm"
        let pageProperties = MIPageProperties(pageParams: params, andWithPageCategory: categories, andWithSearch: searchTerm)
        
        //user properties
        let userProperties = MIUserProperties()
        userProperties.customProperties = [20:"userParam1"]
        userProperties.birthday = MIBirthday(day: 12, month: 1, year: 1993)
        userProperties.city = "Paris"
        userProperties.country = "France"
        userProperties.customerId = "CustomerID"
        userProperties.gender = .female
        
        //sessionproperties
        let sessionProperties = MISessionProperties(properties: [10: "sessionParam1;sessionParam2"])
              
        let pageEvent = MIPageViewEvent(name: "the custom name of page")
        pageEvent.pageProperties = pageProperties
        pageEvent.userProperties = userProperties
        pageEvent.sessionProperties = sessionProperties
        
        MappIntelligence.shared()?.trackPage(pageEvent)
            
    }
    @IBAction func trackCustomPageData(_ sender: Any) {

        //use predefined tags for convenience
//        let pageParam1 = MIParamType.createCustomParam(MIParamType.pageParam(), value: 2)
//        let pageParam9 = MIParamType.createCustomParam(MIParamType.pageParam(), value: 9)
//        let sessionParam20 = MIParamType.createCustomParam(MIParamType.sessionParam(), value: 20)
//
//        let cparams = [
//            MIParams.internalSearch() : "Search term",
//            pageParam1 : "cp2Value",
//            pageParam9 : "cp9Value",
//            sessionParam20: "cs20Value"
//        ]
        
        //or you can just pass strings
        
        let cparams:[String:String] = ["cp10":"cp10Override",
                                       "cg10": "test"]
        
        
        MappIntelligence.shared()?.trackCustomPage("Test", trackingParams: cparams)
    }
}
