//
//  AddTodoViewController.swift
//  PandaToDo
//
//  Created by 정의석 on 2020/02/11.
//  Copyright © 2020 pandaman. All rights reserved.
//

import UIKit
import FSCalendar
import UserNotifications


class AddTodoViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {
    var setAlarm = false
    let nowDate = ""
    let alarmDate = ""
    var colorName: String?
    
    let underBackButtonView = UIView()
    let underBackButtonImage = UIImageView()
    
    let backButton = UIButton(type: .custom)
    let underCalenderView = UIView()
    let underCalenderImage = UIImageView()
    let calendar = FSCalendar()
    
    let settingTodoCell = UIView()
    let settingTodoImage = UIImageView()
    let settingTodoAlarmButton = UIButton()
    let dateLabel = UILabel()
    let timeLabel = UILabel()
    let todoTextField = UITextField()
    
    let timePickerView = UIView()
    let timePickerBackgroundImage = UIImageView()
    let timePicker = UIDatePicker()
    let timeOkButton = UIButton(type: .custom)
    let timeCancelButton = UIButton(type: .custom)
    
    let colorPickButtonBasic = UIButton(type: .custom)
    let colorPickButtonPink = UIButton(type: .custom)
    let colorPickButtonBlue = UIButton(type: .custom)
    let colorPickButtonRed = UIButton(type: .custom)
    let colorPickButtonGreen = UIButton(type: .custom)
    let colorPickButtonCyan = UIButton(type: .custom)
    let colorPickButtonOrange = UIButton(type: .custom)
    let colorPickButtonPurple = UIButton(type: .custom)
    
    let makeTodoButton = UIButton(type: .custom)
    
    var keyboardDuration: TimeInterval?
    
    var selectedYear: String?
    var selectedMonth: String?
    var selectedDay: String?
    
