//
//  Coordinator.swift
//  Social
//
//  Created by John Crossley on 07/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get }
}

protocol Coordinated {
    var coordinator: MainCoordinator? { get set }
}
