# Palworld Server

## Description du projet

Ce projet est une configuration Docker pour héberger un serveur dédié Palworld. Il utilise une image Debian 12, SteamCMD, et comprend des configurations personnalisées pour le serveur Palworld.

Le serveur est nommé "Oustopie" et est configuré avec divers paramètres personnalisés dans le fichier `PalWorldSettings.ini`.

## Prérequis

Pour déployer ce serveur Palworld, vous aurez besoin de:

- Docker et Docker Compose installés sur votre machine hôte
- Un accès réseau pour les ports 8211/udp (jeu) et 8212/tcp (API REST)
- Au moins 4 Go de RAM disponible pour le serveur
- Espace disque suffisant pour le jeu et les sauvegardes (minimum 10 Go recommandé)

## Méthode de déploiement

1. **Cloner le dépôt**

   ```bash
   git clone <url-du-depot>
   cd palworld-server
   ```

2. **Configuration (optionnel)**

   Vous pouvez modifier les paramètres du serveur en éditant le fichier `config/PalWorldSettings.ini` avant le déploiement.

   Pour personnaliser les mots de passe:
   - `ServerPassword`: Mot de passe pour se connecter au serveur (actuellement "123Oustopie!")
   - `AdminPassword`: Mot de passe administrateur (actuellement "123Admin!")

3. **Lancement du serveur**

   ```bash
   docker-compose up -d
   ```

   Le serveur sera accessible sur le port 8211/udp.

4. **Vérification de l'état du serveur**

   ```bash
   docker-compose ps
   ```

   Vous pouvez également vérifier les logs:

   ```bash
   docker-compose logs -f
   ```

5. **Arrêt du serveur**

   ```bash
   docker-compose down
   ```

## Sauvegarde des données

Les données de sauvegarde du jeu sont stockées dans le volume Docker `palworld_save` et sont également disponibles dans le répertoire `./palworld_save` sur la machine hôte.

## API REST

Une API REST est activée sur le port 8212. Vous pouvez accéder aux informations du serveur via:

```
http://<ip-du-serveur>:8212/v1/api/info
```

Authentification nécessaire avec les identifiants admin configurés.

## Notes supplémentaires

- Le serveur est configuré pour redémarrer automatiquement sauf en cas d'arrêt manuel.
- Les vérifications de santé sont configurées pour s'assurer que le serveur fonctionne correctement.
- Pour appliquer des modifications à la configuration, redémarrez le conteneur après avoir modifié les fichiers de configuration.
