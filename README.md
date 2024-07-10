# VR Schweißtrainer  
## Einführung
Dieses Projekt entstand im Rahmen des Moduls **Augmented and Virtual Reality - Principles and Practice** an der Hochschule Anhalt.
![Logo der HSA](https://github.com/KwentiN-ui/Schweisstrainer_GodotProject/blob/main/Bilder/fuer_README/HSA_Logo_Text.png)

Autoren:
- Nadine Schulz
- Quentin Huss

Das Projekt ist unter der MIT-Lizenz für jeden zur freien Verwendung verfügbar.

## Projekt einrichten
1. Repository klonen oder herunterladen
2. [Godot 4.2](https://godotengine.org/) herunterladen
3. [Blender](https://www.blender.org/) installieren
4. Godot starten und beliebiges Projekt öffnen
5. In den Editoreinstellungen $\to$ Dateisystem $\to$ Importieren $\to$ Blender3-Pfad festlegen (Ordner zum Blender Ordner, nicht zur .exe)
6. Projekt neu öffnen
7. Das Programm kann mit dem Pfeilsymbol oben rechts oder F5 gestartet werden

>Blender wird headless ausgeführt, um die .blend Dateien in Meshes als solche zu importieren und ist somit zwingend erforderlich!

Das Projekt wurde mit SteamVR als OpenXR Runtime getestet.


## Tutorial  

### Tastenbelegung  

| Aktion | Taste | Controller | Funktion im Spiel | Bild | 
| --------- | ------- | ------------- | ------------------------ | ---- |  
| Teleportieren | A | rechts | Teleportieren | ![A Knopf](https://github.com/KwentiN-ui/Schweisstrainer_GodotProject/blob/main/Bilder/fuer_Text/A_Knopf.png) |  
| Drehen | Thumbstick | rechts | Drehen | ![Joystick](https://github.com/KwentiN-ui/Schweisstrainer_GodotProject/blob/main/Bilder/fuer_Text/Joystick.png) |  
| Grip | Grip-Button | rechts u. links | Greifen von Gegenständen | ![Grip-Button](https://github.com/KwentiN-ui/Schweisstrainer_GodotProject/blob/main/Bilder/fuer_Text/Grip.png) |  
| Trigger | Trigger-Button | rechts u. links | Drücken von Knöpfen, Slider, Auffüllen der Elektrode... | ![Trigger-Button](https://github.com/KwentiN-ui/Schweisstrainer_GodotProject/blob/main/Bilder/fuer_Text/Trigger.png) |  

### Ablauf  
#### Helm  
![Helm](https://github.com/KwentiN-ui/Schweisstrainer_GodotProject/blob/main/Bilder/fuer_README/Helm_auf_Tisch.png)  
1. Helm greifen:  
   Den Helm vom Tisch mit der Hand greifen und diese, mit dem Helm an den Kopf führen um ihn aufzusetzen.  
2. Helm benutzen:  
   Um den Helm Herunterzuklappen mit dem Kopf nicken oder eine Hand nah an den Kopf halten und Trigger drücken.  
   Zum Hochklappen ebenfalls eine Hand nah an den Kopf halten und Trigger drücken.  
#### Schweißmaschine  
![Schweißmaschine](https://github.com/KwentiN-ui/Schweisstrainer_GodotProject/blob/main/Bilder/fuer_README/Schweissmaschine.png)  
1. Schweißmaschine einschalten:   
   Zum Einschalten mit einer Hand auf den Einschaltknopf zeigen. Sobald ein roter Laser erscheint, kann die Schweißmaschine durch drücken von Trigger eingeschaltet werden.  
     ![Schweißmaschine](https://github.com/KwentiN-ui/Schweisstrainer_GodotProject/blob/main/Bilder/fuer_README/Schweissmaschine_einschalten.png)  
2. Schweißstrom ändern:  
   Zum Ändern des Schweißstrom auf den Slider rechts neben der Stromanzeige zeigen. Sobald ein roter Laser erscheint, kann der Schweißstrom durch bewegen der Hand geändert werden.  
   ![Schweißmaschine](https://github.com/KwentiN-ui/Schweisstrainer_GodotProject/blob/main/Bilder/fuer_README/Schweissmaschine_Strom_aendern.png)  
#### Elektrodenhalter  
![Elektrodenhalter](https://github.com/KwentiN-ui/Schweisstrainer_GodotProject/blob/main/Bilder/fuer_README/Elektrodenhalter.png)  
1. Elektrodenhalter greifen  
2. neue Elektrode einspannen:  
   Zum Einspannen einer neuen Elektrode mit einer Hand auf eine Packung mit Stabelektroden halten. Sobald ein roter Laser erscheint, kann durch drücken von Trigger eine neue Elektrode eingespannt werden.   
   ![Schweißmaschine](https://github.com/KwentiN-ui/Schweisstrainer_GodotProject/blob/main/Bilder/fuer_README/Nachfuellelektroden.png)  
#### Schweißen   
Zum Schweißen die Elektrode nah an das zu Schweißende Blech führen und Zünden.  
Sobald die Elektrode gezündet ist, darf der Abstand zum Blech nicht größer als $2\cdot Elektrodendurchmesser$ werden, sonst erlischt der Lichtbogen und es muss neu gezündet werden.  
