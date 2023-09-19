//
//  ViewController.swift
//  M21_Homework
//
//  Created by Maxim Nikolaev on 15.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let counterCatching = UILabel()
    let screenSize: CGRect = UIScreen.main.bounds

    var fishesArray: [UIImageView] = []
    
    var count: Int = 0
    var isAllFishCatched = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        configureConstraints()
        
        let backImage = UIImage(named: "ocean") ?? UIImage()
        view.backgroundColor = UIColor(patternImage: backImage)
        startMovingFishes()
    }
    
    private func startMovingFishes() {
        count = 0
        counterCatching.text = "Counter: \(count)"
        for _ in 1...5 {
            let image = UIImage(named: "fish")
            let view = UIImageView(image: image)
            view.frame = CGRect( x: 0, y: 0, width: 150, height: 150)
            view.contentMode = .scaleAspectFit
            view.isUserInteractionEnabled = true
            fishesArray.append(view)
        }

        for oneFish in fishesArray {
            let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
            oneFish.addGestureRecognizer(tap)
            view.addSubview(oneFish)
            moveRight(fish: oneFish)

            print("create fish number \(oneFish.description)")
        }
    }
    
    private func configureViews() {
        counterCatching.text = "Counter: \(count)"
        counterCatching.textColor = .black
        counterCatching.font = .systemFont(ofSize: 40)
        counterCatching.textAlignment = .center
    }
    
    private func configureConstraints() {
        counterCatching.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(counterCatching)
        
        NSLayoutConstraint.activate([
            counterCatching.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            counterCatching.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            counterCatching.widthAnchor.constraint(equalToConstant: 200),
            counterCatching.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    func moveLeft(fish: UIImageView) {
        if count == 5 {
            startMovingFishes()
        }
      
        let randomNumberX: Int = .random(in: 30...Int(screenSize.width))
        let randomNumberY: Int = .random(in: 20...Int(screenSize.height))
      UIView.animate(withDuration: 3,
                     delay: 0.0,
                     options: [.curveEaseInOut , .allowUserInteraction],
                     animations: {
          fish.center = CGPoint(x: randomNumberX, y: randomNumberY)
      },
                     completion: { finished in
                      print("fish moved left!")
          self.moveBottom(fish: fish)
      })
    }
    
    func moveRight(fish: UIImageView) {
        if count == 5 {
            startMovingFishes()
        }
        
          let randomNumberX: Int = .random(in: 30...Int(screenSize.width))
          let randomNumberY: Int = .random(in: 20...Int(screenSize.height))
        UIView.animate(withDuration: 3,
                       delay: 0.0,
                       options: [.curveEaseInOut , .allowUserInteraction],
                       animations: {
            fish.center = CGPoint(x: randomNumberX, y: randomNumberY)
        },
                       completion: { finished in
                        print("fish moved right!")
                        self.moveLeft(fish: fish)
        })
    }
    
    func moveTop(fish: UIImageView) {
        if count == 5 {
            startMovingFishes()
        }
        
          let randomNumberX: Int = .random(in: 30...Int(screenSize.width))
          let randomNumberY: Int = .random(in: 20...Int(screenSize.height))
        UIView.animate(withDuration: 3,
                       delay: 0.0,
                       options: [.curveEaseInOut , .allowUserInteraction],
                       animations: {
            fish.center = CGPoint(x: randomNumberX, y: randomNumberY)
        },
                       completion: { finished in
                        print("fish moved left!")
                        self.moveRight(fish: fish)
        })
    }
    
    func moveBottom(fish: UIImageView) {
        if count == 5 {
            startMovingFishes()
        }
        
          let randomNumberX: Int = .random(in: 30...Int(screenSize.width))
          let randomNumberY: Int = .random(in: 20...Int(screenSize.height))
        UIView.animate(withDuration: 3,
                       delay: 0.0,
                       options: [.curveEaseInOut , .allowUserInteraction],
                       animations: {
            fish.center = CGPoint(x: randomNumberX, y: randomNumberY)
        },
                       completion: { finished in
                        print("fish moved bottom!")
                        self.moveTop(fish: fish)
        })
    }
    
    @objc func didTap(_ gesture: UITapGestureRecognizer) {
        if count < 5 {
            count += 1
            counterCatching.text = "Counter: \(count)"
            print("fish tapped!")
            print(count)
            gesture.view?.isHidden = true
            if let fishIndex = self.fishesArray.firstIndex(where: { $0 == gesture.view }) {
                fishesArray.remove(at: fishIndex)
                print(fishesArray.count)
            }
        }
    }

    func fishCatchedAnimation() {
        
        
//            self.fish.alpha = 0.3
//        let randomNumberX: Int = .random(in: 30...Int(screenSize.width))
//        let randomNumberY: Int = .random(in: 20...Int(screenSize.height))
//      UIView.animate(withDuration: 0.3,
//                     delay: 0.0,
//                     options: [.curveEaseInOut , .allowUserInteraction],
//                     animations: {
//          fish.center = CGPoint(x: randomNumberX, y: randomNumberY)
//      },
//                       completion: { finished in
//                        print("fish stopped!")
//        })
//        fish.stopAnimating()
    }
}

