//
//  PublicMacros.swift
//  BakeTime
//
//  Created by lyy on 2018/1/7.
//  Copyright © 2018年 lyy. All rights reserved.
//

import UIKit

public let screenW = UIScreen.main.bounds.size.width
public let screenH = UIScreen.main.bounds.size.height

public let onePixelHeight = 1.0 / UIScreen.main.scale

public let taskMaxY: CGFloat = UIDevice.current.isiPhoneX() ? 44 : 20
public let navBarH: CGFloat = 44
public let topMaxY: CGFloat = taskMaxY + navBarH

public let safeBottomH: CGFloat = UIDevice.current.isiPhoneX() ? 34 : 0

public let tabBarH: CGFloat = 49
