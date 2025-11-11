// FTC Scout - ContentView definitions
import SwiftUI
import Charts

// MARK: - Main Content View (Home Screen)
struct ContentView: View {
    @State private var showingDeleteAlert = false
    
    // Archive UI state
    @State private var archiveName: String = ""
    @State private var archiveDate: Date = Date()
    @State private var archives: [ArchivedCompetition] = []
    @State private var showingArchiveSaved = false
    @State private var archiveValidationMessage: String?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    // Header Section
                    VStack(spacing: 0) {
                        ZStack {
                            // Background gradient
                            LinearGradient(
                                colors: [
                                    Color.blue.opacity(0.05),
                                    Color.white,
                                    Color.orange.opacity(0.05)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            
                            VStack(spacing: 24) {
                                // App Icon
                                ZStack {
                                    LinearGradient(
                                        colors: [Color.blue, Color.orange],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                    .frame(width: 96, height: 96)
                                    .cornerRadius(24)
                                    .shadow(radius: 10)
                                    
                                    // Use SF Symbol for cross-platform compatibility
                                    Image(systemName: "trophy.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 48, height: 48)
                                        .foregroundColor(.white)
                                }
                                
                                // Title
                                VStack(spacing: 8) {
                                    Text("FTC Scout")
                                        .font(.system(size: 40, weight: .bold))
                                        .foregroundColor(.primary)
                                }
                                
                                // User Info
                                VStack(spacing: 4) {
                                    
                                    Text("Built By: Aakarsh Kachalia")
                                        .font(.title3)
                                        .fontWeight(.medium)
                                        .foregroundColor(.orange)
                                    
                                    Text("FTC Team 7083 TundraBots")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.blue)
                                    
                                    Text("Raleigh, North Carolina")
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .foregroundStyle(.black)
                                    
                            
                                }
                                
                                // Subtitle
                                VStack(spacing: 8) {
                                    Text("Professional Robotics Competitive Analysis")
                                        .font(.title3)
                                        .foregroundColor(.secondary)
                                    
                                    Text("Use this app to enchance your team's scouting capabilities and make informed decisions during critical moments in a competition. Especially during alliance selection!")
                                        .font(.body)
                                        .foregroundColor(.secondary)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal)
                                }
                            }
                            .padding(.vertical, 48)
                        }
                    }
                    
                    // Features Grid
                    VStack(spacing: 24) {
                        // Pit Scouting Card
                        NavigationLink(destination: PitScoutingView()) {
                            FeatureCard(
                                title: "Pit Scouting",
                                description: "Go to each team and scout them, recieve data, and put it here!",
                                features: [
                                    "Team compatibility",
                                    "Saved notes on each team",
                                    "Rank teams by performance"
                                ],
                                iconName: "person.2.fill",
                                gradientColors: [.blue, Color.blue.opacity(0.8)],
                                buttonText: "Start Pit Scouting"
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        // Match Scouting Card
                        NavigationLink(destination: MatchScoutingView()) {
                            FeatureCard(
                                title: "Match Scouting",
                                description: "View each match throughout the competition, analyze performance of indiviudual teams, and strategize!",
                                features: [
                                    "Copy your schedule onto the app",
                                    "Bar chart to show individual team preformance",
                                    "Rate each team on a scale of 0-5 based on their performance throughout the match"
                                ],
                                // Use app icon for this card
                                iconName: "trophy.fill",
                                gradientColors: [.orange, Color.orange.opacity(0.8)],
                                buttonText: "Start Match Scouting"
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal, 16)
                    
                    // Data Management Section
                    VStack(spacing: 16) {
                        // Archive Section (moved above Delete All Data)
                        GroupBox {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Archive")
                                    .font(.headline)
                                
                                Text("Save a snapshot of this competition’s data. Archives are kept locally, listed by date, and can be viewed later.")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Competition Name")
                                        .font(.subheadline)
                                    TextField("e.g., League Meet #2", text: $archiveName)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                }
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Date")
                                        .font(.subheadline)
                                    DatePicker("Select Date", selection: $archiveDate, displayedComponents: .date)
                                        .datePickerStyle(.compact)
                                        .labelsHidden()
                                }
                                
                                HStack {
                                    Button(action: archiveCurrentCompetition) {
                                        HStack {
                                            Image(systemName: "archivebox.fill")
                                            Text("Archive Competition")
                                        }
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 10)
                                        .background(archiveName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? Color.gray.opacity(0.6) : Color.blue)
                                        .cornerRadius(8)
                                    }
                                    .disabled(archiveName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                                    
                                    Spacer()
                                    
                                    NavigationLink(destination: ArchivedCompetitionsView()) {
                                        HStack {
                                            Image(systemName: "clock.arrow.circlepath")
                                            Text("View Archives")
                                        }
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 10)
                                        .background(Color.orange)
                                        .cornerRadius(8)
                                    }
                                }
                                
                                if let validation = archiveValidationMessage {
                                    Text(validation)
                                        .font(.caption)
                                        .foregroundColor(.red)
                                }
                            }
                            .padding()
                        }
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(12)
                        
                        // Delete All Data Section (now below Archive)
                        GroupBox {
                            VStack(spacing: 16) {
                                VStack(spacing: 8) {
                                    Text("Data Management")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    
                                    Text("Reset all scouting data to start fresh for a new competition")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                        .multilineTextAlignment(.center)
                                }
                                
                                Button(action: { showingDeleteAlert = true }) {
                                    HStack {
                                        Image(systemName: "trash")
                                            .font(.system(size: 16))
                                        Text("Delete All Data")
                                            .fontWeight(.medium)
                                    }
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 24)
                                    .padding(.vertical, 12)
                                    .background(Color.red)
                                    .cornerRadius(8)
                                }
                            }
                            .padding()
                        }
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(12)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 32)
                    
                    // Footer
                    VStack {
                        Divider()
                            .padding(.vertical, 32)
                        
                        Text("Created by Team 7083 TundraBots • FTC Scout")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 16)
                }
            }
            .navigationBarHidden(true)
            .alert("Delete All Data", isPresented: $showingDeleteAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) {
                    deleteAllData()
                }
            } message: {
                Text("Are you sure you want to delete all saved data? This cannot be undone.")
            }
            .alert("Archived", isPresented: $showingArchiveSaved) {
                Button("OK") { }
            } message: {
                Text("Your competition has been archived.")
            }
            .onAppear(perform: loadArchives)
        }
    }
    
    private func deleteAllData() {
        // Clear UserDefaults data (equivalent to localStorage)
        UserDefaults.standard.removeObject(forKey: "eventTeams")
        UserDefaults.standard.removeObject(forKey: "pitScoutingScores")
        UserDefaults.standard.removeObject(forKey: "pitScoutingRankings")
        UserDefaults.standard.removeObject(forKey: "matchScoutingSetup")
        UserDefaults.standard.removeObject(forKey: "matchScoutingData")
        UserDefaults.standard.removeObject(forKey: "matchScoutingFinalized")
    }
    
    // MARK: - Archive helpers
    private func loadArchives() {
        if let data = UserDefaults.standard.data(forKey: "archivedCompetitions"),
           let decoded = try? JSONDecoder().decode([ArchivedCompetition].self, from: data) {
            archives = decoded
        } else {
            archives = []
        }
    }
    
    private func saveArchives(_ list: [ArchivedCompetition]) {
        if let encoded = try? JSONEncoder().encode(list) {
            UserDefaults.standard.set(encoded, forKey: "archivedCompetitions")
        }
    }
    
    private func archiveCurrentCompetition() {
        let trimmedName = archiveName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else {
            archiveValidationMessage = "Please enter a competition name."
            return
        }
        archiveValidationMessage = nil
        
        // Keys we want to snapshot
        let keys = [
            "eventTeams",
            "pitScoutingScores",
            "pitScoutingRankings",
            "matchScoutingSetup",
            "matchScoutingData",
            "matchScoutingFinalized"
        ]
        
        var snapshot: [String: Data] = [:]
        let defaults = UserDefaults.standard
        
        for key in keys {
            if let data = defaults.data(forKey: key) {
                snapshot[key] = data
            } else if key == "matchScoutingFinalized" {
                // This one may be a Bool; encode it if present
                if let boolValue = defaults.object(forKey: key) as? Bool,
                   let encoded = try? JSONEncoder().encode(boolValue) {
                    snapshot[key] = encoded
                }
            }
        }
        
        let archive = ArchivedCompetition(
            id: UUID(),
            name: trimmedName,
            date: archiveDate,
            payload: snapshot
        )
        
        // Append and sort by date (newest first)
        var updated = archives
        updated.append(archive)
        updated.sort { $0.date > $1.date }
        
        saveArchives(updated)
        archives = updated
        
        // Reset form and notify
        archiveName = ""
        archiveDate = Date()
        showingArchiveSaved = true
    }
}

