//
//  Bindable.swift
//  Belarus
//
//  Created by user on 21.10.22.
//

import Foundation

class Bindable<Value> {
    private var observations = [(Value) -> Bool]()
    var lastValue: Value?
    
    init(_ value: Value? = nil) {
        lastValue = value
    }
}

private extension Bindable {
    func addObservation<T: AnyObject>(for object: T, handler: @escaping (T, Value) -> Void) {
        lastValue.map { handler(object, $0) }
        observations.append { [weak object] value in
            guard let object = object else {return false}
            handler(object, value)
            return true
        }
    }
}

extension Bindable {
    func update(with newValue: Value) {
        lastValue = newValue
        observations = observations.filter { $0(newValue) }
    }
}

extension Bindable {
    func bind<T: AnyObject, V>(
        _ sourceKeyPath: KeyPath<Value, V>,
        to object: T,
        _ objectKeyPath: ReferenceWritableKeyPath<T, V>) {
            addObservation(for: object) { object, observed in
                let value = observed[keyPath: sourceKeyPath]
                DispatchQueue.main.async {
                    object[keyPath: objectKeyPath] = value
                }
            }
        }
    
    func bind<T: AnyObject, V>(
        _ sourceKeyPath: KeyPath<Value, V>,
        to object: T,
        _ objectKeyPath: ReferenceWritableKeyPath<T, V?>) {
            addObservation(for: object) { object, observed in
                let value = observed[keyPath: sourceKeyPath]
                DispatchQueue.main.async {
                    object[keyPath: objectKeyPath] = value
                }
            }
        }
    
    func bind<T: AnyObject, V, R>(
        _ sourceKeyPath: KeyPath<Value, V>,
        to object: T,
        _ objectKeyPath: ReferenceWritableKeyPath<T, R?>,
        transform: @escaping (V) -> R?
    ) {
        addObservation(for: object) { object, observed in
            let value = observed[keyPath: sourceKeyPath]
            let transformed = transform(value)
            DispatchQueue.main.async {
                object[keyPath: objectKeyPath] = transformed
            }
        }
    }
}
