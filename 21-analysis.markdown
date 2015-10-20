
# Analyse

## Ist-Analyse 

###Ziel
Die Foliage-Engine soll die three.js Library mit einer Gras-Engine ergänzen. Ziel war es ein Example für threejs.org zu erstellen. Das Example besteht aus einer Fläche mit Gras in der man sich frei bewegen und so die Engine testen kann.

###Struktur Sourcecode
Übernommen haben wir die bestehende Foliage-Engine als komprimierter Ordner. Darin enthalten sind die JavaScript Librarys von three.js.
In einem separaten Ordner sind alle Modelle gespeichert je nach derem LOD-Level.  
Ebenfalls enthalten ist ein Readme mit einer Anleitung zum Erstellen von Foliage-Objekten und deren Anwendung enthalten.
Im Ordner "scenes" findet man dann verschiedene HTML-Files die als Muster dienen, in denen verschiedene Gras-Models und LOD-Levels für die Foliage-Engine verwendet werden.  
Im "textures" Ordner sind verschidene Texturen für Gras und Terrain vorhanden.  
Schliesslich haben wir auch noch das "index.html" und die "three.foliageengine.js" darin enthalten, die die finale Version repräsentiert.  
Will man nun die Engine testen muss man im Hauptordner einen Server starten und kann dann mittels Browser entwerder das "index.html" oder eines der anderen Beispiele in "scenes" aufrufen.

###Performance

###Findings