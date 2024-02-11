# Techoney - Solution de Traçabilité pour la Chaîne d'Approvisionnement du Miel
<br>
** Partie 2 : smart contract et blockchain **

Bienvenue dans le référentiel (repo) de Techoney, un projet dédié à la création d'une solution décentralisée pour garantir la traçabilité dans la courte chaîne d'approvisionnement du miel.

## Objectif du Projet

L'objectif principal de Techoney est de renforcer la transparence et la sécurité au sein de l'industrie apicole en utilisant des technologies telles que la blockchain et l'Internet des Objets (IoT). 
Nous nous concentrons sur la traçabilité, de la ruche au consommateur, pour assurer l'authenticité et la qualité du miel.

## Composants Principaux

- **Broker (HiveMQ):** Point de départ pour la collecte des données de température.
- **Gateway (Script Python):** Centralise la collecte et la transmission des données d'un reseau a un autre.
- **IPFS (Infura):** Stockage décentralisé des données avec génération de hash pour l'immuabilité.
- **Blockchain (Ganache):** Utilisation de la blockchain pour garantir la traçabilité.
- **Smart Contract (avec le framework Truffle):** Gère l'interaction avec la blockchain et le stockage des hash.

## Guide d'Installation et d'Utilisation

1. Installer **GANACHE** blockchain :
   -Tout d'abord, installez Ganache. Pour ce faire, suivez les étapes suivantes :
      - **Téléchargez blockchain ethereum depuis le site officiel de ganache :** https://trufflesuite.com/ganache/
      - **Ouvrez l'interface de ganache pour qu'il puisse s'executer**

2. **Executer le projet honey-blockchain :**
      - On utilise Truffle framework dans ce projet , vous devez l'installer avec : **npm install -g truffle@5.0.2**
      - Initialier Truffle avec : **truffle init**
      - Installez les dependences du projet avec : **npm install** pour cela vous devez avoir nodeJS deja installerdans votre machine
      - Compilez le projet avec : **truffle compile**
      - Deployez le projet avec : **truffle migrate**
