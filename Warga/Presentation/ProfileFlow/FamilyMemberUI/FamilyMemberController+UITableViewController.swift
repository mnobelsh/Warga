//
//  FamilyMemberController+UITableViewController.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 29/10/21.
//

import UIKit

extension FamilyMemberController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.familyMember.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomDefaultTableCell.reuseIdentifier, for: indexPath) as? CustomDefaultTableCell else { return UITableViewCell() }
        let member = self.familyMember[indexPath.row]
        cell.configureCell(icon: .jakiIcon, title: member.name, subtitle: member.relationship)
        return cell
    }
    
}

extension FamilyMemberController: UITableViewDelegate {
    
}
