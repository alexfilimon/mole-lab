//
//  Garden.swift
//  
//
//  Created by Alexander Filimonov on 26/02/2020.
//

import Foundation

protocol AnyGarden {
    var size: Size { get }
    func getMolesAround(point: Point, radius: Int) -> [Mole]
}

protocol UpperGarden: AnyGarden {
    var molesOnAir: [Mole] { get }
    var plants: Int { get }
    func killMole(_ mole: Mole)
}

protocol LowerGarden: AnyGarden {
    func birthNewMole(at point: Point)
}

final class Garden: UpperGarden, LowerGarden {

    // MARK: - Properties

    let size: Size
    var moles: [Mole] = []
    var man: Man!
    var plants = 1000

    // MARK: - Computed Properties

    var molesOnAir: [Mole] {
        return moles.filter { $0.isOnAir }
    }

    // MARK: - Initializaion

    init(size: Size) {
        self.size = size
    }

    // MARK: - UpperGarden

    func killMole(_ mole: Mole) {
        moles.removeAll(where: { $0 === mole })
        print("убиваем крота")
    }

    // MARK: - LowerGarden

    func birthNewMole(at point: Point) {
        let mole = MoleFactory(garden: self).produce()
        mole.point = point
        moles.insert(mole, at: 0)
    }

    // MARK: - AnyGarden

    func getMolesAround(point: Point, radius: Int) -> [Mole] {
        return molesOnAir.filter { $0.point.diff(to: point) <= radius }
    }

    // MARK: - Methods

    func setMoles(_ moles: [Mole]) {
        self.moles = moles
    }

    func setMan(_ man: Man) {
        self.man = man
    }

    func tactOfGame() {
        man.performAction()
        moles.forEach { $0.performAction() }
        plants -= molesOnAir.count
    }

}