// MARK: - Feature Card Component
struct FeatureCard: View {
    let title: String
    let description: String
    let features: [String]
    let iconName: String
    let gradientColors: [Color]
    let buttonText: String
    
    var body: some View {
        VStack {
            ZStack {
                // Decorative background shape
                Circle()
                    .fill(LinearGradient(colors: gradientColors.map { $0.opacity(0.1) }, startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 128, height: 128)
                    .offset(x: 80, y: -40)
                
                VStack(alignment: .leading, spacing: 16) {
                    HStack(alignment: .top, spacing: 16) {
                        // Icon
                        ZStack {
                            LinearGradient(colors: gradientColors, startPoint: .topLeading, endPoint: .bottomTrailing)
                                .frame(width: 64, height: 64)
                                .cornerRadius(16)
                            
                            // Use SF Symbol
                            Image(systemName: iconName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32, height: 32)
                                .foregroundColor(.white)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(title)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            
                            Text(description)
                                .font(.body)
                                .foregroundColor(.secondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        
                        Spacer()
                    }
                    
                    // Features List
                    VStack(alignment: .leading, spacing: 4) {
                        ForEach(features, id: \.self) { feature in
                            HStack {
                                Image(systemName: "target")
                                    .font(.system(size: 16))
                                    .foregroundColor(gradientColors[0])
                                Text(feature)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                        }
                    }
                    .padding(.leading, 80)
                    
                    // Removed the inner button since the NavigationLink handles the navigation
                    Text(buttonText)
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(
                            LinearGradient(colors: gradientColors, startPoint: .leading, endPoint: .trailing)
                        )
                        .cornerRadius(12)
                        .padding(.leading, 80)
                }
                .padding(24)
            }
        }
        .background(Color(UIColor.systemBackground))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(title == "Pit Scouting" ? Color.blue.opacity(0.2) : Color.orange.opacity(0.2), lineWidth: 2)
        )
        .shadow(radius: 8)
        .scaleEffect(0.98)
    }
}

// MARK: - Pit Scouting View
struct PitScoutingView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var teams: [Team] = []
    @State private var showingTeamEntry = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.blue.opacity(0.1), Color.orange.opacity(0.1)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                // Header
                HStack {
                    Button(action: { presentationMode.wrappedValue.dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20))
                            .foregroundColor(.primary)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Pit Scouting")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("Enter all teams at your event")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                }
                .padding()
                .background(Color(UIColor.systemBackground))
                .shadow(radius: 2)
                
                ScrollView {
                    VStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Event Teams")
                                .font(.headline)
                                .fontWeight(.semibold)
                            
                            Text("Enter all the teams participating in your event. These will be used throughout the app. Data is saved automatically.")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        
                        // Teams Table
                        VStack(spacing: 0) {
                            HStack {
                                Text("Team Number")
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text("Team Name")
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text("Actions")
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .foregroundColor(.secondary)
                                    .frame(width: 60)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(Color(UIColor.systemGray6))
                            
                            LazyVStack(spacing: 0) {
                                ForEach(teams.indices, id: \.self) { index in
                                    TeamRowView(
                                        team: $teams[index],
                                        onDelete: { deleteTeam(at: index) }
                                    )
                                    
                                    if index < teams.count - 1 {
                                        Divider()
                                    }
                                }
                            }
                        }
                        .background(Color(UIColor.systemBackground))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        
                        // Buttons
                        HStack {
                            Button(action: addTeam) {
                                HStack {
                                    Image(systemName: "plus")
                                    Text("Add Team")
                                }
                                .foregroundColor(.blue)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(8)
                            }
                            
                            Spacer()
                            
                            NavigationLink(destination: PitScoutingSummaryView()) {
                                Text("Generate Scouting Tables")
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(
                                        LinearGradient(
                                            colors: [.blue, Color.blue.opacity(0.8)],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .cornerRadius(8)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear(perform: loadTeams)
        .onReceive(NotificationCenter.default.publisher(for: .teamDataChanged)) { _ in
            saveTeams()
        }
    }
    
    private func loadTeams() {
        if let data = UserDefaults.standard.data(forKey: "eventTeams"),
           let savedTeams = try? JSONDecoder().decode([Team].self, from: data) {
            // Filter out any completely blank rows that may have been saved earlier
            teams = savedTeams.filter { team in
                let num = team.teamNumber.trimmingCharacters(in: .whitespacesAndNewlines)
                let name = team.teamName.trimmingCharacters(in: .whitespacesAndNewlines)
                return !(num.isEmpty && name.isEmpty)
            }
        } else {
            // Start with no rows; user can add explicitly
            teams = []
        }
    }
    
    private func saveTeams() {
        if let encoded = try? JSONEncoder().encode(teams) {
            UserDefaults.standard.set(encoded, forKey: "eventTeams")
        }
    }
    
    private func addTeam() {
        teams.append(Team(teamNumber: "", teamName: ""))
        saveTeams()
    }
    
    private func deleteTeam(at index: Int) {
        guard teams.indices.contains(index) else { return }
        teams.remove(at: index)
        saveTeams()
    }
}

// MARK: - Team Row Component
struct TeamRowView: View {
    @Binding var team: Team
    let onDelete: (() -> Void)?
    
    var body: some View {
        HStack(spacing: 12) {
            TextField("e.g., 7083", text: $team.teamNumber)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(.horizontal, 8)
                .padding(.vertical, 12)
                .onChange(of: team.teamNumber) { oldValue, newValue in
                    // Save immediately when text changes
                    saveTeamData()
                }
            
            Spacer()
            
            TextField("e.g., TundraBots", text: $team.teamName)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(.horizontal, 8)
                .padding(.vertical, 12)
                .onChange(of: team.teamName) { oldValue, newValue in
                    // Save immediately when text changes
                    saveTeamData()
                }
            
            Spacer()
            
            Button(action: { onDelete?() }) {
                Image(systemName: "trash")
                    .foregroundColor(onDelete != nil ? .red : .gray)
            }
            .frame(width: 60)
        }
        .padding(.horizontal)
    }
    
    private func saveTeamData() {
        // We need to trigger the parent's save function
        // This is handled by the parent view's logic
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // Small delay to batch rapid changes
            NotificationCenter.default.post(name: .teamDataChanged, object: nil)
        }
    }
}

// Notification for team data changes
extension Notification.Name {
    static let teamDataChanged = Notification.Name("teamDataChanged")
}

// MARK: - Team Data Model
struct Team: Codable, Identifiable {
    let id: UUID
    var teamNumber: String
    var teamName: String
    
    init(id: UUID = UUID(), teamNumber: String = "", teamName: String = "") {
        self.id = id
        self.teamNumber = teamNumber
        self.teamName = teamName
    }
}

// MARK: - Pit Scouting Summary View
struct PitScoutingSummaryView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var teams: [Team] = []
    @State private var teamScores: [String: TeamScore] = [:]
    @State private var finalRankings: [TeamScore] = []
    @State private var currentTableIndex = 0
    @State private var showingRankingsAlert = false
    
    private let tables = [
        ScoutingTable(id: 1, title: "Auto Performance Notes", columns: ["Team Number", "Team Name", "Auto Performance Notes"], dataKey: "auto"),
        ScoutingTable(id: 2, title: "TeleOp Performance Notes", columns: ["Team Number", "Team Name", "TeleOp Performance Notes"], dataKey: "teleop"),
        ScoutingTable(id: 3, title: "Endgame Performance Notes", columns: ["Team Number", "Team Name", "Endgame Performance Notes"], dataKey: "endgame"),
        ScoutingTable(id: 4, title: "Team Compatibility & Overall Assessment", columns: ["Team Number", "Team Name", "Compatibility Score (0-10)", "Overall Score (0-10)"], dataKey: "overall"),
        ScoutingTable(id: 5, title: "Final Team Rankings", columns: ["Rank", "Team Number", "Team Name", "Average Score"], dataKey: "rank")
    ]
    
    // Filter helper to avoid blank rows anywhere in summary
    private var nonEmptyTeams: [Team] {
        teams.filter { team in
            let num = team.teamNumber.trimmingCharacters(in: .whitespacesAndNewlines)
            let name = team.teamName.trimmingCharacters(in: .whitespacesAndNewlines)
            return !(num.isEmpty && name.isEmpty)
        }
    }
    
    // Filter helper for rankings to ensure no blank row ever renders
    private var nonEmptyRankings: [TeamScore] {
        finalRankings.filter { ranking in
            !ranking.teamNumber.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.blue.opacity(0.1), Color.orange.opacity(0.1)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                // Header
                HStack {
                    Button(action: { presentationMode.wrappedValue.dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20))
                            .foregroundColor(.primary)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Summary Tables")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("Swipe to navigate between ranking tables")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "person.2.fill")
                        .font(.system(size: 24))
                        .foregroundColor(.blue)
                }
                .padding()
                .background(Color.systemBackground)
                .shadow(radius: 2)
                
                VStack {
                    Text("Use these tables to assess and analyze all teams at your competition with detailed notes.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    // Table Carousel
                    TabView(selection: $currentTableIndex) {
                        ForEach(tables.indices, id: \.self) { index in
                            ScrollView {
                                VStack(spacing: 16) {
                                    Text(tables[index].title)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.center)
                                        .padding(.top)
                                    
                                    VStack(spacing: 0) {
                                        // Header
                                        HStack {
                                            ForEach(tables[index].columns, id: \.self) { column in
                                                Text(column)
                                                    .font(.caption)
                                                    .fontWeight(.medium)
                                                    .foregroundColor(.secondary)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                            }
                                        }
                                        .padding()
                                        .background(Color(UIColor.systemGray6))
                                        
                                        // Content
                                        LazyVStack(spacing: 0) {
                                            renderTableContent(for: tables[index])
                                        }
                                    }
                                    .background(Color.systemBackground)
                                    .cornerRadius(12)
                                    .padding(.horizontal)
                                }
                            }
                            .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    
                    // Navigation and Generate Button
                    HStack {
                        // Page indicators (dots)
                        HStack(spacing: 8) {
                            ForEach(0..<5) { index in
                                Circle()
                                    .fill(index == currentTableIndex ? Color.blue : Color.gray.opacity(0.4))
                                    .frame(width: 8, height: 8)
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: generateFinalRankings) {
                            Text("Generate Final Rankings")
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear(perform: loadData)
        .alert("Rankings Generated", isPresented: $showingRankingsAlert) {
            Button("OK") { }
        } message: {
            Text("Final team rankings have been generated and saved.")
        }
    }
    
    @ViewBuilder
    private func renderTableContent(for table: ScoutingTable) -> some View {
        if table.dataKey == "rank" {
            let list = nonEmptyRankings
            if list.isEmpty {
                HStack {
                    Text("Click \"Generate Final Rankings\" to see ranked teams")
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
            } else {
                ForEach(list.indices, id: \.self) { index in
                    let team = list[index]
                    HStack {
                        Text("#\(index + 1)")
                            .font(.body)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(team.teamNumber)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(team.teamName)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(String(format: "%.1f", (team.compatibilityScore + team.overallScore) / 2))
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                    
                    if index < list.count - 1 {
                        Divider()
                    }
                }
            }
        } else if table.dataKey == "overall" {
            let list = Array(nonEmptyTeams.prefix(8))
            ForEach(list.indices, id: \.self) { index in
                let team = list[index]
                HStack {
                    Text(team.teamNumber)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(team.teamName)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    TextField("0-10", value: Binding(
                        get: { teamScores[team.teamNumber]?.compatibilityScore ?? 0 },
                        set: { updateTeamScore(team.teamNumber, field: "compatibility", value: $0) }
                    ), format: .number)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: .infinity)
                    
                    TextField("0-10", value: Binding(
                        get: { teamScores[team.teamNumber]?.overallScore ?? 0 },
                        set: { updateTeamScore(team.teamNumber, field: "overall", value: $0) }
                    ), format: .number)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: .infinity)
                }
                .padding()
                
                if index < min(list.count, 8) - 1 {
                    Divider()
                }
            }
        } else {
            let list = Array(nonEmptyTeams.prefix(8))
            ForEach(list.indices, id: \.self) { index in
                let team = list[index]
                HStack {
                    Text(team.teamNumber)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(team.teamName)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    TextField("Enter notes about this team...", text: Binding(
                        get: { getTeamNotes(team.teamNumber, field: table.dataKey) },
                        set: { updateTeamNotes(team.teamNumber, field: table.dataKey, value: $0) }
                    ), axis: .vertical)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 60)
                }
                .padding()
                
                if index < min(list.count, 8) - 1 {
                    Divider()
                }
            }
        }
    }
    
    private func loadData() {
        // Load teams
        if let data = UserDefaults.standard.data(forKey: "eventTeams"),
           let savedTeams = try? JSONDecoder().decode([Team].self, from: data) {
            // Drop any fully-blank rows
            teams = savedTeams.filter { team in
                let num = team.teamNumber.trimmingCharacters(in: .whitespacesAndNewlines)
                let name = team.teamName.trimmingCharacters(in: .whitespacesAndNewlines)
                return !(num.isEmpty && name.isEmpty)
            }
            
            // Initialize team scores for non-empty team numbers only
            for team in teams {
                let key = team.teamNumber.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !key.isEmpty else { continue }
                if teamScores[key] == nil {
                    teamScores[key] = TeamScore(
                        teamNumber: team.teamNumber,
                        teamName: team.teamName,
                        autoScore: "",
                        teleopScore: "",
                        endgameScore: "",
                        compatibilityScore: 0,
                        overallScore: 0
                    )
                }
            }
        }
        
        // Load saved scores
        if let data = UserDefaults.standard.data(forKey: "pitScoutingScores"),
           let savedScores = try? JSONDecoder().decode([String: TeamScore].self, from: data) {
            teamScores = savedScores
            // Remove any accidental empty-key entries
            teamScores.removeValue(forKey: "")
        }
        
        // Load saved rankings and filter out any blank team numbers
        if let data = UserDefaults.standard.data(forKey: "pitScoutingRankings"),
           let savedRankings = try? JSONDecoder().decode([TeamScore].self, from: data) {
            finalRankings = savedRankings.filter { !($0.teamNumber.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) }
        }
    }
    
    private func updateTeamScore(_ teamNumber: String, field: String, value: Double) {
        let key = teamNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !key.isEmpty else { return }
        
        if teamScores[key] == nil {
            let team = teams.first { $0.teamNumber == teamNumber }
            teamScores[key] = TeamScore(
                teamNumber: teamNumber,
                teamName: team?.teamName ?? "",
                autoScore: "",
                teleopScore: "",
                endgameScore: "",
                compatibilityScore: 0,
                overallScore: 0
            )
        }
        
        if field == "compatibility" {
            teamScores[key]?.compatibilityScore = value
        } else if field == "overall" {
            teamScores[key]?.overallScore = value
        }
        
        saveScores()
    }
    
    private func getTeamNotes(_ teamNumber: String, field: String) -> String {
        let key = teamNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !key.isEmpty, let score = teamScores[key] else { return "" }
        switch field {
        case "auto": return score.autoScore
        case "teleop": return score.teleopScore
        case "endgame": return score.endgameScore
        default: return ""
        }
    }
    
    private func updateTeamNotes(_ teamNumber: String, field: String, value: String) {
        let key = teamNumber.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !key.isEmpty else { return }
        
        if teamScores[key] == nil {
            let team = teams.first { $0.teamNumber == teamNumber }
            teamScores[key] = TeamScore(
                teamNumber: teamNumber,
                teamName: team?.teamName ?? "",
                autoScore: "",
                teleopScore: "",
                endgameScore: "",
                compatibilityScore: 0,
                overallScore: 0
            )
        }
        
        switch field {
        case "auto":
            teamScores[key]?.autoScore = value
        case "teleop":
            teamScores[key]?.teleopScore = value
        case "endgame":
            teamScores[key]?.endgameScore = value
        default:
            break
        }
        
        saveScores()
    }
    
    private func saveScores() {
        if let encoded = try? JSONEncoder().encode(teamScores) {
            UserDefaults.standard.set(encoded, forKey: "pitScoutingScores")
        }
    }
    
    private func generateFinalRankings() {
        // Only rank teams with non-empty team numbers
        let rankedTeams = Array(teamScores.values)
            .filter { !$0.teamNumber.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            .sorted { ($0.compatibilityScore + $0.overallScore) / 2 > ($1.compatibilityScore + $1.overallScore) / 2 }
        
        finalRankings = rankedTeams
        
        if let encoded = try? JSONEncoder().encode(finalRankings) {
            UserDefaults.standard.set(encoded, forKey: "pitScoutingRankings")
        }
        
        currentTableIndex = 4 // Navigate to rankings table
        showingRankingsAlert = true
    }
}

// MARK: - Data Models for Pit Scouting
struct ScoutingTable {
    let id: Int
    let title: String
    let columns: [String]
    let dataKey: String
}

struct TeamScore: Codable {
    var teamNumber: String
    var teamName: String
    var autoScore: String
    var teleopScore: String
    var endgameScore: String
    var compatibilityScore: Double
    var overallScore: Double
}

// MARK: - Match Scouting View
struct MatchScoutingView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isSetupComplete = false
    @State private var isScheduleFinalized = false
    @State private var matchSetup = MatchSetup(totalMatches: 0, ourTeam: "", matches: [])
    @State private var matchData: [MatchData] = []
    @State private var setupForm = SetupForm(totalMatches: "", ourTeam: "")
    @State private var showingResetAlert = false
    @State private var showingValidationAlert = false
    @State private var validationMessage = ""
    
    // New: switch between Scoring and Schedule views after finalization
    @State private var selectedMainTab = 0 // 0 = Scoring, 1 = Schedule
    
    var body: some View {
        Group {
            if !isSetupComplete {
                setupView
            } else if !isScheduleFinalized {
                scheduleView
            } else {
                mainScoutingView
            }
        }
        .navigationBarHidden(true)
        .onAppear(perform: loadSavedData)
    }
    
    private var setupView: some View {
        ZStack {
            LinearGradient(
                colors: [Color.orange.opacity(0.1), Color.red.opacity(0.1)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                // Header
                headerView(
                    title: "Match Scouting Setup",
                    subtitle: "Configure your competition schedule",
                    icon: "gear"
                )
                
                ScrollView {
                    VStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Competition Setup")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.horizontal)
                            
                            VStack(spacing: 16) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Total Number of Matches")
                                        .font(.headline)
                                    TextField("Enter total matches (e.g., 12)", text: $setupForm.totalMatches)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.numberPad)
                                }
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Our Team Number")
                                        .font(.headline)
                                    TextField("Enter your team number", text: $setupForm.ourTeam)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.numberPad)
                                }
                                
                                Button(action: handleSetupSubmit) {
                                    Text("Create Match Schedule")
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(
                                            (setupForm.totalMatches.isEmpty || setupForm.ourTeam.isEmpty) 
                                            ? Color.gray.opacity(0.5) 
                                            : Color.orange
                                        )
                                        .cornerRadius(8)
                                }
                                .disabled(setupForm.totalMatches.isEmpty || setupForm.ourTeam.isEmpty)
                            }
                            .padding()
                            .background(Color.systemBackground)
                            .cornerRadius(12)
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top)
                }
            }
        }
        .alert("Validation Error", isPresented: $showingValidationAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(validationMessage)
        }
    }
    
    private var scheduleView: some View {
        ZStack {
            LinearGradient(
                colors: [Color.orange.opacity(0.1), Color.red.opacity(0.1)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                headerView(
                    title: "Match Schedule Entry",
                    subtitle: "Enter the official competition schedule",
                    icon: "gear"
                )
                
                ScrollView {
                    VStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Enter Team Schedule")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.horizontal)
                            
                            Text("Competition: \(matchSetup.totalMatches) matches | Our Team: \(matchSetup.ourTeam)")
                                .font(.body)
                                .foregroundColor(.secondary)
                                .padding(.horizontal)
                            
                            VStack(spacing: 0) {
                                // Header
                                HStack {
                                    Text("Match").frame(maxWidth: .infinity)
                                    Text("Red 1").frame(maxWidth: .infinity).foregroundColor(.red)
                                    Text("Red 2").frame(maxWidth: .infinity).foregroundColor(.red)
                                    Text("Blue 1").frame(maxWidth: .infinity).foregroundColor(.blue)
                                    Text("Blue 2").frame(maxWidth: .infinity).foregroundColor(.blue)
                                }
                                .font(.caption)
                                .fontWeight(.medium)
                                .padding()
                                .background(Color(UIColor.systemGray6))
                                
                                LazyVStack(spacing: 0) {
                                    ForEach(matchSetup.matches.indices, id: \.self) { index in
                                        MatchScheduleRow(
                                            match: $matchSetup.matches[index],
                                            onUpdate: { updateMatchTeam(index, $0, $1) }
                                        )
                                        
                                        if index < matchSetup.matches.count - 1 {
                                            Divider()
                                        }
                                    }
                                }
                            }
                            .background(Color.systemBackground)
                            .cornerRadius(12)
                            .padding(.horizontal)
                            
                            HStack(spacing: 12) {
                                Button(action: finalizeSchedule) {
                                    HStack {
                                        Image(systemName: "checkmark")
                                        Text("Finalize Schedule & Start Scouting")
                                    }
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.green)
                                    .cornerRadius(8)
                                }
                                
                                Button(action: { showingResetAlert = true }) {
                                    HStack {
                                        Image(systemName: "trash")
                                        Text("Reset Setup")
                                    }
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.red)
                                    .cornerRadius(8)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top)
                }
            }
        }
        .alert("Reset Setup", isPresented: $showingResetAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Reset", role: .destructive) { resetAllData() }
        } message: {
            Text("Are you sure you want to reset all match scouting data?")
        }
        .alert("Validation Error", isPresented: $showingValidationAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(validationMessage)
        }
    }
    
    private var mainScoutingView: some View {
        ZStack {
            LinearGradient(
                colors: [Color.orange.opacity(0.1), Color.red.opacity(0.1)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                // Header with reset button
                HStack {
                    Button(action: { presentationMode.wrappedValue.dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20))
                            .foregroundColor(.primary)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Match Scouting")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("Team \(matchSetup.ourTeam) | \(matchSetup.totalMatches) matches")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button(action: { showingResetAlert = true }) {
                            HStack {
                                Image(systemName: "trash")
                                Text("Reset")
                            }
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.red)
                            .cornerRadius(6)
                        }
                        
                        // Replaced with SF Symbol for cross-platform compatibility
                        Image(systemName: "trophy.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.orange)
                    }
                }
                .padding()
                .background(Color.systemBackground)
                .shadow(radius: 2)
                
                // Segmented control to switch between Scoring and Schedule views
                Picker("", selection: $selectedMainTab) {
                    Text("Scoring").tag(0)
                    Text("Schedule").tag(1)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .padding(.top, 8)
                
                // Content
                if selectedMainTab == 1 {
                    // Schedule view (read-only), with our team highlighted
                    scheduleListView
                } else {
                    // Scoring + Analytics view
                    ScrollView {
                        VStack(spacing: 24) {
                            // Performance Chart (if data exists)
                            if hasValidScoreData() {
                                performanceChartView
                            }
                            
                            // Match Data Entry
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Match Data Entry")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding(.horizontal)
                                
                                if matchData.isEmpty {
                                    VStack(spacing: 16) {
                                        Image(systemName: "chart.bar")
                                            .font(.system(size: 60))
                                            .foregroundColor(.gray)
                                        
                                        Text("No match data available")
                                            .font(.title3)
                                            .foregroundColor(.gray)
                                        
                                        Text("Please complete the schedule setup first")
                                            .font(.body)
                                            .foregroundColor(.secondary)
                                            .multilineTextAlignment(.center)
                                    }
                                    .padding(.vertical, 40)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.systemBackground)
                                    .cornerRadius(12)
                                    .padding(.horizontal)
                                } else {
                                    LazyVStack(spacing: 16) {
                                        ForEach(matchData.indices, id: \.self) { matchIndex in
                                            MatchDataEntryCard(
                                                matchData: $matchData[matchIndex],
                                                matchIndex: matchIndex,
                                                onScoreUpdate: { updateScore(matchIndex, $0, $1, $2) }
                                            )
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                        .padding(.top)
                    }
                }
            }
        }
        .alert("Reset All Data", isPresented: $showingResetAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Reset", role: .destructive) { resetAllData() }
        } message: {
            Text("Are you sure you want to reset all match scouting data?")
        }
    }
    
    // Read-only schedule view highlighting our team in yellow
    private var scheduleListView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Finalized Schedule")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .padding(.top, 8)
                
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        Text("Match").frame(maxWidth: .infinity, alignment: .leading)
                        Text("Red 1").frame(maxWidth: .infinity, alignment: .leading)
                        Text("Red 2").frame(maxWidth: .infinity, alignment: .leading)
                        Text("Blue 1").frame(maxWidth: .infinity, alignment: .leading)
                        Text("Blue 2").frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .font(.caption)
                    .fontWeight(.medium)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    
                    // Rows
                    LazyVStack(spacing: 0) {
                        ForEach(matchSetup.matches, id: \.matchNumber) { m in
                            HStack(spacing: 8) {
                                Text("Q\(m.matchNumber)")
                                    .fontWeight(.medium)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                scheduleTeamLabel(m.redTeam1)
                                scheduleTeamLabel(m.redTeam2)
                                scheduleTeamLabel(m.blueTeam1)
                                scheduleTeamLabel(m.blueTeam2)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            
                            if m.matchNumber != matchSetup.matches.last?.matchNumber {
                                Divider()
                            }
                        }
                    }
                }
                .background(Color.systemBackground)
                .cornerRadius(12)
                .padding(.horizontal)
            }
            .padding(.bottom, 16)
        }
    }
    
    // Helper: label that highlights our team
    @ViewBuilder
    private func scheduleTeamLabel(_ team: String) -> some View {
        let trimmed = team.trimmingCharacters(in: .whitespacesAndNewlines)
        let isOurTeam = !matchSetup.ourTeam.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && trimmed == matchSetup.ourTeam.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Text(trimmed.isEmpty ? "-" : trimmed)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(isOurTeam ? Color.yellow.opacity(0.35) : Color.clear)
            .cornerRadius(6)
    }
    
    @ViewBuilder
    private var performanceChartView: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .foregroundColor(.blue)
                Text("Performance Analytics")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            .padding(.horizontal)
            
            VStack(spacing: 20) {
                // Summary Statistics
                if let stats = generateSummaryStats() {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Competition Summary")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 12) {
                            StatCard(title: "Teams Tracked", value: "\(stats.teamsCount)", icon: "person.2.fill", color: .blue)
                            StatCard(title: "Matches Scored", value: "\(stats.matchesWithData)", icon: "trophy.fill", color: .orange)
                            StatCard(title: "Avg Performance", value: String(format: "%.1f", stats.overallAverage), icon: "chart.bar.fill", color: .green)
                        }
                        .padding(.horizontal)
                    }
                }
                
                // Performance Breakdown Chart only
                VStack(alignment: .leading, spacing: 12) {
                    Text("Performance Categories (Auto/TeleOp/Endgame)")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    if let breakdownData = generateBreakdownData() {
                        // Compute a dynamic width so bars don't overlap and allow horizontal scrolling
                        let teamOrder = Array(Set(breakdownData.map { $0.teamNumber })).sorted()
                        let teamCount = max(1, teamOrder.count)
                        // Width per team group (3 bars per team); tweak as desired
                        let widthPerTeam: CGFloat = 90
                        let minChartWidth: CGFloat = 500
                        let totalWidth = max(minChartWidth, CGFloat(teamCount) * widthPerTeam)
                        
                        ScrollView(.horizontal) {
                            Chart(breakdownData) { dataPoint in
                                BarMark(
                                    x: .value("Team", dataPoint.teamNumber),
                                    y: .value("Score", dataPoint.score),
                                    width: .ratio(0.7)
                                )
                                .foregroundStyle(by: .value("Category", dataPoint.category))
                                .position(by: .value("Category", dataPoint.category))
                            }
                            // Ensure consistent categorical spacing/order
                            .chartXScale(domain: teamOrder)
                            // Custom axis to avoid overlapping labels
                            .chartXAxis {
                                AxisMarks(values: teamOrder) { value in
                                    AxisGridLine()
                                    AxisTick()
                                    AxisValueLabel {
                                        if let teamNumber = value.as(String.self) {
                                            Text("Team \(teamNumber)")
                                                .font(.caption)
                                                .fixedSize() // prevent truncation into ellipsis
                                        }
                                    }
                                }
                            }
                            .frame(width: totalWidth, height: 200)
                            .padding(.horizontal)
                            .chartYScale(domain: 0...5)
                            .chartLegend(position: .bottom, alignment: .center)
                            .chartYAxis {
                                AxisMarks(position: .leading) { value in
                                    AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5))
                                        .foregroundStyle(.gray.opacity(0.3))
                                    AxisTick()
                                    AxisValueLabel {
                                        if let intValue = value.as(Double.self) {
                                            Text("\(Int(intValue))")
                                                .font(.caption)
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        Text("No breakdown data yet. Enter some scores to see averages by category.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                    }
                }
            }
            .background(Color.systemBackground)
            .cornerRadius(12)
            .padding(.horizontal)
        }
    }
    
    @ViewBuilder
    private func headerView(title: String, subtitle: String, icon: String) -> some View {
        HStack {
            Button(action: { presentationMode.wrappedValue.dismiss() }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 20))
                    .foregroundColor(.primary)
            }
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.orange)
        }
        .padding()
        .background(Color.systemBackground)
        .shadow(radius: 2)
    }
    
    // Data management functions
    private func loadSavedData() {
        if let data = UserDefaults.standard.data(forKey: "matchScoutingSetup"),
           let setup = try? JSONDecoder().decode(MatchSetup.self, from: data) {
            matchSetup = setup
            isSetupComplete = true
        }
        
        if let data = UserDefaults.standard.data(forKey: "matchScoutingData"),
           let data = try? JSONDecoder().decode([MatchData].self, from: data) {
            matchData = data
        }
        
        if let finalized = UserDefaults.standard.object(forKey: "matchScoutingFinalized") as? Bool {
            isScheduleFinalized = finalized
        }
    }
    
    private func handleSetupSubmit() {
        guard let totalMatches = Int(setupForm.totalMatches), totalMatches > 0 else {
            validationMessage = "Please enter a valid number of matches (greater than 0)."
            showingValidationAlert = true
            return
        }
        
        guard !setupForm.ourTeam.trimmingCharacters(in: .whitespaces).isEmpty else {
            validationMessage = "Please enter your team number."
            showingValidationAlert = true
            return
        }
        
        let matches = (1...totalMatches).map { matchNumber in
            MatchSetupData(
                matchNumber: matchNumber,
                redTeam1: "",
                redTeam2: "",
                blueTeam1: "",
                blueTeam2: ""
            )
        }
        
        matchSetup = MatchSetup(
            totalMatches: totalMatches,
            ourTeam: setupForm.ourTeam.trimmingCharacters(in: .whitespaces),
            matches: matches
        )
        
        if let encoded = try? JSONEncoder().encode(matchSetup) {
            UserDefaults.standard.set(encoded, forKey: "matchScoutingSetup")
        }
        
        isSetupComplete = true
    }
    
    private func updateMatchTeam(_ matchIndex: Int, _ position: String, _ teamNumber: String) {
        switch position {
        case "redTeam1": matchSetup.matches[matchIndex].redTeam1 = teamNumber
        case "redTeam2": matchSetup.matches[matchIndex].redTeam2 = teamNumber
        case "blueTeam1": matchSetup.matches[matchIndex].blueTeam1 = teamNumber
        case "blueTeam2": matchSetup.matches[matchIndex].blueTeam2 = teamNumber
        default: break
        }
        
        if let encoded = try? JSONEncoder().encode(matchSetup) {
            UserDefaults.standard.set(encoded, forKey: "matchScoutingSetup")
        }
    }
    
    private func finalizeSchedule() {
        // Validate that at least some teams are entered
        let hasValidTeams = matchSetup.matches.contains { match in
            !match.redTeam1.trimmingCharacters(in: .whitespaces).isEmpty ||
            !match.redTeam2.trimmingCharacters(in: .whitespaces).isEmpty ||
            !match.blueTeam1.trimmingCharacters(in: .whitespaces).isEmpty ||
            !match.blueTeam2.trimmingCharacters(in: .whitespaces).isEmpty
        }
        
        guard hasValidTeams else {
            validationMessage = "Please enter at least some team numbers in the schedule before finalizing."
            showingValidationAlert = true
            return
        }
        
        let initialMatchData: [MatchData] = matchSetup.matches.map { match in
            var scores: [String: TeamScores] = [:]
            
            let teams = [match.redTeam1, match.redTeam2, match.blueTeam1, match.blueTeam2]
            for team in teams where !team.trimmingCharacters(in: .whitespaces).isEmpty {
                scores[team] = TeamScores(auto: 0, teleop: 0, endgame: 0, matchAverage: 0)
            }
            
            return MatchData(
                matchNumber: match.matchNumber,
                redTeam1: match.redTeam1,
                redTeam2: match.redTeam2,
                blueTeam1: match.blueTeam1,
                blueTeam2: match.blueTeam2,
                scores: scores
            )
        }
        
        matchData = initialMatchData
        isScheduleFinalized = true
        
        // Save both the match data and the finalized status
        saveMatchData()
        UserDefaults.standard.set(true, forKey: "matchScoutingFinalized")
    }
    
    private func updateScore(_ matchIndex: Int, _ teamNumber: String, _ field: String, _ value: Int) {
        // Ensure the match index is valid
        guard matchIndex < matchData.count else { return }
        
        let clampedValue = max(0, min(5, value))
        
        if matchData[matchIndex].scores[teamNumber] == nil {
            matchData[matchIndex].scores[teamNumber] = TeamScores(auto: 0, teleop: 0, endgame: 0, matchAverage: 0)
        }
        
        switch field {
        case "auto":
            matchData[matchIndex].scores[teamNumber]?.auto = clampedValue
        case "teleop":
            matchData[matchIndex].scores[teamNumber]?.teleop = clampedValue
        case "endgame":
            matchData[matchIndex].scores[teamNumber]?.endgame = clampedValue
        default:
            break
        }
        
        // Calculate match average
        if let scores = matchData[matchIndex].scores[teamNumber] {
            matchData[matchIndex].scores[teamNumber]?.matchAverage = Double(scores.auto + scores.teleop + scores.endgame) / 3.0
        }
        
        // Save data immediately
        saveMatchData()
    }
    
    private func saveMatchData() {
        if let encoded = try? JSONEncoder().encode(matchData) {
            UserDefaults.standard.set(encoded, forKey: "matchScoutingData")
        }
    }
    
    private func hasValidScoreData() -> Bool {
        // Show the chart if there is at least one team entry in any match,
        // even if the scores are currently zero (so you can see 0-valued points).
        return matchData.contains { !$0.scores.isEmpty }
    }
    
    private func resetAllData() {
        UserDefaults.standard.removeObject(forKey: "matchScoutingSetup")
        UserDefaults.standard.removeObject(forKey: "matchScoutingData")
        UserDefaults.standard.removeObject(forKey: "matchScoutingFinalized")
        
        isSetupComplete = false
        isScheduleFinalized = false
        matchSetup = MatchSetup(totalMatches: 0, ourTeam: "", matches: [])
        matchData = []
        setupForm = SetupForm(totalMatches: "", ourTeam: "")
        selectedMainTab = 0
    }
    
    // MARK: - Chart Data Generation (breakdown + summary only)
    private func generateBreakdownData() -> [BreakdownDataPoint]? {
        guard !matchData.isEmpty else { return nil }
        
        var breakdownData: [BreakdownDataPoint] = []
        
        // Calculate average scores per team across all matches
        let allTeams = Set(matchData.flatMap { match in
            match.scores.keys.filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
        })
        
        for team in allTeams.prefix(8) { // Limit to 8 teams for readability
            var autoTotal = 0.0
            var teleopTotal = 0.0
            var endgameTotal = 0.0
            var matchCount = 0
            
            for match in matchData {
                if let teamScores = match.scores[team] {
                    autoTotal += Double(teamScores.auto)
                    teleopTotal += Double(teamScores.teleop)
                    endgameTotal += Double(teamScores.endgame)
                    matchCount += 1
                }
            }
            
            if matchCount > 0 {
                let autoAvg = autoTotal / Double(matchCount)
                let teleopAvg = teleopTotal / Double(matchCount)
                let endgameAvg = endgameTotal / Double(matchCount)
                
                breakdownData.append(BreakdownDataPoint(teamNumber: team, category: "Auto", score: autoAvg))
                breakdownData.append(BreakdownDataPoint(teamNumber: team, category: "TeleOp", score: teleopAvg))
                breakdownData.append(BreakdownDataPoint(teamNumber: team, category: "Endgame", score: endgameAvg))
            }
        }
        
        return breakdownData.isEmpty ? nil : breakdownData
    }
    
    private func generateSummaryStats() -> SummaryStats? {
        guard !matchData.isEmpty else { return nil }
        
        let allTeams = Set(matchData.flatMap { match in
            match.scores.keys.filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
        })
        
        let matchesWithData = matchData.filter { match in
            !match.scores.isEmpty
        }.count
        
        var totalScores = 0.0
        var scoreCount = 0
        
        for match in matchData {
            for (_, scores) in match.scores {
                totalScores += scores.matchAverage
                scoreCount += 1
            }
        }
        
        let overallAverage = scoreCount > 0 ? totalScores / Double(scoreCount) : 0.0
        
        return SummaryStats(
            teamsCount: allTeams.count,
            matchesWithData: matchesWithData,
            overallAverage: overallAverage
        )
    }
}

// MARK: - Match Schedule Row Component
struct MatchScheduleRow: View {
    @Binding var match: MatchSetupData
    let onUpdate: (String, String) -> Void
    
    var body: some View {
        HStack {
            Text("Q\(match.matchNumber)")
                .fontWeight(.medium)
                .frame(maxWidth: .infinity)
            
            TextField("Team #", text: $match.redTeam1)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(maxWidth: .infinity)
                .onChange(of: match.redTeam1) { onUpdate("redTeam1", match.redTeam1) }
                .keyboardType(.numberPad)
            
            TextField("Team #", text: $match.redTeam2)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(maxWidth: .infinity)
                .onChange(of: match.redTeam2) { onUpdate("redTeam2", match.redTeam2) }
                .keyboardType(.numberPad)
            
            TextField("Team #", text: $match.blueTeam1)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(maxWidth: .infinity)
                .onChange(of: match.blueTeam1) { onUpdate("blueTeam1", match.blueTeam1) }
                .keyboardType(.numberPad)
            
            TextField("Team #", text: $match.blueTeam2)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(maxWidth: .infinity)
                .onChange(of: match.blueTeam2) { onUpdate("blueTeam2", match.blueTeam2) }
                .keyboardType(.numberPad)
        }
        .padding()
    }
}

// MARK: - Match Data Entry Card
struct MatchDataEntryCard: View {
    @Binding var matchData: MatchData
    let matchIndex: Int
    let onScoreUpdate: (String, String, Int) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Match \(matchData.matchNumber)")
                .font(.title3)
                .fontWeight(.semibold)
            
            // Red Alliance
            VStack(alignment: .leading, spacing: 12) {
                Text("Red Alliance")
                    .font(.headline)
                    .foregroundColor(.red)
                
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        Text("Team").frame(maxWidth: .infinity, alignment: .leading)
                        Text("Auto (0-5)").frame(maxWidth: .infinity)
                        Text("Tele-op (0-5)").frame(maxWidth: .infinity)
                        Text("Endgame (0-5)").frame(maxWidth: .infinity)
                        Text("Match Avg").frame(maxWidth: .infinity)
                        Text("Total Avg").frame(maxWidth: .infinity)
                    }
                    .font(.caption)
                    .fontWeight(.medium)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color.red.opacity(0.1))
                    
                    ScoreEntryRow(
                        teamNumber: matchData.redTeam1,
                        label: "Red Team 1",
                        scores: matchData.scores[matchData.redTeam1],
                        onUpdate: { field, value in onScoreUpdate(matchData.redTeam1, field, value) }
                    )
                    
                    Divider()
                    
                    ScoreEntryRow(
                        teamNumber: matchData.redTeam2,
                        label: "Red Team 2",
                        scores: matchData.scores[matchData.redTeam2],
                        onUpdate: { field, value in onScoreUpdate(matchData.redTeam2, field, value) }
                    )
                }
                .background(Color.red.opacity(0.05))
                .cornerRadius(8)
            }
            
            // Blue Alliance
            VStack(alignment: .leading, spacing: 12) {
                Text("Blue Alliance")
                    .font(.headline)
                    .foregroundColor(.blue)
                
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        Text("Team").frame(maxWidth: .infinity, alignment: .leading)
                        Text("Auto (0-5)").frame(maxWidth: .infinity)
                        Text("Tele-op (0-5)").frame(maxWidth: .infinity)
                        Text("Endgame (0-5)").frame(maxWidth: .infinity)
                        Text("Match Avg").frame(maxWidth: .infinity)
                        Text("Total Avg").frame(maxWidth: .infinity)
                    }
                    .font(.caption)
                    .fontWeight(.medium)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color.blue.opacity(0.1))
                    
                    ScoreEntryRow(
                        teamNumber: matchData.blueTeam1,
                        label: "Blue Team 1",
                        scores: matchData.scores[matchData.blueTeam1],
                        onUpdate: { field, value in onScoreUpdate(matchData.blueTeam1, field, value) }
                    )
                    
                    Divider()
                    
                    ScoreEntryRow(
                        teamNumber: matchData.blueTeam2,
                        label: "Blue Team 2",
                        scores: matchData.scores[matchData.blueTeam2],
                        onUpdate: { field, value in onScoreUpdate(matchData.blueTeam2, field, value) }
                    )
                }
                .background(Color.blue.opacity(0.05))
                .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.systemBackground)
        .cornerRadius(12)
    }
}

