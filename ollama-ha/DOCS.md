# Home Assistant Ollama-HA App

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

### Models

Add models to the `models` list in the configuration if you wish to track them (note: auto-download is not strictly enforced yet, please pull manually for control).

## Using with Home Assistant

To integrate Ollama with Home Assistant (e.g., for Conversation Agents & AI Tasks):

1.  Go to **Settings** > **Devices & Services**.
2.  Click **Add Integration**.
3.  Search for **Ollama**.
4.  **URL**: Enter `http://127.0.0.1:11434` (or your HA IP address).
5.  **Model**: Select the name of a model you want to use (e.g., `llama3.2`, `gpt-oss:120b-cloud`, etc.).

For more info on using the integration and downloading models, see the [Home Assistant Ollama Docs](https://www.home-assistant.io/integrations/ollama/).

## Authentication (Cloud Models)

To use Ollama's cloud models (e.g., `gpt-oss:120b-cloud`), you need to authenticate your instance.

**Method 1: Add Key Manually (Recommended)**
1.  Start the app and wait for it to initialize.
2.  Check the **Log** tab. You will see a block starting with `🔑 OLLAMA PUBLIC KEY`.
3.  Copy the key (starts with `ssh-ed25519...`).
4.  Go to [https://ollama.com/settings/keys](https://ollama.com/settings/keys) and add the key.
5.  Restart the app. You can now pull cloud models!

**Method 2: Interactive Sign-in**
1.  Go to the **Configuration** tab.
2.  Toggle `start_auth` to `true` and restart the app.
3.  Check the **Log** tab effectively immediately.
4.  You will see `🔐 OLLAMA SIGNIN CODE` and a link/code. Follow the instructions.
5.  After authenticating, disable `start_auth` and restart the app.

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
