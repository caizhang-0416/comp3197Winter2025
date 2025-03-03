//
//  LaunchScreenVC.swift
//  SmartShopper
//
//  Created by Cai Zhang on 2025-02-16.
//

import UIKit

class LaunchScreenVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set background color (customize as needed)
        view.backgroundColor = .white
        
        // Delay transition to the main view
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.transitionToMainScreen()
        }
    }
    
    private func transitionToMainScreen() {
        guard let window = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .flatMap({ $0.windows })
                .first(where: { $0.isKeyWindow }) else {
            return
        }
        
        let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController")
        
        // Smooth fade-out transition
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
            window.rootViewController = mainVC
        })
    }
}

