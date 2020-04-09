//
//  File.swift
//  
//
//  Created by Alexander Filimonov on 26/02/2020.
//

import Foundation

struct Point {
    var x: Int
    var y: Int

    static var zero: Point {
        return .init(x: 0, y: 0)
    }

    func diff(to another: Point) -> Int {
        let a = abs(x * x - another.x * another.x) + abs(y * y - another.y * another.y)
        return Int(sqrt(Float(a)))
    }

    func getChangedRandom(size: Size) -> Point {
        let newX = x + ((-1...1).randomElement() ?? 0)
        let newY = y + ((-1...1).randomElement() ?? 0)
        return .init(x: min(max(newX, 0), size.width),
                     y: min(max(newY, 0), size.height))
    }

    mutating func normalize(to size: Size) {
        self.x = min(max(x, 0), size.width - 1)
        self.y = min(max(y, 0), size.height - 1)
    }

}

extension Point: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}
