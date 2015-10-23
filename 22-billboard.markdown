
# Billboard

## Schritt 1) VertexShaderMaterial

In einem ersten Schritt haben wir aufbauend auf bestehendem Code, den wir von Roman Bolzern erhielten, ein eigendes ShaderMaterial programmiert.  
  
ShaderMaterial von Roman Bolzern:

	// Register new loaded LOD Level
    var mesh;
    if(level == 1){
      mesh = new THREE.Mesh(
      new THREE.BufferGeometry().fromGeometry(geometry),
      //new THREE.MeshFaceMaterial(material));
      new THREE.MeshBasicMaterial({color : 0xff0000}));
    } else if(level == 2){
      mesh = new THREE.Mesh(
      new THREE.BufferGeometry().fromGeometry(geometry),
      new THREE.MeshBasicMaterial({color : 0x0000ff}));
    } else if(level == 3){
      mesh = new THREE.Mesh(
      new THREE.BufferGeometry().fromGeometry(geometry),
      new THREE.MeshBasicMaterial({color : 0x00ff00}));
    } else {
      mesh = new THREE.Mesh(
      new THREE.BufferGeometry().fromGeometry(geometry),
      new THREE.MeshBasicMaterial({color : 0x000000}));
    }
Eigenes ShaderMaterial:

    var vertexShader = [
      "varying vec2 vUv;",
      "void main() {",
      "vUv = uv;",
      "gl_Position = projectionMatrix * (modelViewMatrix * vec4(0.0, 0.0, 0.0, 1.0)",
      "+ vec4(position.x, position.y, 0.0, 0.0));",
      "}"
      ].join("\n");
    var fragmentShader = [
      "uniform sampler2D texture;",
      "varying vec2 vUv;",
      "void main() {",
      "vec4 tex = texture2D ( texture, vUv);",
      "gl_FragColor = vec4(tex.r, tex.g, tex.b, tex.a);",
      "}"
      ].join("\n");

Für einen ersten Test verwendeten wir dabei das Beispielprogramm von threejs.org welches normalerweise einen Würfel rotieren lässt. Nun ersetzten wir das Material des Würfels durch unser eigenes ShaderMaterial. Dabei soll, wenn alles klappt, uns unsere Textur die ganze Zeit anschauen, obwohl sich das Objekt eigentlich dreht.  
Als sich das Ergebnis als erfolgreich heraus stellte, haben wir einen Test innerhalb der Foliage-Engine gewagt. Der einfachheit halber haben wir unser Experiment im letzten LOD-Level versucht, da es sich auch um eine Textur handelt und dieser einfacher zu verändern ist.  
Billboard-Simulation mit PlaneBufferGeometry:
![Resultat mit ShaderMaterial](assets/images/fancyColorBillboard.png)
Beim präsentieren von diesem Ergebnis wurden wir darauf Aufmerksam gemacht, dass das kein Partikelshader ist, sondern mehr ein Workaround der das verhalten von einem Partikelshader imitiert. In unserer Lösung hat jedes Objekt immernoch 4 Vertices um es darzustellen. Beim eigentlichen Partikelshader ist für eine Darstellung nur ein Vertix notwendig, nähmlich das für die Position des Objekts.  
Wir wurden darauf hingewiesen, dass wir es mit dem Partikelsystem realisieren können.

## Schritt 2) Partikelsystem
Nun machten wir das gleiche Experiment nochmal, diesmal jedoch mit dem Partikelsystem. Dabei versuchten wir statt `THREE.Mesh(geometry, material)` die Funktion `THREE.PartikelSystem(geometry, material)` und verwendeten dabei wieder unser ShaderMaterial. Jedoch wurden wir dabei schnell von unserem Chrome-Browser beim testen darauf Aufmerksam gemacht, dass das PartikelSystem veraltet ist und wir Points verwenden sollen.

## Schritt 3) Points
Beim recherchieren für die Verwendung von Points stiessen wir darauf, dass für eine einfache Implementierung von einem Billboard kein eigener Shader notwendig ist. Es wird uns `THREE.PointsMaterial()` angeboten welcher den Shader komplett implementiert hat. Dort müssen wir lediglich noch ein paar Einstellungen betätigen.

    var material = new THREE.PointsMaterial();
    material.map = texture;
    material.size = 5.0;
    material.sizeAuttenuation = false;
    material.transparent = false;
Als Geometry wird hier nur noch ein Vertix benötigt.  
Auch hier haben wir zuerst ein Beispiel mit dem Beispielprogramm von threejs.org umgesetzt. Anschliessend haben wir wieder das letzte LOD mit unseren Points-Objekten ersetzt um es innerhalb von der Foliage-Engine zu testen. Für den Test Haben wir noch ein paar Objekte in die Luft gesetzt und die Transparenz deaktiviert, um zu sehen ob der Billboard-Effekt wirklich korrekt funktioniert.  
Ergebnis mit den Points-Objekten:
![Resultat mit ShaderMaterial](assets/images/billboardSample.png)

## Schritt 4) Billboard/Sprite-Kombination

## Schritt 5) Billboart Implementierung
