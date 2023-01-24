# Piped-Frontend

The following changes from the [upstream docker image](https://github.com/TeamPiped/Piped)  have been implemented:

* Updated entrypoint script to override the API endpoint properly on startup (The image is not built on the destination system)

## Configuration

To set the API endpoint use environment variable ``` API_ENDPOINT ```.