    var selectedHour: String?
    var selectedMinute: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Color")
        todoTextField.delegate = self
        calendar.delegate = self
        calendar.dataSource = self
        registerLocal()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    private func setupUI() {
        
        underBackButtonImage.image = UIImage(named: "BackButtonBackground")
        underBackButtonImage.frame = underBackButtonView.frame
        underBackButtonView.addSubview(underBackButtonImage)
        
        backButton.setImage(UIImage(named: "BackButton"), for: .normal)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        underBackButtonView.addSubview(backButton)
        
        underCalenderImage.image = UIImage(named: "CalenderBackground")
        underCalenderImage.frame = underCalenderView.frame
        underCalenderView.addSubview(underCalenderImage)
        
        calendar.allowsSelection = true
        
        underCalenderView.addSubview(calendar)
        
        settingTodoImage.image = UIImage(named: "TableViewCellBasic")
        settingTodoImage.frame = settingTodoCell.frame
        settingTodoCell.addSubview(settingTodoImage)
        
        //        settingTodoAlarmButton.setImage(UIImage(named: "ReserveAlarmButton"), for: .normal)
        settingTodoAlarmButton.setImage(UIImage(named: "NotReserveAlarmButton-1"), for: .normal)
        settingTodoAlarmButton.imageView?.contentMode = .center
        
        settingTodoAlarmButton.addTarget(self, action: #selector(didTapSettingAlarmButton), for: .touchUpInside)
        settingTodoCell.addSubview(settingTodoAlarmButton)
        
        dateLabel.text = ""
        dateLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        settingTodoCell.addSubview(dateLabel)
        
        timeLabel.text = ""
        timeLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        settingTodoCell.addSubview(timeLabel)
        
        todoTextField.placeholder = "새로운 할 일"
        todoTextField.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        todoTextField.backgroundColor = .none
        settingTodoCell.addSubview(todoTextField)
        
        
        
        colorPickButtonBasic.setImage(UIImage(named: "Basic"), for: .normal)
        colorPickButtonBasic.tag = 6
        colorPickButtonPink.setImage(UIImage(named: "Pink"), for: .normal)
        colorPickButtonPink.tag = 1
        colorPickButtonBlue.setImage(UIImage(named: "Blue"), for: .normal)
        colorPickButtonBlue.tag = 2
        colorPickButtonRed.setImage(UIImage(named: "Red"), for: .normal)
        colorPickButtonRed.tag = 3
        colorPickButtonGreen.setImage(UIImage(named: "Green"), for: .normal)
        colorPickButtonGreen.tag = 4
        colorPickButtonCyan.setImage(UIImage(named: "Cyan"), for: .normal)
        colorPickButtonCyan.tag = 5
        colorPickButtonOrange.setImage(UIImage(named: "Orange"), for: .normal)
        colorPickButtonOrange.tag = 7
        colorPickButtonPurple.setImage(UIImage(named: "Purple"), for: .normal)
        colorPickButtonPurple.tag = 8
        
        makeTodoButton.setImage(UIImage(named: "MakeTodoButton"), for: .normal)
        makeTodoButton.addTarget(self, action: #selector(didTapMakeButton), for: .touchUpInside)
        
        timePickerBackgroundImage.image = UIImage(named: "timePicker")
        timePickerBackgroundImage.frame = timePicker.frame
        timePickerView.addSubview(timePickerBackgroundImage)
        
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        timePickerView.addSubview(timePicker)
        
        timeOkButton.setImage(UIImage(named: "SuccessButton"), for: .normal)
        timeOkButton.addTarget(self, action: #selector(didTapPickerOkButton), for: .touchUpInside)
        timePickerView.addSubview(timeOkButton)
        
        timeCancelButton.setImage(UIImage(named: "DeleteButton"), for: .normal)
        timeCancelButton.addTarget(self, action: #selector(didTapPickerCancelButton), for: .touchUpInside)
        timePickerView.addSubview(timeCancelButton)
        
        view.addSubview(underCalenderView)
        view.addSubview(underBackButtonView)
        view.addSubview(settingTodoCell)
        view.addSubviews([
            colorPickButtonGreen,
            colorPickButtonRed,
            colorPickButtonBlue,
            colorPickButtonPink,
            
            colorPickButtonPurple,
            colorPickButtonOrange,
            colorPickButtonBasic,
            colorPickButtonCyan,
            makeTodoButton,
        ])
        view.addSubview(timePickerView)
        
        
        addTargets([
            colorPickButtonGreen,
            colorPickButtonRed,
            colorPickButtonBlue,
            colorPickButtonPink,
            
            colorPickButtonPurple,
            colorPickButtonOrange,
            colorPickButtonBasic,
            colorPickButtonCyan,
            makeTodoButton,
        ])
        setupConstraints()
        timePickerView.isHidden = true
    }
    
    private func setupConstraints() {
        
        underBackButtonView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(view.snp.height).multipliedBy(0.16)
            $0.width.equalToSuperview()
            $0.centerX.equalToSuperview()
            print("dd")
        }
        
        underBackButtonImage.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            
            $0.width.equalToSuperview().multipliedBy(1.1)
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(-5)
            $0.width.height.equalTo(view.snp.width).multipliedBy(0.25)
        }
        
        underCalenderView.snp.makeConstraints{
            $0.top.equalTo(underBackButtonView.snp.bottom).offset(-23)
            $0.width.equalToSuperview().multipliedBy(1.03)
            $0.centerX.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.4)
        }
        underCalenderImage.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        calendar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.9)
        }
        