// MARK: - Score Entry Row
struct ScoreEntryRow: View {
    let teamNumber: String
    let label: String
    let scores: TeamScores?
    let onUpdate: (String, Int) -> Void
    
    private func calculateTotalAverage() -> Double {
        // This would calculate the average across all matches for this team
        // For now, return the match average
        return scores?.matchAverage ?? 0
    }
    
    var body: some View {
        HStack {
            Text(teamNumber.isEmpty ? "\(label) (Empty)" : teamNumber)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("0", value: Binding(
                get: { scores?.auto ?? 0 },
                set: { newValue in 
                    let clampedValue = max(0, min(5, newValue))
                    onUpdate("auto", clampedValue) 
                }
            ), format: .number)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(maxWidth: .infinity)
            .disabled(teamNumber.isEmpty)
            .keyboardType(.numberPad)
            
            TextField("0", value: Binding(
                get: { scores?.teleop ?? 0 },
                set: { newValue in 
                    let clampedValue = max(0, min(5, newValue))
                    onUpdate("teleop", clampedValue) 
                }
            ), format: .number)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(maxWidth: .infinity)
            .disabled(teamNumber.isEmpty)
            .keyboardType(.numberPad)
            
            TextField("0", value: Binding(
                get: { scores?.endgame ?? 0 },
                set: { newValue in 
                    let clampedValue = max(0, min(5, newValue))
                    onUpdate("endgame", clampedValue) 
                }
            ), format: .number)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(maxWidth: .infinity)
            .disabled(teamNumber.isEmpty)
            .keyboardType(.numberPad)
            
            Text(String(format: "%.1f", scores?.matchAverage ?? 0))
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(4)
                .frame(maxWidth: .infinity)
            
            Text(String(format: "%.1f", calculateTotalAverage()))
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.blue.opacity(0.2))
                .cornerRadius(4)
                .frame(maxWidth: .infinity)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

// MARK: - Match Scouting Data Models
struct MatchSetup: Codable {
    var totalMatches: Int
    var ourTeam: String
    var matches: [MatchSetupData]
}

struct MatchSetupData: Codable, Hashable {
    var matchNumber: Int
    var redTeam1: String
    var redTeam2: String
    var blueTeam1: String
    var blueTeam2: String
}

struct MatchData: Codable {
    var matchNumber: Int
    var redTeam1: String
    var redTeam2: String
    var blueTeam1: String
    var blueTeam2: String
    var scores: [String: TeamScores]
}

struct TeamScores: Codable {
    var auto: Int
    var teleop: Int
    var endgame: Int
    var matchAverage: Double
}

struct SetupForm {
    var totalMatches: String
    var ourTeam: String
}

// MARK: - Chart Data Models
struct ChartDataPoint: Identifiable {
    let id = UUID()
    let teamNumber: String
    let match: Int
    let score: Double
    let teamIndex: Int // Add team index to help with offsetting
}

struct BreakdownDataPoint: Identifiable {
    let id = UUID()
    let teamNumber: String
    let category: String
    let score: Double
}

struct SummaryStats {
    let teamsCount: Int
    let matchesWithData: Int
    let overallAverage: Double
}

// MARK: - Stat Card Component
struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.system(size: 24))
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(12)
    }
}

