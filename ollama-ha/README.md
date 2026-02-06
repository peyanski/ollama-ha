# Home Assistant Ollama-HA App

Run [Ollama](https://ollama.com/) locally on your Home Assistant instance.

---

<p align="center">
  <a href="https://www.patreon.com/KPeyanski" target="_blank">
    <img src="https://c5.patreon.com/external/logo/become_a_patron_button.png" alt="Become a Patron" height="50">
  </a>
  &nbsp;&nbsp;&nbsp;
  <a href="https://buymeacoffee.com/peyanski" target="_blank">
    <img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" height="50">
  </a>
</p>

<p align="center">
  <strong>If you find this app useful, consider supporting my work! ☕</strong>
</p>

---

## About

This app allows you to run a full-featured **Ollama** server locally on your Home Assistant instance. It empowers your smart home with local AI capabilities, ensuring your data remains private and your automations run with low latency.

Designed for ease of use, this app integrates seamlessly with the official [Home Assistant Ollama integration](https://www.home-assistant.io/integrations/ollama/) and other AI-powered tools.

## Features

This app provides a robust local AI backend and includes:

- **Local Inference**: Run powerful LLMs (Large Language Models) like Llama 3.2, Qwen, and Phi entirely on your own device.

- **Easy Integration**: Acts as a drop-in backend for Home Assistant's local Assist pipelines and conversation agents.
- **Hardware Acceleration**:
  - Optional **GPU support** (configurable via toggle).
  - Optimized for Raspberry Pi 5 and other ARM64 devices.
- **Flexible Management**:
  - **Full CLI Access**: Use Docker/SSH to manually **list and delete** models (`ollama rm`) to manage disk space.
  - REST API exposed for custom integrations.
- **Persistent Storage**: Models are stored in `/data`, preserved across app restarts and updates.
- **Cloud Compatibility**: Optional authentication support solely for pulling private or licensed models from Ollama's library.
