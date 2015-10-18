# Foliage Engine

## Introduction

## Grobplanung

\begin{figure}[!htb]
\begin{center}

\begin{ganttchart}[
    y unit title=0.5cm,
    y unit chart=0.6cm,
    time slot format=isodate-yearmonth,
    compress calendar,
    title/.append style={shape=rectangle, fill=black!10},
    title height=1,
    bar/.append style={fill=green!90},
    bar height=.6,
    bar label font=\normalsize\color{black!50},
    group top shift=.6,
    group height=.3,
    group peaks height=.2,
    bar incomplete/.append style={fill=green!40}
  ]{2015-05}{2017-06}
  \gantttitlecalendar{year} \\
  \gantttitlecalendar{month} \\
  \ganttset{progress label text={},
       bar incomplete/.append style={fill=green!40},
       group/.append style={draw=black, fill=green},} % this suppresses percentage done labels
  \ganttgroup{Aim 1: Phenotypes}{2015-06}{2015-12} \\
    \ganttbar[progress=00, name=rclone]{R cloning}{2015-06}{2015-07} \\
    \ganttlinkedbar[progress=00, name=rflr]{R fluorescence}{2015-07}{2015-09} \\
    \ganttlinkedbar[progress=00, name=rqpcr]{R RT-qPCR}{2015-10}{2015-11} \\
    \ganttbar[progress=00, name=kover]{KO verification}{2015-06}{2015-07} \\
    \ganttlinkedbar[progress=00, name=kogro]{KO growth}{2015-08}{2015-09} \\
    \ganttbar[progress=00, name=koflr]{KO fluorescence}{2015-08}{2015-09} \\
    \ganttlinkedbar[progress=00, name=koo2]{KO O2 evolution}{2015-10}{2015-11} \\
  \ganttset{bar incomplete/.append style={fill=red!40},
    group/.append style={draw=black, fill=red},}
  \ganttgroup{Aim 2: Expression}{2015-06}{2017-02} \\
    \ganttbar[progress=00, name=oeclone]{Clone OEs}{2016-01}{2016-03} \\
    \ganttbar[progress=00, name=rnagrow]{Grow KOs + OEs}{2016-04}{2016-06} \\
    \ganttlinkedbar[progress=00, name=rnaprep]{RNA library prep}{2016-07}{2016-09} \\
    \ganttbar[progress=00, name=rnadev]{Develop analysis}{2015-06}{2015-07} \\
    \ganttbar[progress=00, name=rnaanal]{Analyze reads}{2016-12}{2017-02} \\
  \ganttset{bar incomplete/.append style={fill=blue!40},
  group/.append style={draw=black, fill=blue},}
  \ganttgroup{Aim 3: Binding sites}{2016-01}{2017-05} \\
    \ganttbar[progress=00, name=chipgrow]{Grow KOs + OEs}{2016-04}{2016-06} \\
    \ganttlinkedbar[progress=00, name=chipprep]{ChIP library prep}{2016-08}{2016-12} \\
    \ganttbar[progress=00, name=chipdev]{Develop analysis}{2016-01}{2016-02} \\
    \ganttbar[progress=00, name=chipanal]{Analyze reads}{2017-03}{2017-05}
  % misc links
  \ganttset{progress label text={}}
  \ganttlink[]{oeclone}{rnagrow}
  \ganttlink[link mid=0.082]{oeclone}{chipgrow}
  \ganttlink[]{rnaprep}{rnaanal}
  \ganttlink[link mid=0.25]{kover}{koflr}
  \ganttlink[link mid=0.75]{kogro}{koo2}
  \ganttlink[link mid=0.55]{koo2}{oeclone}
  \ganttlink[link mid=0.55]{rqpcr}{oeclone}
  \ganttlink[]{chipprep}{chipanal}
  \ganttlink[link mid=0.938]{rnadev}{rnaanal}
  \ganttlink[link mid=0.915]{chipdev}{chipanal}
\end{ganttchart}

\end{center}
\end{figure}


### Milestones

- **Milestone - 1:** Es existiert eine erste Version der Billboard Implementation in der Foliage Engine. Die Implementation ist unter Umständen noch nicht ganz fertig, jedoch mehrheitlich. Nachbesserungen (der Billboard Implementation) sowie eine Analyse der Octtree Implementation sollen bis zur Projektwoche vorgenommen werden.

- **Milstone - 2:** Es existiert eine verbesserte Version der Billboard Implementation, des weitern wurde die Octtree Implementation analysiert. Sofern die Resultate befriedigend sind, kann mit der Analyse der Dynamic Scene Graph Implementation in der Projektwoche gestartet werden.

- **Milestone - 3:** Es existiert eine einfache Implementation eines Dynamic Scene Graph (anhängig vom Projektfortschritt).

- **Final Presentation:** Finale Abgabe / Präsentation.

## Grobplanung
balalalal [@Cousteau1963].
## Appendix


### Meeting: 29. September 2015

**Datum:** Dienstag 29. September 2015  
**Zeit:** 11:00 - 11:15  
**Teilnehmende:** Livio Bieri, Raphael Brunner, Stefan Arizona, Roman Bolzern

#### Protokollpunkte / Themen
- Besprechung der erledigten Arbeiten seit letzten Meeting.

- Erläuterungen der drei Teilaspekte des Projekts durch Auftraggeber *(Billboard Implementation, Optimierung mittels Octree Implementation, Dynamic Scene Graph Implementation durch Auftraggeber).*

#### Pendenzenliste / Beschlüsse
*Bis zum nächsten Meeting am 7. Oktober sind die folgenden Pendenzen zu erledigen:*

  1. Ausarbeiten einer kurzen Beschreibung der drei möglichen Teilaufgaben des Projekts.
  
  2. Ausarbeiten einer kurzen Planung der wichtigsten Milestones (*TDB* vor dem 7. Oktober, via Mail).

#### Sonstiges
- *None*


