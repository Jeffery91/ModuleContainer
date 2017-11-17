//
//  MessageBus.swift
//  Pods
//
//  Created by jeffery on 2017/8/21.
//
//

import Foundation
import RxSwift

public class MessageBus {
    
    public init() {}
    
    private var subjectMap = [String: Any]()
    
    public func observable(for keyPath: String) -> Observable<Any> {
        var subject = subjectMap[keyPath]
        if subject == nil {
            subject = PublishSubject<Any>()
            subjectMap[keyPath] = subject
        }
        
        return subjectMap[keyPath] as! Observable<Any>
    }
    
    public func updateValue(value: Any, for keyPath: String) {
        let subject = subjectMap[keyPath]
        (subject as? PublishSubject<Any>)?.onNext(value)
    }
}
