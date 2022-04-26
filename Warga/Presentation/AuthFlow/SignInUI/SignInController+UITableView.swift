//
//  SignInController+UITableView.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 13/09/21.
//

import UIKit

extension SignInController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.formItems.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FormTextFieldCell.reuseIdentifier, for: indexPath) as? FormTextFieldCell else { return UITableViewCell() }
        cell.fill(with: self.formItems[indexPath.row])
        return cell
    }
    
}

extension SignInController: UITableViewDelegate {
    
}
