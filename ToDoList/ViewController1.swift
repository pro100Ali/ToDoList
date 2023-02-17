//
//  ViewController1.swift
//  ToDoList
//
//  Created by Али  on 17.02.2023.
//

import UIKit

class ViewController1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
        button.frame = view.bounds
        // Do any additional setup after loading the view.
    }
    private var button: UIButton {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .systemGreen
        button.setTitle("Get started", for: .normal)
        button.titleLabel?.font = UIFont(name: "Futura-Bold", size: 15)
        self.view.addSubview(button)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didButton(_ : )), for: .touchUpInside)
        self.view.addSubview(button)
//        button.isHovered = true
        button.sizeToFit()

        // Calculate the center point of the screen
        let centerX = UIScreen.main.bounds.midX
        let centerY = UIScreen.main.bounds.midY

        // Set the center of the button to the center point of the screen
        button.center = CGPoint(x: centerX, y: centerY)
        return button
    }
    
    @objc private func didButton(_ : UIButton) {
        let newViewController = ViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
