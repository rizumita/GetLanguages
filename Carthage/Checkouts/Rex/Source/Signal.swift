//
//  Signal.swift
//  Rex
//
//  Created by Neil Pankey on 5/9/15.
//  Copyright (c) 2015 Neil Pankey. All rights reserved.
//

import ReactiveCocoa
import enum Result.NoError

extension SignalType {

    /// Applies `transform` to values from `signal` with non-`nil` results unwrapped and
    /// forwared on the returned signal.
    public func filterMap<U>(transform: Value -> U?) -> Signal<U, Error> {
        return Signal<U, Error> { observer in
            return self.observe(Observer(next: { value in
                if let val = transform(value) {
                    observer.sendNext(val)
                }
            }, failed: { error in
                observer.sendFailed(error)
            }, completed: {
                observer.sendCompleted()
            }, interrupted: {
                observer.sendInterrupted()
            }))
        }
    }

    /// Returns a signal that drops `Error` sending `replacement` terminal event
    /// instead, defaulting to `Completed`.
    public func ignoreError(replacement replacement: Event<Value, NoError> = .Completed) -> Signal<Value, NoError> {
        precondition(replacement.isTerminating)

        return Signal<Value, NoError> { observer in
            return self.observe { event in
                switch event {
                case let .Next(value):
                    observer.sendNext(value)
                case .Failed:
                    observer.action(replacement)
                case .Completed:
                    observer.sendCompleted()
                case .Interrupted:
                    observer.sendInterrupted()
                }
            }
        }
    }

    /// Forwards events from `signal` until `interval`. Then if signal isn't completed yet,
    /// terminates with `event` on `scheduler`.
    ///
    /// If the interval is 0, the timeout will be scheduled immediately. The signal
    /// must complete synchronously (or on a faster scheduler) to avoid the timeout.
    public func timeoutAfter(interval: NSTimeInterval, withEvent event: Event<Value, Error>, onScheduler scheduler: DateSchedulerType) -> Signal<Value, Error> {
        precondition(interval >= 0)
        precondition(event.isTerminating)

        return Signal { observer in
            let disposable = CompositeDisposable()

            let date = scheduler.currentDate.dateByAddingTimeInterval(interval)
            disposable += scheduler.scheduleAfter(date) {
                observer.action(event)
            }

            disposable += self.observe(observer)
            return disposable
        }
    }

    /// Enforces that at least `interval` time passes before forwarding a value. If a
    /// new value arrives, the previous one is dropped and the `interval` delay starts
    /// again. Error events are immediately forwarded, even if there's a queued value.
    ///
    /// This operator is useful for scenarios like type-to-search where you want to
    /// wait for a "lull" in typing before kicking off a search request.
    public func debounce(interval: NSTimeInterval, onScheduler scheduler: DateSchedulerType) -> Signal<Value, Error> {
        precondition(interval >= 0)

        return flatMap(.Latest) {
            SignalProducer(value: $0).delay(interval, onScheduler: scheduler)
        }
    }

    /// Forwards a value and then mutes the signal by dropping all subsequent values
    /// for `interval` seconds. Once time elapses the next new value will be forwarded
    /// and repeat the muting process. Error events are immediately forwarded even while
    /// the signal is muted.
    ///
    /// This operator could be used to coalesce multiple notifications in a short time
    /// frame by only showing the first one.
    public func muteFor(interval: NSTimeInterval, clock: DateSchedulerType) -> Signal<Value, Error> {
        precondition(interval > 0)

        var expires = clock.currentDate
        return filter { _ in
            let now = clock.currentDate

            if expires.compare(now) != .OrderedDescending {
                expires = now.dateByAddingTimeInterval(interval)
                return true
            }
            return false
        }
    }
}

extension SignalType where Value: SequenceType {
    /// Returns a signal that flattens sequences of elements. The inverse of `collect`.
    public func uncollect() -> Signal<Value.Generator.Element, Error> {
        return Signal<Value.Generator.Element, Error> { observer in
            return self.observe { event in
                switch event {
                case let .Next(sequence):
                    sequence.forEach { observer.sendNext($0) }
                case let .Failed(error):
                    observer.sendFailed(error)
                case .Completed:
                    observer.sendCompleted()
                case .Interrupted:
                    observer.sendInterrupted()
                }
            }
        }
    }
}
