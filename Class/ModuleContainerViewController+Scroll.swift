////
////  MBseModuleViewController.swift
////  Pods
////
////  Created by jeffery on 2017/8/21.
////
////
//
//import UIKit
//import RxCocoa
//import RxSwift
//import SnapKit
//
//var beginOffset: CGFloat = 0
//
//extension MModuleContainerViewController {
//    
//    open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        beginOffset = scrollView.contentOffset.y
//    }
//    
//    func addObserver(for scrollview: UIScrollView) {
//        scrollview
//            .rx
//            .didScroll
//            .subscribe(onNext: { [weak self] () in
//                self?.didScroll()
//            })
//            .disposed(by: disposeBag)
//        
//        scrollview
//            .rx
//            .contentOffset
//            .subscribe(onNext: { [weak self] (point) in
//                if point.y <= -scrollview.contentInset.top {
//                    self?.restoreNavigation(with: false)
//                }
//            })
//            .disposed(by: disposeBag)
//    
//        scrollview
//            .rx
//            .didEndDragging
//            .subscribe(onNext: { [weak self] (end) in
//                self?.beginOffset = nil
//            }).disposed(by: disposeBag)
//
//        scrollview
//            .rx
//            .didEndDecelerating
//            .subscribe(onNext: { [weak self] () in
//                self?.beginOffset = nil
//            })
//            .disposed(by: disposeBag)
//
//        scrollview
//            .rx
//            .didEndScrollingAnimation
//            .subscribe(onNext: { [weak self] () in
//                self?.beginOffset = nil
//            })
//            .disposed(by: disposeBag)
//    }
//
//    fileprivate func didScroll() {
//        let scrollView = contentView
//        if let variable = hoverVariable, movingNavigationView != nil {
//            let distance = scrollView.contentOffset.y + scrollView.contentInset.top
//            let threshold = variable.frame.origin.y + scrollView.contentInset.top
//            let hover = variable.hoverView
//            if distance >= threshold {
//                if variable.isIdentity() {
//                    hover.removeFromSuperview()
//                    view.addSubview(hover)
//                    hover.transform = .identity
//                    hover.snp.removeConstraints()
//                    hover.snp.makeConstraints({ (maker) in
//                        maker.size.equalTo(CGSize(width: variable.frame.width, height: variable.frame.height))
//                        maker.top.equalTo(self.topLayoutGuide.snp.bottom)
//                        maker.left.equalToSuperview()
//                    })
//                }
//            } else {
//                if !variable.isIdentity() {
//                    hover.transform = .identity
//                    hover.removeFromSuperview()
//                    variable.addSubview(hover)
//                    hover.snp.removeConstraints()
//                    hover.snp.makeConstraints({ (maker) in
//                        maker.edges.equalToSuperview()
//                    })
//                }
//            }
//        }
//        guard let offset = beginOffset else { return }
//        if scrollView.contentOffset.y > offset {
//            hideNavigation()
//        } else {
//            restoreNavigation()
//        }
//    }
//}
//
//extension MModuleContainerViewController {
//    
//    fileprivate func hideNavigation() {
//        guard let view = movingNavigationView else { return }
//        guard !isAnimating else { return }
//        guard view.transform.ty == 0 else { return }
//        UIView.animate(withDuration: 0.35, animations: {
//            view.transform = CGAffineTransform(translationX: 0, y: -view.frame.height)
//            if let hover = self.hoverVariable, !hover.isIdentity() {
//                hover.hoverView.transform = .identity
//            }
//        }, completion: { (finish) in
//            self.isAnimating = !finish
//            view.alpha = 0
//        })
//    }
//    
//    fileprivate func restoreNavigation(with animate: Bool = true) {
//        guard let view = movingNavigationView else { return }
//        guard !isAnimating else { return }
//        guard view.transform.ty < 0 else { return }
//        if animate {
//            view.alpha = 1
//            UIView.animate(withDuration: 0.35, animations: {
//                view.transform = .identity
//                if let hover = self.hoverVariable, !hover.isIdentity() {
//                    hover.hoverView.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
//                }
//            }, completion: { (finish) in
//                self.isAnimating = !finish
//            })
//        } else {
//            view.transform = .identity
//            view.alpha = 1
//            if let hover = self.hoverVariable, !hover.isIdentity() {
//                hover.hoverView.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
//            }
//            isAnimating = false
//        }
//    }
//}
//
