# BASIC_PATH

## DESCRIPTION
### English
BASIC_PATH is a node navigation system using a LERP function to navigate between them, nodes are at set points along a path and the "navigable" class will update its position along the path, each frame (or at a set update rate) moving at a constant speed in pixel(or whatever coordinate system being used) per second.

### French
BASIC_PATH est un outil de navigation par noeud utilisant une fonction LERP pour se deplacer entre eux-memes, les noeuds étant placés à des points fixes le long d'un chemin (NAV_PATH) et la classe "navigable" met à jour sa position le long du chemin à chaque rafraîchissement de l'écran (ou à une vitesse de mise à jour donné), se déplaçant à une vitesse constante en pixels (ou dans le système de coordonnées utilisé) par seconde.

## USAGE
### English
To use the BASIC_PATH code snippet, you can simply adapt it as you wish for your project simply renaming, expanding or use as-is the provided classes within the cluster, it is also very good to pair BASIC_PATH with the VECTOR_MATH cluster's code such as using VEC2 for the node system allowing vector math operation on the coordinates, i have no idea what you could do with such power but it is available. it is also worth noting that you may want to change the navigable class to a deferred type so that you can have full control from the derived classes

Step by step:
1. Create a path by adding/appending a set of nodes
2. Create a navigable object
3. Update said Navigable object by using any update(Timestamp) function that is updated at your desired rate
4. Draw the navigable object using any method of your choice

### French
Pour utiliser le code snippet BASIC_PATH, vous pouvez simplement l'adapter selon vos besoins pour votre projet en renommant, en développant ou en utilisant tel quel les classes fournies dans le cluster. Il est également très utile de combiner BASIC_PATH avec le code du cluster VECTOR_MATH, comme en utilisant VEC2 pour le système des nœuds, ce qui permet d'exécuter des opérations mathématiques vectorielles sur les coordonnées. Il est également à noter que vous devriez peut-être changer la classe navigable en type différé afin d'avoir un contrôle total depuis les classes dérivées.

Étapes par étapes :
1. Créez un chemin en ajoutant ou en appendant un ensemble de noeuds
2. Créez un objet navigable
3. Mettez à jour l'objet Navigable en utilisant toute fonction update(Timestamp) qui est mise à jour à votre taux souhaité
4. Afficher l'objet navigable en utilisant toute méthode de votre choix