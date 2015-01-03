//
//  Array.swift
//  Password-Manager
//
//  Created by Mani on 03.01.15.
//  Copyright (c) 2015 Mani. All rights reserved.
//

import Foundation

extension Array {
    func each(pred: (T) -> (Void)) {
        for i in self {
            pred(i)
        }
    }
}