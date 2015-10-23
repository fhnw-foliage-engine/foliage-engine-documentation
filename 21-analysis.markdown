
# Analyse

## Ist-Analyse 

###Ziel
Die Foliage-Engine soll die three.js Library mit einer Gras-Engine ergänzen. Ziel war es ein Example für threejs.org zu erstellen. Das Example besteht aus einer Fläche mit Gras in der man sich frei bewegen und so die Engine testen kann.

###Struktur Sourcecode
Übernommen haben wir die bestehende Foliage-Engine als komprimierter Ordner.  
Darin enthalten ist ein Readme mit einer Anleitung zum Erstellen von Foliage-Objekten und deren konfiguration enthalten.  
  
**Foliage-Engine**  
Das "index.html" zusammen mit "three.foliageengine.js" ist die finale Demo bzw. die finale Implementatin von der Foliage-Engine die wir erhalten haben.
  
**Librarys**  
In einem Ordner "js" sind alle verwendeten Librarys gespeichert die für das Ausführen von Three.js und den Anzeigen von Debuggmöglichkeiten notwendig sind.  
  
**Models**  
Die Models der verschiedenen LOD-Levels sind im "model" Ordner untergebracht und nach LOD-Level sortiert.  

**Scenes**
Im Ordner "scenes" findet man dann verschiedene HTML-Files die als Muster dienen, in denen verschiedene Gras-Models und LOD-Levels für die Foliage-Engine verwendet werden.  
  
**Texturen**  
Im "textures" Ordner sind verschidene Texturen für Gras und Terrain vorhanden.  
  
Will man nun die Engine testen muss man im Hauptordner einen Server starten und kann dann mittels Browser entwerder das "index.html" oder eines der anderen Beispiele aus "scenes" aufrufen.

	foliageengine/
		index.html
		js/
			PointerLockControls.js
			three.js
			three.min.js
			threex.renderstats.js
		models/
			grass/
				2.5D/
					models
					bilder
				lod0/
					models
					bilder
				lod1/
					models
					bilder
				lod2/
					models
					bilder
				lod3/
					models
					bilder
				lod4/
					models
					bilder
				lod5/
					models
					bilder
		readme.txt
		scenes/
			2.5d.html
			32.52d.html
			50fps.html
			demo.html
			phd.html
			unity.html
		textures/
			grass_normal.png
			grass.png
			lod2d_normal.png
			lod2d.png
			sand_clean_bumpy_01_b_normal.png
			sand_clean_bumpy_01_b.png
			skybox/
		three.foliageengine.js

###Performance

###Findings
Bei der Codeanalyse um uns in das Thema einzuarbeiten haben wir auch ein paar Fehler entdeckt. Die wier selbstverständlich auch dokumentieren möchten.
  
**Texturen**  
Als wir uns entschieden die Foliage-Engine so zu manipulieren, damit wir leicht die verschiedenen LOD erkennen können, viel uns auf dass die Texturen für das letzte LOD garnie geladen wurden. Bei unserer Suche nach dem fehler mit der Hilfe von Debugging-Tools vom Chrome-Browser fanden wir heraus, dass die Funktion `THREE.Foliage.prototype.handle2DLevel` gar nie aufgerufen wird.  
Bei weiterem suchen stiessen wir dann schliesslich auf folgenden Codeabschnitt:

	if (textures) {
      var modelTextur = textures();
      //var modelTextur = textures();
      for (var x = 0; x < modelTextur.length; x++) {
        this.totalModels++;
        this.handle2DLevel(modelTextur[x], x, level);
      }
    }

Dabei entdeckten wir, dass in die variable `modelTextur` eine Funktion statt einem Array geladen wird. Leider warf der Browser bei der Verwendung einer Funktion in der For-Schlaufe keinen Fehler. Den konnten wir leicht beheben in dem wir `textures()` mit `(textures())()` ersetzten. Nun wird auch das Array in die Variable übergeben. Jetzt sehen wir auch die Textur für das letzte LOD und entdeckten gleich den nächsten Fehler.  
  
Für die Textur erstellte sie ein flaches Objekt das auf dem Boden Liegt. Darüber legten sie ihre Textur. Was sich im ersten Augenblick noch gut anhört, sieht dann im Endergebnis so aus:
![Textur Foto](assets/images/wrongtexture.png)
Bei einem Terrain das keine gerade Fläche ist, verschwinden die Graden Flächen in den Hügeln und hinterlassen so entweder Löcher in der Grassimulation oder es fliegen Quadratische Grastexturen irgendwo in der Luft herum.  
Dieser Fehler wurde nicht behoben und besteht immer noch.