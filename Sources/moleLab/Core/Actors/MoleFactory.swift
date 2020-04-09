//
//  MoleFactory.swift
//  
//
//  Created by Alexander Filimonov on 26/02/2020.
//

import Foundation

final class MoleFactory {

    // MARK: - Properties

    let garden: LowerGarden

    // MARK: - Initializaion

    init(garden: LowerGarden) {
        self.garden = garden
    }

    // MARK: - Methods

    func produce() -> Mole {
        return .init(sex: getRandomSex(), garden: garden)
    }

}

// MARK: - Private Methods

private extension MoleFactory {

    func getRandomSex() -> Sex {
        return Sex.allCases.randomElement() ?? .male
    }

}
