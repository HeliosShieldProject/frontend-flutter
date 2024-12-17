# Helios | VPN App

A Flutter application for secure VPN connections.

## Features

![image](./readme/render.png)

- Secure VPN connections using various protocols
- Country selection with real-time statistics
- Session history tracking and analytics
- Responsive UI with custom widgets

## Getting Started

Follow these instructions to get a copy of the project up and running on your local machine.

### Prerequisites

- Flutter SDK
- Dart SDK

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/yourusername/helios-vpn-app.git
   ```

2. **Navigate to the Proejct Directory**

    ```bash
    cd frontend-flutter
    ```

3. **Install dependencies**
    
    ```bash
    flutter pub get
    ```

    <details>
    <summary>See dependencies</summary>
        * jwt_decoder - used to decode JWT expiration date
        * flutter_svg - used to render .svg pictures
        * flutter_dotenv - used to access the evironment variables
        * dio - used to send requests to the backend
        * device_info_plus - used to determin device's model
        * country_flags - widgets with country flags
        * flutter_v2ray - custom flutter_v2ray fork to create vpn connections, available at: https://github.com/Asbecov/flutter_v2ray.git
        * hive, hive_flutter - used to persist data 
        * bloc, flutter_bloc, equatable - state management
        * email_validator, password_validator_package - regex pattern matching package for password and email validation
        * url_launcher - used to launch deeplinks
        * package_info_plus - used to know the exact app version to show it in the app itself 

        # dev_dependencies:
        * hive_generator: ^2.0.1
        * build_runner: ^2.4.11
        * flutter_lints: ^4.0.0
    </details>

4. **Set up environment variables**

    ```
    # backend API URL
    MASTER_BACKEND_URL=localhost

    # v2ray sharelinks for testing
    TEST_VLESS_URL="..."
    TEST_SS_URL="..."
    ```

6. **Run the Application**

    ```bash
    flutter run
    ```

### Contributing

**Contributions are welcome!** 
Please follow these steps:

1. **Fork the Repository**

2. **Create a Feature Branch**:

    ```bash
    git checkout -b feature/yourFeature
    ```

3. **Commit Your Changes**:

    ```bash
    git commit -a -m "feature: **what have you done**"
    ```

4. **Push to the Branch**:

    ```bash
    git push -u origin feature/yourFeature
    ```

5. **Open a Pull Request**