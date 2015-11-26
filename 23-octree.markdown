
# Octree

###Ausgangslage
Wir wollen einen Octree verwenden um damit effizient die Distanz von der Kamera zu einem Gras-Objekt zu berechnen. Die Elemente, die sich in einem Octree befinden, werden dynamisch in Nodes aufgeteilt, die nie mehr als 8 Kinder haben können.  
So ensteht ein Baum mit maximal 8 Kindern pro Node. Diese Nodes haben dann immer einen Raum den sie Belegen. Um jetzt effizient berechnen zu können, in welchem LOD so ein Node liegt, kann man jeweils die äusseren Punkte überprüfen. Liegt so ein Node-Raum in mehreren LOD so muss weiter bei dessen Kinder gesucht werden.  
Als Ausgangslage verwendeten wir den Octree von [collinhover](https://github.com/collinhover/threeoctree "Octree on Github") das die ganzen Eigenschaften von einem Octree mit bringt. Was nicht vorhanden ist, sind Funktionen mit denen man den LOD der Nodes überprüfen kann und diese dann auch ein entsprechendes Event auf die betroffenen Objekte auslöst.
![Octree example](assets/images/octreeExample.png)
*Octree example*

###Update des LOD
OctreeNodes sind die Objekte welche alle notwendigen Informationen und die Kinder enthalten. Mit ihnen wird der eigentliche Octree aufgebaut.  
Um nun unsere LOD-Überprüfungen auf dem OctreeNode machen zu können, müssen wir ihn um ein paar Informationen ergänzen.

```javascript
// level of detail

this.utilLevelOfDetail = {
   // LOD of this node
   // if not undefined
   nodeLevelOfDetail: undefined
};
```
Die Informationen über den besetzten Raum von jedem Node können wir mit folgenden Attributen enrhalten:

```javascript
this.left;
this.right;
this.front;
this.back;
this.top;
this.bottom;
```
Mit diesen Argumenten lassen sich nun die Eckkoordinaten der Nodes ermitteln.  
Will man nun die Objekte erhalten die in einem Node verpackt sind, macht man dies mit `this.objects[index].object` . In den Objekten sind jetzt die Daten enthalten die wir dem Octree übergeben haben. Dort müssen wir auch die Position des Objektes extrahieren um damit die Distanz zur Kameraposition zu berechnen.
Damit wissen wir schon alles das wir für die Berechnung der entsprechenden LOD wissen müssen.

####Update LOD auf Octree
Die Berechnung des LOD wird mit der Funktion `updateLevelOfDetail( fromPosition )` ausgelöst.  Initial wird diese von aussen auf den Octree aufgerufen, und übergibt dabei den aktuellen Standort der Kamera. Diese Funktion ruft wiederum die Funktion auf dem root auf, welcher ein OctreeNode ist.

```javascript
// fromPosition: is usually the camera position
updateLevelOfDetail: function ( fromPosition ) {

	this.root.updateLevelOfDetail( fromPosition );

}
```
Bevor wir jedoch die Implementation davon auf dem OctreeNode anschauen, müssen wir einige andere notwendigen Funktionen zeigen.

####Distanz Berechnung
Zur berechnung der Distanz verwenden wir den euklidischen Abstand.

```javascript
calculateDistance: function ( x1, y1, x2, y2) {
	var a = x1 - x2;
	var b = y1 - y2;
	return a * a + b * b;
}
```
Die ersten beiden Parameter repräsentieren die Kameraposition und die letzten zwei die Position des Objekts. Diese Distanz kann nun verwendet werden um das entsprechende LOD zu ermitteln.  
Um das korrekte LOD berechnen zu können brauchen wir noch den Range der entsprechenden LOD's. Dafür haben wir dem Octree einen weiteren Parameter hinzugefügt `this.levelOfDetailRange;`, der bei der Instanzierung als Parameter mitgegeben wird. Damit wir aber diese Ranges nun mit den berechneten Distanzen verwenden können, müssen wir sie noch quadrieren.

```javascript
function prepareMarshall( array ){
	var newArray = [];
	for(var i = 0; i < array.length; i++){
		newArray.push(array[i] * array[i]);
	}
	return newArray;
}
```
Dies wird einmalig bei der Instanzierung erledigt und dann so im Octree gespeichert. Dabei kann man auch Defaultwerte beim Octree angeben falls keine Ranges bei der Instanzierung mitgegeben werden.

```javascript
this.levelOfDetailRange = 
	prepareMarshall( parameters.levelOfDetailRange ) 
		|| [1 ,25, 64, 2500]
```

Das entsprechende LOD kann mit diesen Informationen ermittelt werden. Dafür iterieren wir über unser Range-Array und suchen solange bis wir einen Wert finden der grösser als unsere Distanz ist. Das LOD geben wir dann in Form eines Integers zurück.

```javascript
calculateLevelOfDetailFromDistance: function ( distance ) {
	var i, l;
	l = this.tree.levelOfDetailRange;
	for(i = 0; i < l.length; i++){
		if(distance <=  l[i]) return i;
	}
	return i;
}
```
Damit können wir nun alle LOD der entsprechenden Ecken von einem OctreeNode berechnen. Nun brauchen wir eine Funktion die berechnet welches LOD der ganze OctreeNode hat. Dafür müssen wir für die berechnete Distanz der Ecken das LOD ermitteln und vergleichen ob alle das selbe haben, falls ja, hat der ganze OctreeNode das entsprechende LOD, falls nein, ist sein LOD undefined und sie müssen weiter unten in der Hierarchie definiert werden.

```javascript
calculateLevelOfDetail: function ( fromPosition ) {
	var distanceFrontLeftEdge =
		this.calculateDistance(fromPosition.x, fromPosition.z, this.left, this.front);

	var distanceFrontRightEdge =
		this.calculateDistance(fromPosition.x, fromPosition.z, this.right, this.front);

	var distanceBackLeftEdge =
		this.calculateDistance(fromPosition.x, fromPosition.z, this.left, this.back);

	var distanceBackRightEdge =
		this.calculateDistance(fromPosition.x, fromPosition.z, this.right, this.back);
		
		
	var levelFrontLeftEdge =
		this.calculateLevelOfDetailFromDistance(distanceFrontLeftEdge);
	var levelFrontRightEdge =
		this.calculateLevelOfDetailFromDistance(distanceFrontRightEdge);
	var levelBackLeftEdge =
		this.calculateLevelOfDetailFromDistance(distanceBackLeftEdge);
	var levelBackRightEdge =
		this.calculateLevelOfDetailFromDistance(distanceBackRightEdge);

	var hasAllEdgesSameLevelOfDetail = levelFrontLeftEdge ===
		levelFrontRightEdge && levelFrontRightEdge === 
			levelBackLeftEdge && levelBackLeftEdge ===
				levelBackRightEdge;

	if(hasAllEdgesSameLevelOfDetail) {
       return levelFrontLeftEdge;
   } else {
       return undefined;
   }
}
```
Die folgende Funktion wandelt die Information nun in einen boolean um, den wir später für die Funktion auf den OctreeNode verwenden werden.

```javascript
hasAllEdgesWithinSameLevelOfDetail: function ( fromPosition ) {

	var levelOfDetail = this.calculateLevelOfDetail(fromPosition);

	var hasAllEdgesSameLevelOfDetail = levelOfDetail === undefined ? false : true;
	
	return hasAllEdgesSameLevelOfDetail;

}
```
Weiter brauchen wir noch einen Funktion der Prüft, ob das berechnete LOD verglichen mit dem vorgängigen LOD gewechselt hat oder nicht.

```javascript
willLevelOfDetailChange: function ( from, to ) {
	return from !== to || to !== undefined;
}
```
Damit haben wir alle Funktionen die wir brauchen um eine `updateLevelOfDetail( fromDistance )` Funktion auf dem OctreeNode zu definieren.

####Update LOD auf OctreeNode
Um zu prüfen ob ein OctreeNode ein Update braucht, speichern wir das alte und neue LOD, falls der Node nicht undefined ist. Danach prüfen wir ob sich das LOD verändert hat; falls ja lösen wir einen Event aus, falls nein machen wir nichts.
Falls der OctreeNode undefined ist, rufen wir `updateLevelOfDetail( fromDistance )` auf dessen Kinder auf.

```javascript
updateLevelOfDetail: function ( fromPosition ) {

	if ( this.hasAllEdgesWithinSameLevelOfDetail ( fromPosition ) ) {
		var oldLevelOfDetail = this.utilLevelOfDetail.nodeLevelOfDetail;
		var newLevelOfDetail = this.calculateLevelOfDetail ( fromPosition );
		var didLevelOfDetailChange = this.willLevelOfDetailChange( oldLevelOfDetail, newLevelOfDetail );

		// we do not need to go any deeper -> all children will be in this LOD
		this.utilLevelOfDetail.nodeLevelOfDetail = newLevelOfDetail;

		if (didLevelOfDetailChange) {
			this.dispatchEvent();
		}

	} else {

		// we need to go deeper
		var i, l;
		for ( i = 0, l = this.nodesIndices.length; i < l; i ++ ) {
			this.nodesByIndex[ this.nodesIndices[ i ] ].updateLevelOfDetail( fromPosition );
		}

	}

}
```
####Event
Für das Event, dass ausgelöst wird, verwenden wir den von Threejs angebotenen `EventDispatcher`. Damit können wir ein Event direkt auf dem Objekt selbst auslösen. Um nun mit dem Ausgelösten Event etwas Sinnvolles anstellen zu können, brauchen wir eine Callback-Funktion die dem Octree bei der Instanzierung übergeben werden muss. Wird kein Callback übergeben, so wird diese durch eine leere Funktion ersetzt.

```javascript
this.levelOfDetailChangedCallback = parameters.levelOfDetailChangedCallback || function ( Event ) {};
```
Dieser Callback wird direkt auf den Objekten im Octree ausgelöst und haben mit `this`direkt Zugriff auf dessen Attributen. So lassen sich die nötigen Schritte in der Function definieren die bei einem Event erledigt werden sollen.  
Das `dispatchEvent`, dass im `updateLevelOfDetail( fromPosition )` auf einem OctreeNode aufgerufen wird, iteriert über alle Objekte im OctreeNode und löst auf ihnen das Callback aus. Danach wird es rekursiv nach Unten weiter afgerufen.
Beim `dispatcheEvent` wird noch ein Event-Objekt mitgegeben, dass das Level des Objektes enthaltet.

```javascript
dispatchEvent: function (){
	var i, l;

	for(i = 0, l = this.objects.length; i < l; i++){

		this.objects[i].object.dispatchEvent( {
			type: 'changed',
			level: this.utilLevelOfDetail.nodeLevelOfDetail
		});

	}

	for ( i = 0, l = this.nodesIndices.length; i < l; i ++ ) {

		this.nodesByIndex[ this.nodesIndices[ i ] ].dispatchEvent();

	}

}
```
###Ergebnis
####Test
Um zu sehen ob sich unser Octree so verhaltet wie erwartet, haben wir eine das Example welches schon in der **Ausgangslage** gezeigt wurde, an unsere Situation angepasst. Wir lassen alle Punkte nur noch auf einer Ebene generieren und definierten eine Callback-Funktion die beim Auslösen des Events die Farbe der Objekte anhand des entsprechenden Levels ändert.

```javascript
levelOfDetailChangedCallback: function ( event ) {
	if(event.level >= 4){
		this.material.color.setRGB( 0, 0, 255 ); // Blau
		console.log("updated LOD 4");
	} else {
		this.material.color.setRGB( 255, 0, 0 ); // Rot
		console.log("updated LOD 0 - 3");
	}
}
```

Ausgehend von der weissen Linie, die unsere Cameraposition imitiert, erwarten wir einen Viertelkreis in Rot und der Rest sollte Blau sein. Diesen Erfolg hatten wir leider nicht. Wie man auf dem Bild erkennen kann, sieht man Zwar die Kreisform, die wir von unserem Octree erwarten, es hat jedoch noch grüne Bereiche, die nie ein Update erhalten und dann einen grossen roten Bereich, der eigentlich Blau sein sollte.
![Erstes Octree Resultat](assets/images/OctreeResult1.png)
