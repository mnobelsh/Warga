//
//  ProfileDashboardController+UITableView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 05/10/21.
//

import UIKit

extension ProfileDashboardController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return ProfileDashboardMenu.Section.allCases.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch ProfileDashboardMenu.Section.allCases[section] {
        case .profileInfo:
            return self.profileInfoMenu.count
        case .appConfiguration:
            return self.appConfigurationMenu.count
        case .authConfiguration:
            return self.authConfigurationMenu.count
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileDashboardMenuTableCell.reuseIdentifier, for: indexPath) as? ProfileDashboardMenuTableCell else { return UITableViewCell() }
        switch ProfileDashboardMenu.Section.allCases[indexPath.section] {
        case .profileInfo:
            cell.configureCell(with: self.profileInfoMenu[indexPath.row])
        case .appConfiguration:
            cell.configureCell(with: self.appConfigurationMenu[indexPath.row])
            cell.delegate = self
        case .authConfiguration:
            cell.configureCell(with: self.authConfigurationMenu[indexPath.row])
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(15)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(65)
    }
    
}

extension ProfileDashboardController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch ProfileDashboardMenu.Section.allCases[indexPath.section] {
        case .profileInfo:
            switch self.profileInfoMenu[indexPath.row].type {
            case .activites:
                self.tabBarController?.selectedIndex = 1
            default:
                self.viewModel.didSelect(self.profileInfoMenu[indexPath.row])
            }
            
        case .appConfiguration:
            self.viewModel.didSelect(self.appConfigurationMenu[indexPath.row])
        case .authConfiguration:
            let requestValue = ConfirmationDialogRequestValue(id: UUID().uuidString, title: "Konfirmasi", content: "Anda yakin untuk keluar dari aplikasi warga ?") { [weak self] in
                guard let self = self else { return }
                self.viewModel.doSignOut()
            }
            self.viewModel.showConfirmationDialog(requestValue: requestValue)
        }
    }
    
}


extension ProfileDashboardController: ProfileDashboardMenuTableCellDelegate {
    
    public func profileDashboardMenuCell(_ cell: ProfileDashboardMenuTableCell, switchValueDidChange switchButton: UISwitch) {
        guard let data = cell.data else { return }
        switch data.type {
        case .showInMap:
            self.viewModel.setShowInMap(switchButton.isOn)
        default:
            break
        }
    }
    
}
