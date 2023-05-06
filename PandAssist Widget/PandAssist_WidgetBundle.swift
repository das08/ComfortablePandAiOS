//
//  PandAssist_WidgetBundle.swift
//  PandAssist Widget
//
//  Created by Kazuki Takeda on 2023/05/06.
//

import WidgetKit
import SwiftUI

@main
struct PandAssist_WidgetBundle: WidgetBundle {
    var body: some Widget {
        PandAssist_Widget()
        PandAssist_WidgetLiveActivity()
    }
}
