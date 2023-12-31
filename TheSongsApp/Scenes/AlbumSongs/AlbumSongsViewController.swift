//
//  AlbumSongsViewController.swift
//  TheSongsApp
//
//  Created by Frederico Lacis de Carvalho on 30/09/23.
//

import UIKit
import Combine

class AlbumSongsViewController: UITableViewController {
    
    var coordinator: SongsCoordinator?
    
    private let viewModel: AlbumSongsViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    init(viewModel: AlbumSongsViewModel, coordinator: SongsCoordinator? = nil) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
}

// MARK: Setup Methods
extension AlbumSongsViewController {
    
    private func setupView() {
        setupAppearence()
        setupTableView()
        setupNavigationBar()
        setupBindings()
    }
    
    private func setupAppearence() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupTableView() {
        tableView.register(TSASongTableViewCell.self)
        tableView.separatorStyle = .none
    }
    
    private func setupNavigationBar() {
        title = viewModel.album.name
        sheetPresentationController?.prefersGrabberVisible = true
    }
    
    private func setupBindings() {
        viewModel.$album
            .receive(on: DispatchQueue.main)
            .sink { [weak self] album in
                self?.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            }
            .store(in: &subscriptions)
    }
    
}

// MARK: UI Table View Data Source
extension AlbumSongsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.album.songs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(ofType: TSASongTableViewCell.self, for: indexPath) else { return UITableViewCell() }
        cell.configure(viewModel: viewModel.cellViewModels[indexPath.row])
        return cell
    }
    
}

// MARK: UI Table View Delegate
extension AlbumSongsViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.selectSong(viewModel.album.songs[indexPath.row])
    }
    
}
