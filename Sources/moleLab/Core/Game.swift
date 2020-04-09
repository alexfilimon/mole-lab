//
//  Game.swift
//  
//
//  Created by Alexander Filimonov on 26/02/2020.
//

import Foundation

final class Game {

    // MARK: - Properties

    let garden: Garden
    var isEnded = false
    let display: Display

    // MARK: - Initializaion

    init(size: Size, molesCount: Int) {
        let currentGarden = Garden(size: size)
        self.garden = currentGarden
        let molesFactory = MoleFactory(garden: currentGarden)
        garden.setMoles((0..<molesCount).map { _ in molesFactory.produce() })
        garden.setMan(Man(garden: currentGarden, speed: 5, radius: 3))

        display = .init(size: size, pointsToHighlight: [])
    }

    // MARK: - Methods

    func start() {
        var tacts = 10000
        while !isEnded {
            garden.tactOfGame()
//            display.updatePoints(garden.molesOnAir.map { $0.point })
//            display.draw()
//            Thread.sleep(forTimeInterval: 0.0001)
            tacts -= 1
            if tacts == 0 {
                isEnded = true
                print("$ Закончились такты")
            } else if garden.plants < 0 {
                isEnded = true
                print("$ Победили кроты")
            } else if garden.moles.count == 0 {
                isEnded = true
                print("$ Победил садовник")
            }
        }
    }

}
