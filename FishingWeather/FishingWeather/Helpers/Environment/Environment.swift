//
//  Environment.swift
//  FishingWeather
//
//  Created by Александр Янчик on 5.04.23.
//

import UIKit

struct Environment {
    static var sceneDelegare: SceneDelegate? {
        let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        return scene
    }
}
