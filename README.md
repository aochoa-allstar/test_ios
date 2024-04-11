# Onax App

## Folder Structure
```yaml
- /assets
  - /locales
    - en_US.json
    - es_MX.json
- /lib
  - /app
    - /data
      - /enums
      - /models
      - /providers
      # Here, we must store our asynchronous data request, http or local database functions.
        - /local
          - example_module_local_provider.dart
        - /server
          - example_module_server_provider.dart
          - base_server_provider.dart
          # This file serves as an extendable class for the server providers to implement headers, decode API responses, and notifying the user after receiving the response.
      - /repositories
        - example_module_repository.dart
    - /modules
      - /example_module
        - /bindings
        # Here we append processeses to be used on our controllers
        - /controllers
        - /views
        # 
        - widgets (optional)
        # The elements that'll be used multiple times or bits of code that become
        # too big that clutter the will live here
    - /routes
  - /core
    - /middlewares
    # Folder containing GetMiddleware classes wich will redirect the user 
    # according to the middleware's purpose.
    - /services
    # Core processes such as network manager, sqlite and preferences are initialized and developed here.
  - /generated
    - locales.g.dart
    # This is the 'compiled' version of the json files located inside the assets folder.
    # To regenerate run `get generate locales assets/locales`
  - main.dart  
```