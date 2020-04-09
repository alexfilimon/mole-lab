//
//  Man.swift
//  
//
//  Created by Alexander Filimonov on 26/02/2020.
//

import Foundation

final class Man: Actor {

    // MARK: - Properties

    var point: Point
    let garden: UpperGarden
    let speed: Int
    let radius: Int

    // MARK: - Initialization

    init(garden: UpperGarden, speed: Int, radius: Int) {
        self.point = .zero
        self.garden = garden
        self.speed = speed
        self.radius = radius
    }

    // MARK: - Actor

    func performAction() {
        if let mole = garden.getMolesAround(point: point, radius: radius).first {
            // если есть крот поблизости
            garden.killMole(mole)
        } else if let nearestMole = garden.molesOnAir.sorted(by: {
            $0.point.diff(to: point) < $1.point.diff(to: point)
        }).first {
            // берем ближайшего крота и двигаемся к нему
            let pointNearestMole = nearestMole.point
            if point.x < pointNearestMole.x {
                self.point.x += speed
            } else if point.x > pointNearestMole.x {
                self.point.x -= speed
            } else if point.y < pointNearestMole.y {
                self.point.y += speed
            } else if point.y > pointNearestMole.y {
                self.point.y -= speed
            }
            point.normalize(to: garden.size)
        }
    }

}
