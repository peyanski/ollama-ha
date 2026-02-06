# Home Assistant Ollama App

Run [Ollama](https://ollama.com/) locally on your Home Assistant instance.



## Installation Instructions

> [!TIP]
> For detailed installation instructions of the App and examples, download my PDF: [https://automatelike.pro/ollama-ha](https://automatelike.pro/ollama-ha)

> [!WARNING]
> **Large Download Warning**: The app image is over **3.7GB**.
> Installation can take **25-30 minutes** or more on a Raspberry Pi 5, depending on your internet speed and SD card performance. Please be patient and ensure you have sufficient disk space.

1.  **Add Repository**:
    - Go to **Settings** > **Apps** > **App Store**.
    - Click the three dots in the top right > **Repositories**.
    - Add the URL of this repository: `https://github.com/peyanski/ollama-ha`.
2.  **Install App**:
    - Scroll down or search for "Ollama".
    - Click **Install**. *(This is the long step!)*
3.  **Start App**:
    - Once installed, toggle "Start on boot" and click **Start**.
    - Check the "Log" tab to ensure the server starts listening on port `11434`.

## Configuration

### GPU Support

By default, GPU support is **disabled** to ensure compatibility. If you have a supported GPU passed through to Home Assistant:

1.  Go to the **Configuration** tab.
2.  Toggle **gpu** to `true`.
3.  Restart the app.

## Manage Models (List & Delete)

To free up disk space or check what is installed, use the command line.

### Prerequisites

1.  Install the **[Advanced SSH & Web Terminal](https://github.com/hassio-addons/addon-ssh)** app.
2.  Start it and open the terminal.

### Accessing the Ollama Terminal

1.  **Find Container Name**:
    ```bash
    docker ps | grep ollama-ha
    ```
    *(Look for a name like `addon_ad7c61ed_ollama-ha`)*.

2.  **Enter Container**:
    ```bash
    docker exec -it addon_ad7c61ed_ollama-ha bash
    ```
    *(Replace `addon_ad7c61ed_ollama-ha` with your actual container name)*.

### List & Delete

Once inside the container:

*   **List Installed Models**:
    Check which models are using space.
    ```bash
    ollama list
    ```

*   **Delete a Model**:
    Remove a model by name.
    ```bash
    ollama rm llama3.2
    ```
