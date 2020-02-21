//
//  CustomCell.swift
//  PandaToDo
//
//  Created by 정의석 on 2020/02/11.
//  Copyright © 2020 pandaman. All rights reserved.
//

import UIKit
import SnapKit

class CustomCell: UITableViewCell {
    
    static let identifier = "Cell"
    
    let alarmButton = UIButton()
    let dateLabel = UILabel()
    let timeLabel = UILabel()
    let todoText = UILabel()
    var y: ConstraintItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(named: "Color")
        
        alarmButton.setImage(UIImage(named: "ReserveAlarmButton"), for: .normal)
        dateLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        timeLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        todoText.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(todo:Todo) {
        imageView?.image = UIImage(named: todo.color)
        dateLabel.text = todo.date
        timeLabel.text = todo.time
        todoText.text = todo.memo
        if todo.setAlarm == false {
            alarmButton.setImage(UIImage(named: "NotReserveAlarmButton-1"), for: .normal)
        }
        
        contentView.addSubview(alarmButton)
        contentView.addSubview(dateLabel)
        contentView.addSubview(todoText)
        contentView.addSubview(timeLabel)
        
        imageView?.snp.makeConstraints {
//            $0.top.bottom.leading.trailing.equalToSuperview()
            $0.center.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(1.1)
        }
        
        alarmButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-10)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerY.equalTo(alarmButton.snp.centerY)
            $0.leading.equalToSuperview().offset(45)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerY.equalTo(alarmButton.snp.centerY)
            $0.leading.equalTo(dateLabel.snp.trailing).offset(5)
        }
        
        todoText.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(20)
            $0.leading.equalTo(dateLabel.snp.leading).offset(10)
        }

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    
    
}
