// 
// Wire
// Copyright (C) 2016 Wire Swiss GmbH
// 
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
// 


import Foundation

/**
 * @abstract Generates the cell that displays one button
 */
class SettingsButtonCellDescriptor: SettingsCellDescriptorType {
    static let cellType: SettingsTableCell.Type = SettingsButtonCell.self
    let title: String
    let identifier: String?
    var visible: Bool {
        get {
            if let visibilityAction = self.visibilityAction {
                return visibilityAction(self)
            }
            else {
                return true
            }
        }
    }
    
    weak var group: SettingsGroupCellDescriptorType?
    let selectAction: (SettingsCellDescriptorType) -> ()
    let visibilityAction: ((SettingsCellDescriptorType) -> (Bool))?
    let isDestructive: Bool
    
    init(title: String, isDestructive: Bool, selectAction: (SettingsCellDescriptorType) -> ()) {
        self.title = title
        self.isDestructive = isDestructive
        self.selectAction = selectAction
        self.visibilityAction = .None
        self.identifier = .None
    }
    
    init(title: String, isDestructive: Bool, selectAction: (SettingsCellDescriptorType) -> (), visibilityAction: ((SettingsCellDescriptorType) -> (Bool))? = .None) {
        self.title = title
        self.isDestructive = isDestructive
        self.selectAction = selectAction
        self.visibilityAction = visibilityAction
        self.identifier = .None
    }
    
    init(title: String, isDestructive: Bool, identifier: String, selectAction: (SettingsCellDescriptorType) -> (), visibilityAction: ((SettingsCellDescriptorType) -> (Bool))? = .None) {
        self.title = title
        self.isDestructive = isDestructive
        self.selectAction = selectAction
        self.visibilityAction = visibilityAction
        self.identifier = identifier
    }
    
    func featureCell(cell: SettingsCellType) {
        cell.titleText = self.title
        if self.isDestructive {
            cell.titleColor = UIColor.redColor()
        }
        else {
            cell.titleColor = UIColor.darkTextColor()
        }
    }
    
    func select(value: SettingsPropertyValue?) {
        self.selectAction(self)
    }
}
