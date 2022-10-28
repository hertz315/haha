//
//  ViewController.swift
//  Dailly_Challenge_SearchView
//
//  Created by Hertz on 9/14/22.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - @IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var textfieldContainerViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var textField: DesignableUITextField!
    
    @IBOutlet weak var searchTitle: UILabel!
    
    @IBOutlet weak var textFieldContainerView: UIView!
    
    @IBOutlet weak var recommendedLabel: UILabel!
    
    @IBOutlet weak var recommendedStackView: UIStackView!
    
    @IBOutlet weak var popularSearchTermsLabel: UILabel!
    
    
    // MARK: - 전역변수
    // 데이터를 관리하기위한 에러이
    var model: [PopularTerms] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 모델 데이터 셋업
        self.model = setUpData()
        // 테이블뷰 닙파일 등록
        let uiNib = UINib(nibName: TableViewCell.identifier, bundle: nil)
        tableView.register(uiNib, forCellReuseIdentifier: TableViewCell.identifier)
        // 테이블 뷰 셋업
        setUpTableView()
        // 텍스트필드 셋업
        setUpTextField()
        // 노티피케이션 옵저버 등록
        notioficationSetUp()


    }
    
    // MARK: - 노티피케이션 셋업
    func notioficationSetUp() {
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           return
        }
      
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                guard let self = self else { return }
                self.textfieldContainerViewTopConstraint.constant = 10
            })
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseOut, animations: { [weak self] in
                guard let self = self else { return }
                self.textfieldContainerViewTopConstraint.constant = 61
            })
        }
    }
    
  
    
    // MARK: - @IBAction
    @IBAction func recommendedkeywords(_ sender: UIButton) {
        // ⭐️키워드를 클릭하면 해당 키워드가 검색창에 입력됩니다 - 완료
        textField.text = sender.currentTitle
    }
    
    
    func setUpTextField() {
        // 텍스트 필드 델리게이트 채택
        textField.delegate = self
        // 텍스트 필드 text 색깔 설정
        textField.textColor = .black
    }
    
    func setUpData() -> [PopularTerms]  {
        let model = PopularTermsDataManager.makePopularTerms()
        return model
    }
    
    func setUpTableView() {
        // 테이블뷰 밑줄 라인 제거
        tableView.separatorStyle = .none
        
        // 테이블뷰 델리게이트 채택
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        tableView.allowsSelection = true
        
        
        
        // 쎌의 백그라운드 색깔 설정
        tableView.backgroundColor = UIColor.white
        
    }
    
    // 쎌사이의 인셋 주기
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = tableView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }
    


}

// MARK: - 텍스트 필드 델리게이트
extension ViewController: UITextFieldDelegate {
    // 키보드 바깥에 터치하면 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
        // 추천 검색어 , 인기검색어 화면 다시 표시
        self.searchTitle.isHidden = false
        self.popularSearchTermsLabel.isHidden = false
        self.recommendedLabel.isHidden = false
        self.recommendedStackView.isHidden = false
        self.tableView.isHidden = false
    }
    
    // 텍스트 필드 포커시시 한번만 호출
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("⭐️ - 키보드 포커스 상태")
        self.searchTitle.isHidden = true
        self.popularSearchTermsLabel.isHidden = true
        self.recommendedLabel.isHidden = true
        self.recommendedStackView.isHidden = true
        self.tableView.isHidden = true
        
    }
    
}


// MARK: - 테이블뷰 데이터 소스
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setUpData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        
        // 쎌 선택시 색상 없애기
        cell.selectionStyle = .none
        
        cell.popularSearchTermLabel.text = setUpData()[indexPath.row].title
        cell.backgroundColor = UIColor.white
        
        // 쿵짝쿵짝
        return cell
    }
    
    
}

// MARK: - 테이블뷰 델리게이트
extension ViewController: UITableViewDelegate {
    // ⭐️ 인기 검색어를 클릭하면 검색창에 해당 검색어가 입력됩니다 - 완료
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 쎌 클릭시 선택된 데이터 가져오기
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        cell.popularSearchTermLabel.text = model[indexPath.row].title
        self.textField.text = cell.popularSearchTermLabel.text
    }

}

