# InSync

**From meeting discussions to actionable tasks.**

InSync is a cross-platform mobile application designed to help teams turn meeting minutes into actionable tasks, assign responsibilities, track deadlines, and follow progress until completion.

By leveraging generative AI, InSync aims to reduce the manual effort involved in meeting follow-ups and help teams turn decisions into measurable outcomes.

## The Problem

Meeting discussions often result in important decisions, action items, and deadlines. However, these details can get lost in lengthy minutes, unclear responsibilities, and inconsistent follow-ups.

Teams may struggle to determine who is responsible for each action, when it is due, and whether it has been completed.

## The Solution

InSync connects meeting documentation with task management in one workflow. It analyzes meeting content, suggests structured tasks, and allows authorized users to review and confirm them before assigning responsibilities.

The application helps teams maintain visibility into outstanding work, approaching deadlines, and decisions that require follow-up.

## Features

- **AI-Powered Meeting Analysis** — Extract action items, decisions, assignees, departments, deadlines, and priorities from meeting minutes.
- **Meeting Management** — Create meetings and enter or upload meeting minutes and transcripts.
- **Smart Task Generation** — Convert extracted action items into structured task suggestions for review and approval.
- **Task Assignment** — Assign responsibilities and communicate expectations to team members.
- **Progress Tracking** — Monitor task statuses from pending to completion.
- **Notifications and Reminders** — Keep team members informed about assignments, approaching deadlines, and overdue tasks.
- **Organization Management** — Support organizational workspaces, team collaboration, and role-based permissions.
- **Meeting History** — Keep track of previous decisions and identify unfinished tasks that need attention.

## How It Works

1. **Submit meeting content:** Enter or upload meeting transcript.
2. **Analyze the discussion:** AI identifies decisions, action items, potential assignees, deadlines, and priorities.
3. **Review suggested tasks:** An authorized organizer reviews and edits the extracted information.
4. **Assign responsibilities:** Confirmed tasks are assigned to the appropriate team members.
5. **Track progress:** Employees update task statuses while managers monitor progress.
6. **Follow up:** Notifications and deadline reminders help teams stay on track.

## Task Lifecycle

`Pending` → `In Progress` → `Completed`

InSync also aims to support deadline-extension requests and overdue-task monitoring.

## Technology Stack

| Technology | Purpose |
|---|---|
| Flutter | Cross-platform mobile application |
| Dart | Application development |
| Firebase | Backend and cloud services |
| Generative AI | Meeting analysis and task extraction |


## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Dart SDK](https://dart.dev/get-dart) (included with Flutter)
- [Git](https://git-scm.com/)
- [VS Code](https://code.visualstudio.com/) with the Flutter extension, or another supported Flutter IDE

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/shimaakamalm2-cmd/InSync.git
   ```

2. Navigate to the project directory:

   ```bash
   cd InSync
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run the application on an available emulator or connected device:

   ```bash
   flutter run
   ```

## Project Structure

```text
InSync/
├── android/       # Android platform files
├── ios/           # iOS platform files
├── lib/           # Main Dart application code
├── test/          # Automated tests
├── web/           # Web platform files
├── linux/         # Linux platform files
├── macos/         # macOS platform files
├── windows/       # Windows platform files
├── pubspec.yaml   # Dependencies and project configuration
└── README.md      # Project documentation
```

## Project Status

InSync is currently under development. Features, integrations, and architecture may change as implementation progresses.


---

**InSync — Make every meeting count.**