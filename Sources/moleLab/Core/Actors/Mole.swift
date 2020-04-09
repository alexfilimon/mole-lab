//
//  Mole.swift
//  
//
//  Created by Alexander Filimonov on 26/02/2020.
//

import Foundation

final class Mole: Actor {

    // MARK: - Constants

    private enum Constants {
        static let tactsOnAir = 10
        static let taktsToPropagation = 10
    }

    // MARK: - Properties

    var point: Point
    let garden: LowerGarden
    let sex: Sex
    var isOnAir = false
    var currentTactOnAir = 0
    var currentTactOfPropagation = 0
    weak var pair: Mole?

    // MARK: - Initialization

    init(sex: Sex, garden: LowerGarden) {
        self.point = .init(x: (0...garden.size.width).randomElement() ?? 0,
                           y: (0...garden.size.height).randomElement() ?? 0)
        self.sex = sex
        self.garden = garden
    }

    // MARK: - Actor

    func performAction() {
        if isOnAir {
            currentTactOnAir += 1
            if currentTactOnAir == Constants.tactsOnAir {
                isOnAir = false
            }
        } else if currentTactOfPropagation != 0 {
            // в процессе размножения
            currentTactOfPropagation -= 1

            // если это был последний такт и это самка, то рождаем нового крота
            if currentTactOfPropagation == 0 && sex == .female {
                garden.birthNewMole(at: point)
            }

            // если это был последний такт -> сбрасываем пары
            if currentTactOfPropagation == 0 {
                pair?.pair = nil
                pair = nil
            }
        } else if
            pair == nil,
            let otherMole = garden.getMolesAround(point: point, radius: 1).first(where: { $0.sex != sex })
        {
            // позиция совпадает с другим кротом (или рядом) -> размножаемся
            self.pair = otherMole
            otherMole.pair = self
            currentTactOfPropagation = Constants.taktsToPropagation
            otherMole.currentTactOfPropagation = Constants.taktsToPropagation
        } else {
            point = point.getChangedRandom(size: garden.size)
            if (0...30).randomElement() == 1 {
                currentTactOnAir = 0
                isOnAir = true
            }
        }
    }

}
