<h1>Documentation Technique de Dashboard:</h1>

<!-- Ajouter un system de connection au dashboard -->
***
<h2>Ajouter une connexion :</h2>
<br>
<table><thead><tr><th>Fichiers à modifier</th></tr></thead></table>

    -> config/passeport.js
    -> routes/index.js

    -> views/welcome.ejs
    -> views/login.ejs

<br>
<h4>Introduction</h4>
<p>
    Le dashboard accepte déjà les connexion et enregistrement avec Google, Github et Twitter. Il est aussi possible de créer un compte directement sur la plateforme.
</p>
<h4>Application</h4>
<p>
    Pour rajouter un systeme de connexion au dashboard, il vous faudra vraisemblablement commencer par créer une application sur la plateforme souhaité.
</p>
<h4>Passport</h4>
<p>
    Ceci étant fait, il vous faudra rajouter installer le passeport souhaité via
</p>

> npm install PASSPORT --save
<p>
    Une fois le passport installé, il vous faudra ajouter et modifier ce morceau de code au fichier "passport.js" dans le dossier config.
</p>
<img src="./resources/Connexion/Passport.png"/>
<br>
<p>
    Il vous faudra faudra principalement modifier la stratégie (ici "new GithubStrategy") par le keyword correspondant dans le node module téléchargé précedemment. Il vous faudra ensuite vous munirs de vos keys, ici GITHUB_CLIENT_ID et GITHUB_CLIENT_SECRET, et fournir l'url de redirection.
</p>
<br>
<p>
    La connection au compte se fait en fonction de l'email. dans la fonction "findOne" ci-dessus, il vous faudra donc récupérer l'email dans le json récupéré par a requète. Il vous faudra par la suite remplir le user nouvelement créer avec le plus d'informations possible.
</p>
<br>
<h4>index</h4>
<p>
    Une fois le passport fait, il faudra ajouter les routes pour accéder à ce system de connexion. Faites comme ci dessous en adaptant au system de connexion que vous souhaité ajouter.
</p>
<img src="./resources/Connexion/redirect_url.png"/>
<p>
    Ici, il faudra notamment remplacer "google" par le nom de votre réseau, service, ou entreprise.
</p>

> ATTENTION: Il faut laisser le successRedirect et le failureRedirect comme montrer ci-dessus.

<p>
    Le scope quant à lui variera rarement mais dépendra cela dit de votre system.
</p>
<br>
<h4>HTML Image et boutons</h4>
<p>
    Une fois tout ceci fait, veillez à ajouter une image ou un bouton pour pouvoir acceder à ce nouveau system de connexion. Pour ceci il vous faudra ajouter une balise href dans le fichier login.ejs.
</p>
<img src="./resources/Connexion/connexion_buttons.png"/>
<img src="./resources/Connexion/accueil.png"/>

<!-- Ajouter un widget au Dashboard -->
***
<h3>Ajouter un Widgets</h3>
<br>
<table><thead><tr><th>Fichiers à modifier</th></tr></thead></table>

    -> views/partials/widget-settings.ejs
    -> views/partials/widget-selection.ejs
    -> views/partials/widget-presentation.ejs

<br>
<table><thead><tr><th>Fichiers à créer</th></tr></thead></table>

    -> public/js/[WidgetName].js
    -> views/partials/Edit/edit-[WidgetName].ejs
    -> views/partials/Create/create-[WidgetName].ejs
<br>
<h4>Introduction</h4>
<p>
    Le fonctionnement basique du Dashboard repose sur la présence de widgets. Plus il y'en à mieux c'est !! Et vous pouvez nous y aider ! Pour commencer il vous faudra choisir un nom.
</p>

> ATTENTION: Le nom que vous choisirez sera EXTREMEMENT important. Pour la suite de l'ajout de widget remplacer scrupuleusement tout les "[WidgetName]" par le nom que vous aurez choisi.

<h4>Formulaire des paramètres</h4>
<p>
    Dans un premier temps, il vous faudra créer le form permettant de paramétrer votre widget. Pour cela il vous faudra créer le fichier "edit-[WidgetName].ejs" au path "views/partials/Edit/".
</p>
<p>
    Ajoutez y autant de champs que voulu, sous la forme choisi. Veillez cependant à TOUJOURS laisser le champs de rafraîchissement.
</p>
<img src="./resources/Widgets/edit.png">
<br>

<h4>Design et Architecture du Widget</h4>
<p>
    Dans un second temps, il vous faudra créer le patterne de votre widget. Pour cela il vous faudra créer le fichier "create-[WidgetName].ejs" au path "views/partials/Create/".
</p>
<p>
    Ajoutez y autant de champs que souhaité, sous la forme choisi. Cela sera le design et l'architecture de votre widget. Faites attention aux id que vous choisissez pour vos composants.
</p>
<img src="./resources/Widgets/create.png">
<br>

<h4>La mise à jour des données au travers du script</h4>
<p>
    Une fois le patterne et le formulaire de votre widget créer, il vous faudra faire le script, qui servira à modifier et/ou alimenter votre widget en données.
</p>
<p>
    Voici un exemple si besoin.
    <img src="./resources/Widgets/javascript.png">
</p>
<br>
<h4>La Liste des widgets</h4>
<p>
    Il vous faut ensuite ajouter votre widget à la liste.
    <img src="./resources/Widgets/widget-liste.png">
</p>
<p>
    Ajouter donc un branchement de "if" en remplaçant par le nom de votre widget. Changez cependant l'icon et le title.
</p>
<br>
<h4>Page de présentation des Widget</h4>
<p>
    Il vous faut ensuite ajouter votre widget à la liste de la page de présentation. Si votre widget fait partie d'un service existant déjà, vous pouvez l'ajouter à la liste de ce service comme le service en haut de la photo ci-dessous.
    <img src="./resources/Widgets/presentation-widget.png">
</p>
<p>
    N'hésitez pas le cas échéant, à créer votre propre service, rien de plus simple. Dans ce cas faites comme le service du bas de la photo ci dessus.
</p>
<br>
<h4>Page de lien Widget-Script</h4>
<p>
    Pour terminer, il vous faut lier le script de votre widget, à votre widget. Pour cela rajouter un "if" comme la photo ci dessous.
    <img src="./resources/Widgets/selection-script.png">
</p>
<br>
<h4>Conclusion</h4>
<p>
    Maintenant, vous pouvez, une fois connectez sur le Dashboard accéder à votre nouveau widget.
</p>
