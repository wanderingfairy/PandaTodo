//
//  ViewController.swift
//  PandaToDo
//
//  Created by 정의석 on 2020/02/11.
//  Copyright © 2020 pandaman. All rights reserved.
//

import UIKit
import SnapKit
import UserNotifications

class MainViewController: UIViewController {
    
    //MARK: 타이틀 밑에 깔릴 백그라운드
    let viewForTitle = UIView()
    let viewForTitleImage = UIImageView()
    
    //MARK: Label
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    //MARK: Button
    let addTodoButton = UIButton()
    
    //MARK: TableView
    let tableView = UITableView()
    
    var todoListOfUserDefaults: TodoList?
    
    //MARK: AppLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFromUserDefaults()
        view.backgroundColor = UIColor(named: "Color")
//        didTapAddButton()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFromUserDefaults()
        tableView.reloadData()
       
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupUI() {
        viewForTitleImage.image = UIImage(named: "ViewForTitleImage")
        viewForTitleImage.frame = viewForTitle.frame
        viewForTitle.addSubview(viewForTitleImage)
        
        addTodoButton.setImage(UIImage(named: "AddButton"), for: .normal)
        viewForTitle.addSubview(addTodoButton)
        
        titleLabel.text = "오늘 할 일"
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        viewForTitle.addSubview(titleLabel)
        
        subtitleLabel.text = "간편하게 적고,\n알림을 받아보세요."
        subtitleLabel.numberOfLines = 0
        subtitleLabel.font = UIFont.systemFont(ofSize: 28, weight: .light)
        viewForTitle.addSubview(subtitleLabel)
        
        tableView.backgroundColor = UIColor(named: "Color")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 180
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        addTodoButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        
        view.addSubview(tableView)
        view.addSubview(viewForTitle)

        
        setupConstraints()
    }
    
    private func setupConstraints() {
        viewForTitle.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(view.snp.height).multipliedBy(0.3)
            $0.width.equalToSuperview()
            $0.centerX.equalToSuperview()
            print("dd")
        }
        viewForTitleImage.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(1.1)
        }
        
        addTodoButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(-10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.width.height.equalTo(view.snp.width).multipliedBy(0.2)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-(view.frame.height * 0.05))
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.bottom.equalTo(subtitleLabel.snp.top).offset(-5)
        }
        
        
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(viewForTitle.snp.bottom).offset(-20)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    @objc func didTapAddButton() {
        let addTodoVC = AddTodoViewController()
        addTodoVC.modalPresentationStyle = .fullScreen
        present(addTodoVC, animated: true, completion: nil)
    }
    
    func loadFromUserDefaults() {
        if UserDefaults.standard.data(forKey: "TodoList") != nil {
        if let dataFromUserDefaults = try? PropertyListDecoder().decode(TodoList.self, from: UserDefaults.standard.data(forKey: "TodoList")!) {
            todoListOfUserDefaults = dataFromUserDefaults
            print("Load Success")
        } else {
            print("Load Fail")
        }
    } else {
    print("there isn't Data")
    }
    
}
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return Singleton.shared.todoList.count
        return (todoListOfUserDefaults?.todoList.count) ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
//        cell.configure(todo: Singleton.shared.todoList[indexPath.row])
        cell.configure(todo: (todoListOfUserDefaults?.todoList[indexPath.row])!)
        return cell
    }
    
    
}


extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: nil) { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            let notificationCenter = UNUserNotificationCenter.current()
//            notificationCenter.removePendingNotificationRequests(withIdentifiers: ["\(Singleton.shared.todoList[indexPath.row].todoTag)"])
//            Singleton.shared.todoList.remove(at: indexPath.row)
            notificationCenter.removePendingNotificationRequests(withIdentifiers: ["\(self.todoListOfUserDefaults?.todoList[indexPath.row].todoTag)"])
            self.todoListOfUserDefaults?.todoList.remove(at: indexPath.row)
            
            let encodedTodoList = try! PropertyListEncoder().encode(self.todoListOfUserDefaults)
            UserDefaults.standard.set(encodedTodoList, forKey: "TodoList")
            
            
            tableView.deleteRows(at: [indexPath], with: .none)
            
            
            success(true)
    }
        
        deleteAction.backgroundColor = UIColor(named: "Color")
        deleteAction.image = UIImage(named: "DeleteButton")
        
        let successAction = UIContextualAction(style: .normal, title: nil) { (ac:UIContextualAction, view:UIView, success:(Bool)->Void) in
            let notificationCenter = UNUserNotificationCenter.current()
//            notificationCenter.removePendingNotificationRequests(withIdentifiers: ["\(Singleton.shared.todoList[indexPath.row].todoTag)"])
//            Singleton.shared.todoList.remove(at: indexPath.row)
            notificationCenter.removePendingNotificationRequests(withIdentifiers: ["\(self.todoListOfUserDefaults?.todoList[indexPath.row].todoTag)"])
            self.todoListOfUserDefaults?.todoList.remove(at: indexPath.row)
            
            let encodedTodoList = try! PropertyListEncoder().encode(self.todoListOfUserDefaults)
            UserDefaults.standard.set(encodedTodoList, forKey: "TodoList")
            
            tableView.deleteRows(at: [indexPath], with: .none)
            
            success(true)
        }
        
        successAction.backgroundColor = UIColor(named: "Color")
        successAction.image = UIImage(named: "SuccessButton")
        
        return UISwipeActionsConfiguration(actions: [successAction,deleteAction])
    }
}
