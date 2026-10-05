
# Print Receipt

Saw this specific idea from [Enid](https://x.com/ios_dev_alb) on Twitter and decided to recreate it myself to learn more magic.

Just really cool

This was a combo of self-learning + watching YouTube tutorial from [Kavsoft](https://www.youtube.com/@Kavsoft) on how to work with dynamic islands.


## Installation

### 1. Download the project

Clone the repository using Git:

```bash
git clone https://github.com/dyokox/One_Strikes_Projects.git
```

Alternatively, download the repository as a ZIP file from GitHub and extract it.

### 2. Open the project in Xcode

Navigate to the project directory and open:

```
PrintTicket.xcodeproj
```

If the project uses an Xcode workspace, open:

```
PrintTicket.xcworkspace
```

> **Note:** Open the project/workspace rather than individual `.swift` files.

### 3. Configure signing

Once the project has opened in Xcode:

1. Select **PrintTicket** from the Project Navigator.
2. Select the **PrintTicket** target.
3. Open **Signing & Capabilities**.
4. Select your **Apple Developer Team**.
5. If required, change the **Bundle Identifier** to a unique identifier, for example:

   ```
   com.yourname.PrintTicket
   ```

Xcode should automatically create the required signing configuration for development.

---

## Running the App

### Using the iOS Simulator

1. Select an iPhone simulator from the device selector at the top of Xcode, for example:

   ```
   iPhone 16 Pro
   ```

2. Press **Run** (`⌘R`).

Xcode will build and launch the application in the selected simulator.

### Using a Physical iPhone

To run Tarot-Journal on a physical device:

1. Connect your iPhone to your Mac using USB-C.
2. Unlock your iPhone.
3. Select your iPhone from Xcode's device selector.
4. Make sure **Developer Mode** is enabled on the iPhone.
5. Select the **Calma** target.
6. Under **Signing & Capabilities**, select your Apple Developer Team.
7. Press **Run** (`⌘R`).

If prompted on the iPhone, trust the connected computer and follow the on-screen instructions.


## Tech Stack

- SwiftUI
- SwiftData
- Foundation
- MVVM
## Troubleshooting
### Xcode cannot build the project

#### Try:
- Make sure you are using a supported version of Xcode.
- Select Product → Clean Build Folder.
- Build the project again using ⌘B.
- Make sure the correct development team is selected under Signing & Capabilities.
- The app does not appear on my iPhone

#### Check that:
- Your iPhone is connected and unlocked.
- Developer Mode is enabled.
- The iPhone is selected as the run destination.
- Your Apple Developer Team is selected.
- The device trusts your Mac.
## Authors

- [@dyokox](https://www.github.com/dyokox)


## License

[MIT](https://choosealicense.com/licenses/mit/)


