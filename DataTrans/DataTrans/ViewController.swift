//
//  ViewController.swift
//  DataTrans
//
//  Created by hq on 2022/11/6.
//

import UIKit
import WidgetKit

class ViewController: UIViewController {

    private var inputText: UITextField?
    private var setButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        setButtonFunction()
    }


}

private extension ViewController {
    func setupView() {
        inputText = UITextField(frame: CGRect(x: 0, y: 100, width: self.view.bounds.width - 40, height: 60))
        setButton = UIButton(frame: CGRect(x: 0, y: 200, width: 60, height: 60))

        guard let setButton = setButton else { return }
        guard let inputText = inputText else { return }

        setButton.setTitle("set", for: .normal)
        setButton.backgroundColor = .blue
        setButton.center.x = view.center.x
        setButton.layer.cornerRadius = 10

        inputText.center.x = view.center.x
        inputText.borderStyle = .bezel

        view.addSubview(inputText)
        view.addSubview(setButton)
    }

    func setButtonFunction() {
        guard let setButton = setButton else { return }
        setButton.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
    }

    @objc func buttonClick() {
        guard let inputText = inputText else { return }
        let userDefaults = UserDefaults(suiteName: "group.learn.lihuiqi")
        userDefaults?.set(inputText.text, forKey: "text")

        inputText.text = nil
        WidgetCenter.shared.reloadAllTimelines()
    }
}