        settingTodoCell.snp.makeConstraints {
            $0.top.equalTo(underCalenderView.snp.bottom).offset(-10)
            $0.width.equalToSuperview().multipliedBy(1.03)
            $0.centerX.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.2)
        }
        
        settingTodoImage.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        settingTodoAlarmButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-10)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerY.equalTo(settingTodoAlarmButton)
            $0.leading.equalToSuperview().offset(45)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel)
            $0.leading.equalTo(dateLabel.snp.trailing).offset(5)
        }
        
        //        timePicker.snp.makeConstraints {
        //            $0.trailing.equalTo(settingTodoAlarmButton.snp.leading).offset(10)
        //            $0.centerY.equalTo(dateLabel)
        //            $0.leading.equalTo(timeLabel.snp.trailing)
        //        }
        
        todoTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(20)
            $0.leading.equalTo(dateLabel.snp.leading).offset(10)
            $0.width.equalTo(view.snp.width).multipliedBy(0.7)
        }
        
        colorPickButtonPink.snp.makeConstraints {
            $0.top.equalTo(settingTodoCell.snp.bottom).offset(-10)
            $0.leading.equalTo(settingTodoCell.snp.leading).offset(15)
            $0.width.height.equalTo(view.snp.width).multipliedBy(0.18)
        }
        
        colorPickButtonPink.imageView?.snp.makeConstraints({
            $0.width.height.equalToSuperview().multipliedBy(1.2)
        })
        
        colorPickButtonBlue.snp.makeConstraints {
            $0.centerY.width.height.equalTo(colorPickButtonPink)
            $0.leading.equalTo(colorPickButtonPink.snp.trailing).offset(-5)
        }
        colorPickButtonBlue.imageView?.snp.makeConstraints({
            $0.width.height.equalToSuperview().multipliedBy(1.2)
        })
        
        colorPickButtonRed.snp.makeConstraints {
            $0.centerY.width.height.equalTo(colorPickButtonPink)
            $0.leading.equalTo(colorPickButtonBlue.snp.trailing).offset(-5)
        }
        colorPickButtonRed.imageView?.snp.makeConstraints({
            $0.width.height.equalToSuperview().multipliedBy(1.2)
        })
        
        colorPickButtonGreen.snp.makeConstraints {
            $0.centerY.width.height.equalTo(colorPickButtonPink)
            $0.leading.equalTo(colorPickButtonRed.snp.trailing).offset(-5)
        }
        colorPickButtonGreen.imageView?.snp.makeConstraints({
            $0.width.height.equalToSuperview().multipliedBy(1.2)
        })
        
        
        //MARK: 아랫줄 컬러픽
        colorPickButtonCyan.snp.makeConstraints {
            $0.top.equalTo(colorPickButtonPink.snp.bottom)
            $0.leading.equalTo(colorPickButtonPink.snp.leading)
            $0.width.height.equalTo(view.snp.width).multipliedBy(0.18)
        }
        colorPickButtonCyan.imageView?.snp.makeConstraints({
            $0.width.height.equalToSuperview().multipliedBy(1.2)
        })
        
        colorPickButtonBasic.snp.makeConstraints {
            $0.centerY.width.height.equalTo(colorPickButtonCyan)
            $0.leading.equalTo(colorPickButtonCyan.snp.trailing).offset(-5)
        }
        colorPickButtonBasic.imageView?.snp.makeConstraints({
            $0.width.height.equalToSuperview().multipliedBy(1.2)
        })
        
        colorPickButtonOrange.snp.makeConstraints {
            $0.centerY.width.height.equalTo(colorPickButtonCyan)
            $0.leading.equalTo(colorPickButtonBasic.snp.trailing).offset(-5)
        }
        colorPickButtonOrange.imageView?.snp.makeConstraints({
            $0.width.height.equalToSuperview().multipliedBy(1.2)
        })
        
        colorPickButtonPurple.snp.makeConstraints {
            $0.centerY.width.height.equalTo(colorPickButtonCyan)
            $0.leading.equalTo(colorPickButtonOrange.snp.trailing).offset(-5)
        }
        colorPickButtonPurple.imageView?.snp.makeConstraints({
            $0.width.height.equalToSuperview().multipliedBy(1.2)
        })
        
        makeTodoButton.snp.makeConstraints {
            $0.centerY.equalTo(colorPickButtonPink.snp.bottom)
            $0.width.height.equalTo(view.snp.width).multipliedBy(0.25)
            $0.leading.equalTo(colorPickButtonGreen.snp.trailing).offset(5)
        }
        makeTodoButton.imageView?.snp.makeConstraints({
            $0.width.height.equalToSuperview().multipliedBy(1.2)
        })
        
        
        
        
        timePickerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(view.snp.width).multipliedBy(0.8)
        }
        timePickerBackgroundImage.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalToSuperview().multipliedBy(1.1)
        }
        //
        timePicker.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-40)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalToSuperview().multipliedBy(0.3)
        }
        
        timeOkButton.snp.makeConstraints {
            $0.leading.equalTo(timePickerView.snp.centerX)
            $0.bottom.equalToSuperview().offset(-20)
            $0.width.height.equalTo(timePickerView.snp.width).multipliedBy(0.3)
        }
        
        timeOkButton.imageView?.snp.makeConstraints({
            $0.width.height.equalToSuperview().multipliedBy(1.2)
        })
        
        timeCancelButton.snp.makeConstraints {
            $0.trailing.equalTo(timePickerView.snp.centerX)
            $0.bottom.equalToSuperview().offset(-20)
            $0.width.height.equalTo(timePickerView.snp.width).multipliedBy(0.3)
        }
        
        timeCancelButton.imageView?.snp.makeConstraints({
            $0.width.height.equalToSuperview().multipliedBy(1.2)
        })
        
        
    }
    
    
    
    //MARK: Actions
    @objc private func timeChanged() {
        let dateformatter = DateFormatter()
        
        dateformatter.dateStyle = .none
        dateformatter.timeStyle = .short
        
        let date = dateformatter.string(from: timePicker.date)
        timeLabel.text = date
        dateformatter.locale = Locale(identifier: "en_GB")
        let timeTxt = dateformatter.string(from: timePicker.date)
        selectedHour = String(timeTxt.dropLast(3))
        selectedMinute = String(timeTxt.dropFirst(3))
    }
    
    
    func addTargets(_ buttons: [UIButton]) {
        buttons.forEach { $0.addTarget(self, action: #selector(didTapColor(_:)), for: .touchUpInside)
        }
    }
    
    @objc func didTapBackButton() {
        
        self.dismiss(animated: true, completion: nil)
    }
    @objc func didTapMakeButton() {
        let randomNum = (1...5000).randomElement()
        let addedTodo: Todo = Todo(todoTag: randomNum!,
                                   date: dateLabel.text ?? "",
                                   time: timeLabel.text ?? "",
                                   memo: todoTextField.text ?? "새로운 할 일",
                                   color: colorName ?? "TableViewCellBasic",
                                   setAlarm: setAlarm)
        
        //        Singleton.shared.todoList.append(addedTodo)
        if UserDefaults.standard.object(forKey: "TodoList") != nil {
            if var decodedTodoList = try? PropertyListDecoder().decode(TodoList.self, from: UserDefaults.standard.object(forKey: "TodoList") as! Data) {
                decodedTodoList.todoList.append(addedTodo)
                let encodedTodoList = try! PropertyListEncoder().encode(decodedTodoList)
                UserDefaults.standard.set(encodedTodoList, forKey: "TodoList")
                print("Success insert Todo ")
            } else {
                let encodedTodoList = try! PropertyListEncoder().encode(TodoList(todoList: [addedTodo]))
                UserDefaults.standard.set(encodedTodoList, forKey: "TodoList")
                
                print("fail to insert Todo in UserDefaults")
            }
        } else {
            let encodedTodoList = try! PropertyListEncoder().encode(TodoList(todoList: [addedTodo]))
            UserDefaults.standard.set(encodedTodoList, forKey: "TodoList")
            
            print("fail to insert Todo in UserDefaults")
        }
        
        
        if selectedYear != nil &&
            selectedYear != nil &&
            selectedMonth != nil &&
            selectedDay != nil &&
            selectedHour != nil &&
            selectedMinute != nil && setAlarm == true {
            scheduleLocal(identifier: randomNum!)
        }
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func saveToUserDefaults() {
        let todoForSave = Todo(todoTag: 231241, date: "20192929", time: "02020", memo: "292929", color: "basic", setAlarm: true)
        let encodedTodoList = try! PropertyListEncoder().encode(todoForSave)
        UserDefaults.standard.set(encodedTodoList, forKey: "TodoList")
        
        if let decodedTodoList = try? PropertyListDecoder().decode(Todo.self, from: UserDefaults.standard.object(forKey: "TodoList") as! Data) {
            print(decodedTodoList.memo)
        }
    }
    
    @objc func didTapColor(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            settingTodoImage.image = UIImage(named: "TableViewCellPink")
            colorName = "TableViewCellPink"
        case 2:
            settingTodoImage.image = UIImage(named: "TableViewCellBlue")
            colorName = "TableViewCellBlue"
        case 3:
            settingTodoImage.image = UIImage(named: "TableViewCellRed")
            colorName = "TableViewCellRed"
        case 4:
            settingTodoImage.image = UIImage(named: "TableViewCellGreen")
            colorName = "TableViewCellGreen"
        case 5:
            settingTodoImage.image = UIImage(named: "TableViewCellCyan")
            colorName = "TableViewCellCyan"
        case 6:
            settingTodoImage.image = UIImage(named: "TableViewCellBasic")
            colorName = "TableViewCellBasic"
        case 7:
            settingTodoImage.image = UIImage(named: "TableViewCellOrange")
            colorName = "TableViewCellOrange"
        case 8:
            settingTodoImage.image = UIImage(named: "TableViewCellPurple")
            colorName = "TableViewCellPurple"
        default:
            break
        }
    }
    
    @objc private func didTapPickerOkButton() {
        settingTodoAlarmButton.setImage(UIImage(named: "ReserveAlarmButton"), for: .normal)
        setAlarm = true
        timePickerView.isHidden = true
    }
    
    @objc private func didTapPickerCancelButton() {
        settingTodoAlarmButton.setImage(UIImage(named: "NotReserveAlarmButton-1"), for: .normal)
        setAlarm = false
        timeLabel.text = ""
        timePickerView.isHidden = true
    }
    
    @objc private func didTapSettingAlarmButton() {
        timePickerView.isHidden = false
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //날짜 선택 시 콜백 메소드
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일 EEE"
        if dateFormatter.string(from: date).first == "0" {
            var resultDate = dateFormatter.string(from: date)
            
            resultDate.removeFirst()
            print(resultDate)
            dateLabel.text = resultDate
        } else {
            dateLabel.text = dateFormatter.string(from: date)
        }
        
        dateFormatter.dateFormat = "YYYY"
        selectedYear = dateFormatter.string(from: date)
        print(selectedYear!)
        dateFormatter.dateFormat = "MM"
        selectedMonth = dateFormatter.string(from: date)
        print(selectedMonth!)
        
        dateFormatter.dateFormat = "dd"
        selectedDay = dateFormatter.string(from: date)
        print(selectedDay!)
        
        
    }
    // 날짜 선택 해제 시 콜백 메소드
    public func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        //            let dateFormatter = DateFormatter()
        //            dateFormatter.dateFormat = "YYYY-MM-dd"
        //            print(dateFormatter.string(from: date))
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        if date < calendar.today! {
            return false
        } else {
            return true
        }
    }
    
    //MARK: RegisterLocal
    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            }else{
                print("D'oh!")
            }
        }
    }
    
    @objc func scheduleLocal(identifier: Int) {
        //        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Todo!"
        content.body = todoTextField.text ?? ""
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = .default
        
        //        var dateComponents = DateComponents()
        //        dateComponents.hour = 10
        //        dateComponents.minute = 30
        //        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        //
        //        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        //        center.add(request)
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        dateComponents.year = Int(selectedYear!)
        dateComponents.month = Int(selectedMonth!)
        dateComponents.hour = Int(selectedHour!)
        dateComponents.minute = Int(selectedMinute!)
        
        print(
            dateComponents.year = Int(selectedYear!),
            dateComponents.month = Int(selectedMonth!),
            dateComponents.hour = Int(selectedHour!),
            dateComponents.minute = Int(selectedMinute!)
        )
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        //        let uuidString = UUID().uuidString
        let notiIdentifier = "\(identifier)"
        let request = UNNotificationRequest(identifier: notiIdentifier,
                                            content: content, trigger: trigger)
        
        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if error != nil {
                // Handle any errors.
                print("예약실패")
            }
            print("예약완료")
        }
        
        
        
    }
    
    
    
}

