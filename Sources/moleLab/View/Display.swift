//
//  Display.swift
//  
//
//  Created by Alexander Filimonov on 26/02/2020.
//

import Foundation

final class Display {

    // MARK: - Properties

    let size: Size
    var pointsToHighlight: [Point]

    // MARK: - Initialization

    init(size: Size, pointsToHighlight: [Point]) {
        self.size = size
        self.pointsToHighlight = pointsToHighlight
    }

    // MARK: - Methods

    func updatePoints(_ points: [Point]) {
        self.pointsToHighlight = points
    }

    func draw() {
        drawLine(width: size.width + 2)
        for row in (0...size.height) {
            print("|", terminator: "")
            for col in (0...size.width) {
                if pointsToHighlight.contains(Point(x: col, y: row)) {
                    print("*", terminator: "")
                } else {
                    print(" ", terminator: "")
                }
            }
            print("|")
        }
        drawLine(width: size.width + 2)
        print()
    }

}

// MARK: - Private Methods

private extension Display {

    func drawLine(width: Int) {
        for i in 0...width {
            let isLast = i == width
            print("-", terminator: isLast ? "\n" : "")
        }
    }

}
