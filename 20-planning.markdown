
# Grobplanung

\begin{figure}[!htb]
\begin{center}

\begin{ganttchart}[
y unit title=0.4cm,
y unit chart=0.5cm,
vgrid,hgrid,
title label anchor/.style={below=-1.6ex},
title left shift=.05, title right shift=-.05,
title height=1,
bar/.style={fill=gray!50},
incomplete/.style={fill=white},
progress label text={},
bar height=0.7,
group right shift=0,
group top shift=.6,
group height=.3
]{1}{20}

%labels
\gantttitle{IP5 - Foliage Engine}{20} \\
\gantttitle{September}{4}
\gantttitle{October}{4}
\gantttitle{November}{4}
\gantttitle{Dezember}{4}
\gantttitle{Januar}{4} \\

%tasks
\ganttgroup{Documentation}{3}{18}
\ganttnewline
\ganttgroup{Project Week}{12}{12}
\ganttnewline
\ganttgroup{Holiday}{16}{17}
\ganttnewline
\ganttnewline
\ganttbar[progress=100]{Initial Analysis}{3}{4} \\
\ganttnewline \ganttbar{Billboard - Initial}{5}{8} \\
\ganttmilestone{Milestone-1}{8}
\ganttnewline
\ganttnewline
\ganttbar{Billboard - Finalize}{9}{11} \\
\ganttbar{Octree Optimization}{9}{11} \\
\ganttnewline
\ganttmilestone{Milestone-2}{11}
\ganttnewline
\ganttbar{Dynamic Scene Graph}{12}{15} \\
\ganttmilestone{Milestone-3}{15}
\ganttnewline
\ganttnewline
\ganttbar{Buffer}{18}{18} \\
\ganttmilestone{Final Presentation}{18} \\

%relations \ganttlink{elem3}{elem4}
\ganttlink{elem4}{elem5}
\ganttlink{elem5}{elem6}
\ganttlink{elem5}{elem7}
\ganttlink{elem6}{elem8}
\ganttlink{elem7}{elem8}
\ganttlink{elem8}{elem9}
\ganttlink{elem9}{elem10}
\ganttlink{elem10}{elem11}
\ganttlink{elem11}{elem12}

\end{ganttchart}
\end{center}
\end{figure}

## Milestones

- **Milestone - 1:** Es existiert eine erste Version der Billboard Implementation in der Foliage Engine. Die Implementation ist unter Umständen noch nicht ganz fertig, jedoch mehrheitlich. Nachbesserungen (der Billboard Implementation) sowie eine Analyse der Octtree Implementation sollen bis zur Projektwoche vorgenommen werden.

- **Milstone - 2:** Es existiert eine verbesserte Version der Billboard Implementation. Des Weiteren wurde die Octtree Implementation analysiert. Sofern die Resultate befriedigend sind, kann mit der Analyse der Dynamic Scene Graph Implementation in der Projektwoche gestartet werden.

- **Milestone - 3:** Es existiert eine einfache Implementation eines Dynamic Scene Graph (abhängig vom Projektfortschritt).

- **Final Presentation:** Finale Abgabe / Präsentation.

\pagebreak

## Aktualisierte Grobplanung

Aufgrund von mehreren Faktoren musste die Grobplanung grundsätzlich angepasst werden. Der Hauptgrund war dabei die Feststellung, dass die bestehende Foliage Engine schlecht erweiterbar ist (undurchsichtige Abhängigkeiten, hohe Komplexität der Implementation, Codequalität nicht zufriedenstellend etc.). Aus diesem Grund wurde zwischen Milestone 1 und Milestone 2 entschieden, ein Example von Grund auf neu zu erstellen. Mit dieser Massnahme stellten wir sicher, dass wir die Octree Erweiterung vornehmen können. Es wurde vereinbart, dass wir bestehende sinnvolle Konzepte und Überlegungen der Foliage Engine übernehmen. Der Milestone 3 wurde dabei mehrheitlich entfernt. Ziel ist jedoch, in unserer Implementation diese Erweiterbarkeit zu beachten.

\begin{figure}[!htb]
\begin{center}

\begin{ganttchart}[
y unit title=0.4cm,
y unit chart=0.5cm,
vgrid,hgrid,
title label anchor/.style={below=-1.6ex},
title left shift=.05, title right shift=-.05,
title height=1,
bar/.style={fill=gray!50},
incomplete/.style={fill=white},
progress label text={},
bar height=0.7,
group right shift=0,
group top shift=.6,
group height=.3
]{1}{20}

%labels
\gantttitle{IP5 - Foliage Engine}{20} \\
\gantttitle{September}{4}
\gantttitle{October}{4}
\gantttitle{November}{4}
\gantttitle{Dezember}{4}
\gantttitle{Januar}{4} \\

%tasks
\ganttnewline
\ganttgroup{Documentation}{3}{18}
\ganttnewline
\ganttgroup{Project Week}{12}{12}
\ganttnewline
\ganttgroup{Holiday}{16}{17}
\ganttnewline
\ganttbar[progress=100]{Initial Analysis}{3}{4} \\
\ganttnewline
\ganttbar{Billboard - Initial}{5}{8} \\
\ganttnewline
\ganttmilestone{Milestone-1}{8}
\ganttnewline
\ganttbar{Billboard - Finalize}{9}{11} \\
\ganttnewline
\ganttbar{Octree Optimization}{12}{13} \\
\ganttnewline
\ganttbar{Create 'joint' example*}{14}{16} \\
\ganttnewline\ganttmilestone{Milestone-2}{16}
\ganttnewline
\ganttbar{Cleanup + Prepration}{17}{18} \\
\ganttnewline
\ganttmilestone{Final Presentation}{18} \\

%relations 
\ganttlink{elem3}{elem4}
\ganttlink{elem4}{elem5}
\ganttlink{elem5}{elem6}
\ganttlink{elem6}{elem7}
\ganttlink{elem7}{elem8}
\ganttlink{elem8}{elem9}
\ganttlink{elem9}{elem10}
\ganttlink{elem10}{elem11}

\end{ganttchart}
\end{center}
\end{figure}

### Aktualisierte Milestones

- **Milestone - 1:** Es existiert eine erste Version der Billboard Implementation in der Foliage Engine. Die Implementation ist unter Umständen noch nicht ganz fertig, jedoch mehrheitlich. Nachbesserungen (der Billboard Implementation) sowie eine Analyse der Octtree Implementation sollen bis zur Projektwoche vorgenommen werden.

- **Milstone - 2:** Das Ziel ist es, die beiden Teile (Billboard und Octree) in ein gemeinsames Beispiel zusammenzuführen.

- **Final Presentation:** Finale Abgabe / Präsentation.




