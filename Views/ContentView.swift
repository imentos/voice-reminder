import SwiftUI

struct ContentView: View {
    @StateObject private var voiceManager = VoiceManager()
    @StateObject private var conversationManager = ConversationManager()
    @State private var isListening = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // Voice Input Status
                Text(isListening ? "Listening..." : "Tap to Start")
                    .font(.largeTitle)
                    .foregroundColor(isListening ? .blue : .primary)
                
                // Recognized Text Display
                Text(voiceManager.recognizedText)
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 150)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                
                // Main Action Button
                Button(action: toggleListening) {
                    Image(systemName: isListening ? "mic.fill" : "mic")
                        .font(.system(size: 64))
                        .foregroundColor(isListening ? .blue : .primary)
                        .padding()
                        .background(Circle().stroke(isListening ? Color.blue : Color.gray, lineWidth: 3))
                }
                .padding()
                
                if let error = voiceManager.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .padding()
            .navigationTitle("Voice Reminder")
            .onAppear {
                voiceManager.requestAuthorization()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    conversationManager.speak(conversationManager.getGreeting())
                }
            }
        }
    }
    
    private func toggleListening() {
        if isListening {
            voiceManager.stopRecording()
            processVoiceCommand()
        } else {
            do {
                try voiceManager.startRecording()
            } catch {
                print("Failed to start recording: \(error)")
            }
        }
        isListening.toggle()
    }
    
    private func processVoiceCommand() {
        let text = voiceManager.recognizedText
        if let reminder = conversationManager.parseReminderRequest(text) {
            // TODO: Save reminder and schedule notification
            conversationManager.speak("I've set a reminder for \(reminder.title) at \(reminder.time)")
        } else {
            conversationManager.speak("I didn't quite catch that. Could you please try again?")
        }
    }
}