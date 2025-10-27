import Foundation
import AVFoundation

class ConversationManager: ObservableObject {
    private let synthesizer = AVSpeechSynthesizer()
    @Published var isProcessing = false
    
    func speak(_ text: String, completion: (() -> Void)? = nil) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5 // Slower rate for elderly users
        utterance.volume = 0.9
        
        if let completion = completion {
            NotificationCenter.default.addObserver(forName: .AVSpeechSynthesizerDidFinishSpeechUtterance,
                                                object: synthesizer,
                                                queue: nil) { _ in
                completion()
                NotificationCenter.default.removeObserver(self,
                                                        name: .AVSpeechSynthesizerDidFinishSpeechUtterance,
                                                        object: self.synthesizer)
            }
        }
        
        synthesizer.speak(utterance)
    }
    
    func getGreeting() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        let greeting: String
        
        switch hour {
        case 5..<12:
            greeting = "Good morning"
        case 12..<17:
            greeting = "Good afternoon"
        case 17..<22:
            greeting = "Good evening"
        default:
            greeting = "Hello"
        }
        
        return "\(greeting)! How can I help you today?"
    }
    
    func parseReminderRequest(_ text: String) -> (title: String, time: Date)? {
        // TODO: Implement more sophisticated parsing with OpenAI
        // For MVP, look for basic time patterns
        let lowercased = text.lowercased()
        
        // Simple time patterns
        if let timeRange = lowercased.range(of: "at \\d{1,2}( ?(?:am|pm))?", options: .regularExpression) {
            let timeStr = String(lowercased[timeRange])
            let title = String(lowercased.prefix(upTo: timeRange.lowerBound)).trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Convert time string to Date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h a"
            
            if let date = dateFormatter.date(from: timeStr.replacingOccurrences(of: "at ", with: "")) {
                return (title, date)
            }
        }
        
        return nil
    }
}