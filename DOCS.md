# Home Assistant Ollama Add-on

Run [Ollama](https://ollama.com/) locally on your Home Assistant instance.

## Installation Instructions

> [!WARNING]
> **Large Download Warning**: The add-on image is over **3.7GB**.
> Installation can take **25-30 minutes** or more on a Raspberry Pi 5, depending on your internet speed and SD card performance. Please be patient and ensure you have sufficient disk space.

1.  **Add Repository**:
    - Go to **Settings** > **Add-ons** > **Add-on Store**.
    - Click the three dots in the top right > **Repositories**.
    - Add the URL of this repository: `https://github.com/peyanski/ollama-ha`.
2.  **Install Add-on**:
    - Scroll down or search for "Ollama".
    - Click **Install**. *(This is the long step!)*
3.  **Start Add-on**:
    - Once installed, toggle "Start on boot" and click **Start**.
    - Check the "Log" tab to ensure the server starts listening on port `11434`.

## Configuration

> [!TIP]
> For detailed installation instructions of the Add-on and examples, download my PDF: [https://automatelike.pro/ollama-ha](https://automatelike.pro/ollama-ha)

### GPU Support

By default, GPU support is **disabled** to ensure compatibility. If you have a supported GPU passed through to Home Assistant:

1.  Go to the **Configuration** tab.
2.  Toggle **gpu** to `true`.
3.  Restart the add-on.

### Models

Add models to the `models` list in the configuration if you wish to track them (note: auto-download is not strictly enforced yet, please pull manually for control).

## Using with Home Assistant

To integrate Ollama with Home Assistant (e.g., for Conversation Agents & AI Tasks):

1.  Go to **Settings** > **Devices & Services**.
2.  Click **Add Integration**.
3.  Search for **Ollama**.
4.  **URL**: Enter `http://localhost:11434` (or your HA IP address).
5.  **Model**: Select the name of a model you want to use (e.g., `llama3.2`, `gpt-oss:120b-cloud`, etc.).

For more info on using the integration and downloading models, see the [Home Assistant Ollama Docs](https://www.home-assistant.io/integrations/ollama/).

## Manual Model Download

To download a model (e.g., `llama3`):

1.  Install [Advanced SSH & Web Terminal Add-on](https://my.home-assistant.io/redirect/supervisor_addon/?addon=a0d7b954_ssh) and run it
2.  Run: `docker ps` to find the exact name of the Ollama container 
3.  Run: `docker exec -it addon_ad7c61ed_ollama-ha bash` to access the container terminal and replace `addon_ad7c61ed_ollama-ha` with your container name.
4.  Inside container pull the AI model of your choice, for example: `ollama pull qwen2.5:0.5b` or cloud model like `ollama pull gpt-oss:120b-cloud` (but you need to have free account on Ollama to use cloud models and to signin with `ollama signin`)
