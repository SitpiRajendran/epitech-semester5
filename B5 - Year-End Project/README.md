**Note : 22**
<br><br>
Administrative details (1 / 2) :<br>
Le docker ne build pas l'apk<br>
<br><br>
Documentation (2 / 2) :<br>
Documentation API OK<br>
Documentation utilisateur Web sans photo<br>
Doc utilisateur Mobile à l'air cool<br>
Documentation suivi des tests Ok, ça manque de couleur, il faut que ça soit beaucoup plus visuel pour qu'avec un coup d'oeil on voit très vite ce qui va et ne va pas.
doc gitflow ok, dommage que ça ne soit pas dans la doc technique<br>
<br>
<br>
Docker usage (2 / 4) :
- The services client_mobile and client_web share a common volume -> KO
- The client_mobile service edits the associated binary and put it on the common volume with the client_web -> KO
- The server service run by exposing the port 8080 and the client_web service run by exposing the port 8081 -> OK +1
- The client_web service respond to http://localhost:8081/client.apk by providing the Android version of mobile client -> OK +1
clients/server architectures (2 / 3) :
- The project contains, at least, 3 parts : the application server, the mobile client, the web client -> OK +1
- The mobile client redirects the requests to the application server and doesn't handle anything else (appart from authentication) -> OK +1
- The webclient redirects the requests to the application server and doesn't handle anything else (appart from authentication) -> OK +1 < C'est un .json pour avoir la liste des actions/réactions. Il aurait fallu que ça soit le back qui envoie ce json, ou autrement. -1
<br><br>
about.json (4 / 4) :<br>
- "host" is the ip of the client -> OK +1<br>
- Services list is present -> OK +1<br>
- Each service list its actions -> OK +1<br>
- Each widgets list its reactions -> OK +1<br>
<br><br>
Project features (4 / 4) :<br>
An user can register and connect to the application : OK +1<br>
An authenticated user can register to services (Intra, Yammer, OneDrive, Twitter, FaceBook, DropBox, etc..) : OK +1<br>
An authenticated user can create Action-REAction : OK +1<br>
The AREA works with triggers : OK +1<br>
<br><br>
Number of services (2 / 3) :<br>
Google, outlook, spotify, intra, meteo, bourse, timer<br>
7 services / 7 requis +2<br>
<br><br>
Number of Actions and REActions (2 / 3) :<br>
21 actions/reactions / 18 requis +2<br>
<br><br>
Triggers (3 / 4) :<br><br>
Triggers are triggered automatically at regular intervals and fixed : timer fix set à 4 minutes -> +3<br>