// MARK: - Archive Models + Views
struct ArchivedCompetition: Codable, Identifiable {
    let id: UUID
    let name: String
    let date: Date
    // Snapshot of relevant keys -> raw Data blobs
    let payload: [String: Data]
}

struct ArchivedCompetitionsView: View {
    @State private var archives: [ArchivedCompetition] = []
    
    var body: some View {
        VStack {
            List {
                ForEach(archives.sorted(by: { $0.date > $1.date })) { archive in
                    NavigationLink(destination: ArchivedCompetitionDetailView(archive: archive)) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(archive.name)
                                .font(.headline)
                            Text(Self.dateFormatter.string(from: archive.date))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: delete)
            }
            .listStyle(.insetGrouped)
        }
        .navigationTitle("Archives")
        .onAppear(perform: load)
        .toolbar {
            EditButton()
        }
    }
    
    private func load() {
        if let data = UserDefaults.standard.data(forKey: "archivedCompetitions"),
           let decoded = try? JSONDecoder().decode([ArchivedCompetition].self, from: data) {
            archives = decoded.sorted(by: { $0.date > $1.date })
        }
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(archives) {
            UserDefaults.standard.set(encoded, forKey: "archivedCompetitions")
        }
    }
    
    private func delete(at offsets: IndexSet) {
        archives.remove(atOffsets: offsets)
        save()
    }
    
