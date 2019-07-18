//
//  ChatsViewController.swift
//  bestchat
//
//  Created by Denis Ustavschikov on 13/07/2019.
//  Copyright © 2019 Denis Ustavschikov. All rights reserved.
//

import UIKit
import RxSwift

public class ChatsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var chatTableView: UITableView!
    
    public var router: ChatsRouting?
    public var viewModel: ChatsViewModeling?
    
    private let disposeBag = DisposeBag()
    
    private var chats: [Chat] = [] {
        didSet {
            chatTableView.reloadData()
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.chatsObservable
            .subscribe({ [weak self] (chatsEvent) in
                if let chats = chatsEvent.element {
                    self?.chats = chats
                }
            }).disposed(by: disposeBag)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.subscribe()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel?.unsubscribe()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as? ChatTableViewCell else {
            fatalError()
        }
        let data = chats[indexPath.row]
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy HH:mm"
        cell.chatMessage.text = formatter.string(from: data.createdAt)
        cell.chatTitle.text = data.title
        return cell
    }

}