extension AddTodoViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        return true
    }
    
    @objc func keyboardWillShowNotification(_ noti: Notification) {
        guard let userInfo = noti.userInfo,
            let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect, //frame의 최종 위치
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
            else { return }
        keyboardDuration = duration
        
        if frame.origin.y >= UIScreen.main.bounds.height {
            //내려갔을 때
            
        }
        
        UIView.animate(withDuration: duration) {
            //content
            
            self.calendar.isHidden = true
            self.settingTodoCell.transform = .init(translationX: 0, y: -(self.underCalenderView.frame.height))
            self.colorPickButtonGreen.transform = .init(translationX: 0, y: -(self.underCalenderView.frame.height))
            self.colorPickButtonRed.transform = .init(translationX: 0, y: -(self.underCalenderView.frame.height))
            self.colorPickButtonBlue.transform = .init(translationX: 0, y: -(self.underCalenderView.frame.height))
            self.colorPickButtonPink.transform = .init(translationX: 0, y: -(self.underCalenderView.frame.height))
            self.colorPickButtonPurple.transform = .init(translationX: 0, y: -(self.underCalenderView.frame.height))
            self.colorPickButtonOrange.transform = .init(translationX: 0, y: -(self.underCalenderView.frame.height))
            self.colorPickButtonBasic.transform = .init(translationX: 0, y: -(self.underCalenderView.frame.height))
            self.colorPickButtonCyan.transform = .init(translationX: 0, y: -(self.underCalenderView.frame.height))
            self.makeTodoButton.transform = .init(translationX: 0, y: -(self.underCalenderView.frame.height))
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        UIView.animate(withDuration: keyboardDuration ?? 0.3) {
            self.calendar.isHidden = false
            self.settingTodoCell.transform = .identity
            self.colorPickButtonGreen.transform = .identity
            self.colorPickButtonRed.transform = .identity
            self.colorPickButtonBlue.transform = .identity
            self.colorPickButtonPink.transform = .identity
            self.colorPickButtonPurple.transform = .identity
            self.colorPickButtonOrange.transform = .identity
            self.colorPickButtonBasic.transform = .identity
            self.colorPickButtonCyan.transform = .identity
            self.makeTodoButton.transform = .identity
        }
        
        
    }
    
    
}


extension AddTodoViewController: FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        if date < calendar.today! {
            return UIColor.lightGray
        } else {
            return UIColor.black
        }
    }
}