    private static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .none
        return df
    }()
}

struct ArchivedCompetitionDetailView: View {
    let archive: ArchivedCompetition
    
    // Decoded snapshots
    private var teams: [Team] {
        if let data = archive.payload["eventTeams"],
           let decoded = try? JSONDecoder().decode([Team].self, from: data) {
            // Drop blank rows in archived data as well
            return decoded.filter { team in
                let num = team.teamNumber.trimmingCharacters(in: .whitespacesAndNewlines)
                let name = team.teamName.trimmingCharacters(in: .whitespacesAndNewlines)
                return !(num.isEmpty && name.isEmpty)
            }
        }
        return []
    }
    
    private var matchSetup: MatchSetup? {
        if let data = archive.payload["matchScoutingSetup"],
           let decoded = try? JSONDecoder().decode(MatchSetup.self, from: data) {
            return decoded
        }
        return nil
    }
    
    private var matchData: [MatchData] {
        if let data = archive.payload["matchScoutingData"],
           let decoded = try? JSONDecoder().decode([MatchData].self, from: data) {
            return decoded
        }
        return []
    }
    
    private var pitScores: [String: TeamScore] {
        if let data = archive.payload["pitScoutingScores"],
           let decoded = try? JSONDecoder().decode([String: TeamScore].self, from: data) {
            return decoded
        }
        return [:]
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header
                VStack(alignment: .leading, spacing: 4) {
                    Text(archive.name)
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(Self.dateFormatter.string(from: archive.date))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                
                // Summary
                GroupBox {
                    HStack {
                        summaryItem(title: "Teams", value: "\(teams.count)", icon: "person.3.fill", color: .blue)
                        Spacer()
                        summaryItem(title: "Matches", value: "\(matchSetup?.totalMatches ?? 0)", icon: "trophy.fill", color: .orange)
                        Spacer()
                        summaryItem(title: "Pit Scores", value: "\(pitScores.count)", icon: "note.text", color: .green)
                    }
                    .padding(.vertical, 4)
                    .padding(.horizontal)
                }
                .padding(.horizontal)
                
                // Teams list
                GroupBox {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Teams")
                            .font(.headline)
                        if teams.isEmpty {
                            Text("No teams stored in this archive.")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        } else {
                            ForEach(teams) { team in
                                HStack {
                                    Text(team.teamNumber.isEmpty ? "-" : team.teamNumber)
                                        .fontWeight(.semibold)
                                    Text(team.teamName)
                                        .foregroundColor(.secondary)
                                    Spacer()
                                }
                                if team.id != teams.last?.id {
                                    Divider()
                                }
                            }
                        }
                    }
                    .padding()
                }
                .padding(.horizontal)
                
                // Match Summary - Chart from Match Scouting
                GroupBox {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Match Summary")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        if let breakdownData = generateArchivedBreakdownData() {
                            // Compute a dynamic width so bars don't overlap and allow horizontal scrolling
                            let teamOrder = Array(Set(breakdownData.map { $0.teamNumber })).sorted()
                            let teamCount = max(1, teamOrder.count)
                            let widthPerTeam: CGFloat = 90
                            let minChartWidth: CGFloat = 500
                            let totalWidth = max(minChartWidth, CGFloat(teamCount) * widthPerTeam)
                            
                            ScrollView(.horizontal) {
                                Chart(breakdownData) { dataPoint in
                                    BarMark(
                                        x: .value("Team", dataPoint.teamNumber),
                                        y: .value("Score", dataPoint.score),
                                        width: .ratio(0.7)
                                    )
                                    .foregroundStyle(by: .value("Category", dataPoint.category))
                                    .position(by: .value("Category", dataPoint.category))
                                }
                                .chartXScale(domain: teamOrder)
                                .chartXAxis {
                                    AxisMarks(values: teamOrder) { value in
                                        AxisGridLine()
                                        AxisTick()
                                        AxisValueLabel {
                                            if let teamNumber = value.as(String.self) {
                                                Text("Team \(teamNumber)")
                                                    .font(.caption)
                                                    .fixedSize()
                                            }
                                        }
                                    }
                                }
                                .frame(width: totalWidth, height: 200)
                                .padding(.horizontal)
                                .chartYScale(domain: 0...5)
                                .chartLegend(position: .bottom, alignment: .center)
                                .chartYAxis {
                                    AxisMarks(position: .leading) { value in
                                        AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5))
                                            .foregroundStyle(.gray.opacity(0.3))
                                        AxisTick()
                                        AxisValueLabel {
                                            if let intValue = value.as(Double.self) {
                                                Text("\(Int(intValue))")
                                                    .font(.caption)
                                            }
                                        }
                                    }
                                }
                            }
                        } else {
                            Text("No match data available in this archive.")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.vertical, 12)
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationTitle("Archive Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func summaryItem(title: String, value: String, icon: String, color: Color) -> some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .foregroundColor(color)
            VStack(alignment: .leading, spacing: 2) {
                Text(value)
                    .font(.headline)
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    // Generate the same breakdown chart data used in Match Scouting, but from archived matchData
    private func generateArchivedBreakdownData() -> [BreakdownDataPoint]? {
        let archivedMatches = matchData
        guard !archivedMatches.isEmpty else { return nil }
        
        var breakdownData: [BreakdownDataPoint] = []
        
        let allTeams = Set(archivedMatches.flatMap { match in
            match.scores.keys.filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
        })
        
        for team in allTeams.prefix(8) {
            var autoTotal = 0.0
            var teleopTotal = 0.0
            var endgameTotal = 0.0
            var matchCount = 0
            
            for match in archivedMatches {
                if let teamScores = match.scores[team] {
                    autoTotal += Double(teamScores.auto)
                    teleopTotal += Double(teamScores.teleop)
                    endgameTotal += Double(teamScores.endgame)
                    matchCount += 1
                }
            }
            
            if matchCount > 0 {
                let autoAvg = autoTotal / Double(matchCount)
                let teleopAvg = teleopTotal / Double(matchCount)
                let endgameAvg = endgameTotal / Double(matchCount)
                
                breakdownData.append(BreakdownDataPoint(teamNumber: team, category: "Auto", score: autoAvg))
                breakdownData.append(BreakdownDataPoint(teamNumber: team, category: "TeleOp", score: teleopAvg))
                breakdownData.append(BreakdownDataPoint(teamNumber: team, category: "Endgame", score: endgameAvg))
            }
        }
        
        return breakdownData.isEmpty ? nil : breakdownData
    }
    
    private static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .none
        return df
    }()
}

