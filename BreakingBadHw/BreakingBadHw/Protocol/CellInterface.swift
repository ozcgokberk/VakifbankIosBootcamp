//
//  CellInterface.swift
//  BreakingBadHw
//
//  Created by Gokberk Ozcan on 27.11.2022.
//

import UIKit
protocol CellInterface {
  static var id: String { get }
  static var cellNib: UINib { get }
}

extension CellInterface {

  static var id: String {
    return String(describing: Self.self)
  }

  static var cellNib: UINib {
    return UINib(nibName: id, bundle: nil)
  }
}
