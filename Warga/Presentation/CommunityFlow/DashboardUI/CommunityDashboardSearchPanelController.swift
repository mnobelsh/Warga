//
//  CommunityDashboardSearchPanelController.swift
//  Warga
//
//  Created by Muhammad Nobel Shidqi on 28/10/21.
//

import UIKit
import RxSwift
import MapKit

public protocol CommunityDashboardSearchPanelDelegate: AnyObject {
    func searchPanelTableView(_ tableView: UITableView, didSelect mapItem: MKMapItem)
}

public final class CommunityDashboardSearchPanelController: UIViewController {

    var viewModel: CommunityDashboardViewModel!
    
    weak var delegate: CommunityDashboardSearchPanelDelegate?
    private var searchResult = [MKMapItem]()
    
    public lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame, style: .plain)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomDefaultTableCell.self, forCellReuseIdentifier: CustomDefaultTableCell.reuseIdentifier)
        return tableView
    }()
    public lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tutup", for: .normal)
        button.setTitleColor(.primaryPurple, for: .normal)
        button.titleLabel?.font = .heading3
        button.backgroundColor = .clear
        return button
    }()
    
    private let disposeBag = DisposeBag()
    
    class func create(with viewModel: CommunityDashboardViewModel) -> CommunityDashboardSearchPanelController {
        let controller = CommunityDashboardSearchPanelController()
        controller.viewModel = viewModel
        return controller
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewDidLoad()
        self.bind(viewModel: self.viewModel)
        self.viewModel.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

}

private extension CommunityDashboardSearchPanelController {
    
    func setupViewDidLoad() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.closeButton)
        self.view.addSubview(self.tableView)
        self.closeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(20)
        }
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(self.closeButton.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    func bind(viewModel: CommunityDashboardViewModel) {
        viewModel.displayedSearchLocationResult
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                guard let self = self else { return }
                self.searchResult = result
                self.reloadTableView()
            }).disposed(by: self.disposeBag)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.performBatchUpdates {
                self.tableView.reloadSections(IndexSet(integer: 0), with: .fade)
            }
        }
    }
    
}

extension CommunityDashboardSearchPanelController: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResult.isEmpty ? 1 : self.searchResult.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomDefaultTableCell.reuseIdentifier, for: indexPath) as? CustomDefaultTableCell else { return UITableViewCell() }
        if searchResult.isEmpty {
            cell.configureCell(icon: .locationIsometric, title: "Ketik lokasi yang ingin anda cari dengan menekan pencarian diatas.", subtitle: "Untuk kembali ke lokasi anda tekan icon di pojok kiri atas layar perangkat anda.")
        } else {
            let placemark = self.searchResult[indexPath.row].placemark
            cell.configureCell(icon: .locationIsometric, title: placemark.name, subtitle: placemark.title)
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !self.searchResult.isEmpty else { return }
        let mapItem = self.searchResult[indexPath.row]
        self.delegate?.searchPanelTableView(tableView, didSelect: mapItem)
    }
    
}
