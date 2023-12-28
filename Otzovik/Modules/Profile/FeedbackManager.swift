//
//  FeedbackManager.swift
//  Otzovik
//
//  Created by Александр Денисов on 08.12.2023.
//

import Foundation

final class FeedbackManager {
    func loadFeedbacks(completion: @escaping (([Feedback]) -> Void)) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let feedbacks: [Feedback] = [
                .init(name: "Александрова Галина",
                         title: "Норм препод",
                         content: "Creating a Date and Time in SwiftIn Swift, dates and times are stored in a 64-bit floating point number measuring the number of seconds since the reference date of January 1, 2001 at 00:00:00 UTC. This is expressed in the Date structure. The following would give you the current date and time:",
                         date: DateComponents(year: 2023, month: 11, day: 23)),
                .init(name: "Name Surname",
                         title: "Some title",
                         content: "Some content",
                         date: DateComponents(year: 2023, month: 11, day: 23)),
                .init(name: "Name Surname",
                         title: "Some title",
                         content: "Some content",
                         date: DateComponents(year: 2023, month: 11, day: 23)),
                .init(name: "Name Surname",
                         title: "Some title",
                         content: "Some content",
                         date: DateComponents(year: 2023, month: 11, day: 23)),
                .init(name: "Name Surname",
                         title: "Some title",
                         content: "Some content",
                         date: DateComponents(year: 2023, month: 11, day: 23)),
                .init(name: "Name Surname",
                         title: "Some title",
                         content: "Some content",
                         date: DateComponents(year: 2023, month: 11, day: 23)),
                .init(name: "Name Surname",
                         title: "Some title",
                         content: "Some content",
                         date: DateComponents(year: 2023, month: 11, day: 23)),
                .init(name: "Name Surname",
                         title: "Some title",
                         content: "Some content",
                         date: DateComponents(year: 2023, month: 11, day: 23)),
                .init(name: "Name Surname",
                         title: "Some title",
                         content: "Some content",
                         date: DateComponents(year: 2023, month: 11, day: 23)),
                .init(name: "Name Surname",
                         title: "Some title",
                         content: "Some content",
                         date: DateComponents(year: 2023, month: 11, day: 23)),
                .init(name: "Name Surname",
                         title: "Some title",
                         content: "Some content",
                         date: DateComponents(year: 2023, month: 11, day: 23)),
                .init(name: "Name Surname",
                         title: "Some title",
                         content: "Some content",
                         date: DateComponents(year: 2023, month: 11, day: 23)),
                .init(name: "Name Surname",
                         title: "Some title",
                         content: "Some content",
                         date: DateComponents(year: 2023, month: 11, day: 23)),
                .init(name: "Name Surname",
                         title: "Some title",
                         content: "Some content",
                         date: DateComponents(year: 2023, month: 11, day: 23))
            ]
            completion(feedbacks)
        }
    }
}
