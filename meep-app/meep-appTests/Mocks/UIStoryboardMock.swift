//
//  UIStoryboardMock.swift
//  meep-appTests
//
//  Created by David Garcia on 29/07/2020.
//  Copyright © 2020 David Garcia. All rights reserved.
//

import UIKit

class UIStoryboardMock: UIStoryboard {
    override init() {
        
    }
    
    override func instantiateViewController(withIdentifier identifier: String) -> UIViewController {
        return MapViewControllerMock()
    }
}
