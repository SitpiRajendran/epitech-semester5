<h1>Documentation de Dashboard:</h1>

***
<h3>Écran de connexion :</h3>
<p>
    Si vous avez un compte “connectez-vous". Si vous n’en avez pas, cliquez sur s’inscrire, ou si vous le souhaitez sur “se connecter avec google”. Si vous avez cliqué sur “s’inscrire”, vous arrivez sur une page, remplissez le formulaire. Une fois terminé vous serez renvoyé sur la page de connexion ou vous pourrez alors vous connecter.
</p>
<br>

***
<h3>Liste des Widgets</h3>

<p>
    Lors de votre connexion sur le site vous arriverez sur une page Dashboard. Si c’est votre première connexion, cette page sera vide. Sinon, vos anciens widgets seront rechargés. A conditions que vous en ayez set lors de votre précédente connection :D
</p>
<p>
    Pour ajouter, modifier ou supprimer des widgets, rendez-vous dans l’onglet sous Dashboard, nommé “widgets”. Si vous voulez ajouter un widget, cliquer sur “Ajouter” sous le widget voulu, un formulaire s’ouvrira pour affiner, et paramétrer le widget qui sera ajouté. Une fois le formulaire rempli, vous pourrez confirmer votre nouveau widget, et serez alors redirigé dans l’onglet "Settings" Vous pourrez dès à présent visualiser votre nouveau widget dans l'onglet "Dashboard".
</p>
<p>
    Il existe plusieurs widgets de plusieurs catégories :
</p>
<br>

<table><thead><tr><th>Bourse</th></tr></thead></table>

    -> Convertisseur de Devises
    -> Cours de l'action

<br>
<table><thead><tr><th>Cinéma</th></tr></thead></table>

    -> Movie Finder
    -> Cinéma Liste

<br>
<table><thead><tr><th>Epitech</th></tr></thead></table>

    -> Epitech Account Infos

<br>
<table><thead><tr><th>Github</th></tr></thead></table>

    -> Github Account Infos

<br>
<table><thead><tr><th>Google</th></tr></thead></table>

    -> Google News

<br>
<table><thead><tr><th>Horloge</th></tr></thead></table>

    -> Horloge Numérique
    -> Horloge Analogique

<br>
<table><thead><tr><th>Médical</th></tr></thead></table>

    -> Covid Infos

<br>
<table><thead><tr><th>Météo</th></tr></thead></table>

    -> Temps Actuel
    -> Temps sur une semaine
    -> Météo Double

<br>
<table><thead><tr><th>Server</th></tr></thead></table>

    -> Server Status Infos

<br>
<table><thead><tr><th>Twitter</th></tr></thead></table>

    -> Twitter User Account Infos

***
<h3>Les Widgets et leurs paramètres</h3>
<br>
<p>
    Chaque widgets requiert des paramètres spécifique. Retrouvez ci-dessous
</p>
<br>
<table><thead><tr><th>Bourse</th></tr></thead></table>
<h5>Convertisseur de devises:</h5>
<p>
    Le convertisseur de devise est un widget affichant la valeur d'un montant indiqué dans une devise, dans une seconde dévise. Ce widget requiert 3 paramètres, le premier est le taux de rafraichissment du widget, minimum 30.000 (ce sont des milisecondes). Ensuite, les 2 arguments suivant sont la première et la seconde devise voulu.
</p>

    -> Taux de rafraichissement (cursor bar)
    -> 1ère Devise (Scrolling List)
    -> 2nd  Devise (Scrolling List)
<br>
<h5>Cours de la bourse:</h5>
<p>
    Le widget sur le cours de la bourse affiche le cours d'une action pour 1 ou 2 entreprises données. Il prend en compte 2 paramètres, qui sont les noms des deux entreprises souhaité.
</p>

    -> 1 Entreprise souhaité (String)
    -> 2 Entreprise souhaité (String)
<br>

<table><thead><tr><th>Cinéma</th></tr></thead></table>
<h5>Movie Finder:</h5>
<p>
    Ce widget affiche les informations relative à un film, ou une série recherché. Il affiche le titre, la description, la note et la date de sortie du film ou de la série souhaité. En fond d'écran de ce widget s'affiche l'affiche de celui ci.
</p>

    -> Taux de rafraichissement (cursor bar)
    -> Film ou Série (Scrolling List)
    -> Description   (Checkboxe)
    -> Client Rate   (Checkboxe)
    -> Release Date  (Checkboxe)
<br>
<h5>Liste Cinéma:</h5>
<p>
    Ce widget affiche les informations relative à un film, ou une série recherché. Il affiche le titre, la description, la note et la date de sortie du film ou de la série souhaité. En fond d'écran de ce widget s'affiche l'affiche de celui ci.
</p>

    -> Taux de rafraichissement (cursor bar)
    -> Comédie  (checkboxe)
    -> Drama    (checkboxe)
    -> Horror   (checkboxe)
    -> Thriller (checkboxe)
<br>

<br>
<table><thead><tr><th>Epitech</th></tr></thead></table>
<h5>Account Infos:</h5>
<p>
    Ce widget affiche les informations relative à votre scolarité à Epitech. Il vous suffit de donner en paramètres votre lien d'autologin Epitech, ainsi que votre mail. Si vous ne savez pas où trouver votre lien d'autologin, il est disponible
    <a href="https://intra.epitech.eu/admin/autolog">ici</a>.
</p>

    -> Taux de rafraichissement (cursor bar)
    -> Lien d'autologin Epitech (String)
    -> Mail Epitech (String)
<br>

<br>
<table><thead><tr><th>Github</th></tr></thead></table>
<h5>Account Infos:</h5>
<p>
    Ce widget affiche les informations relative à un profil Github. Il vous suffit de donner en paramètres le pseudo github du compte recherché.
</p>

    -> Taux de rafraichissement (cursor bar)
    -> Pseudo (String)
<br>

<br>
<table><thead><tr><th>Google</th></tr></thead></table>
<h5>News:</h5>
<p>
    Ce widget affiche les informations dans la langue choisi. Vous pouvez choisir la manière dont vous trier ces news.
</p>

    -> Taux de rafraichissement (cursor bar)
    -> Langue       (Scrolling List)
    -> Choix du tri (Scrolling List)

<br>
<table><thead><tr><th>Horloges</th></tr></thead></table>
<h5>Numérique:</h5>
<p>
    Ce widget affiche l'heure de manière numérique. Vous pouvez choisir d'afficher cette heure sur 12h ou 24h.
</p>

    -> Taux de rafraichissement (cursor bar)
    -> 12 ou 24heure (Scrolling List)
<br>
<h5>Analogique:</h5>
<p>
    Ce widget affiche l'heure de manière analogique.
</p>
<br>
<table><thead><tr><th>Médical</th></tr></thead></table>
<h5>Covid:</h5>
<p>
    Ce widget affiche les informations relative à la pandémie mondiale de covid-19. On peut y visualiser les cas, les gens ayant été soigné, ou ayant gueris, et les morts. Ce compteur peut se faire dans un pays précis, passer en paramètre, ou sur toute la planète si rien n'est donné en paramètre.
</p>

    -> Taux de rafraichissement (cursor bar)
    -> Pays (String)

<br>
<table><thead><tr><th>Météo</th></tr></thead></table>
<h5>Live Météo:</h5>
<p>
    Ce widget affiche la météo en direct dans une ville donnée.
</p>

    -> Taux de rafraichissement (cursor bar)
    -> Nom de la ville souhaité (String)
<br>
<h5>Double Live Météo:</h5>
<p>
    Ce widget affiche la météo en direct dans deux villes données.
</p>

    -> Taux de rafraichissement (cursor bar)
    -> Nom de la première ville souhaité (String)
    -> Nom de la seconde ville souhaité (String)
<br>

<h5>Météo Semaine:</h5>
<p>
    Ce widget affiche la météo dans la ville donnée sur les 5 prochains jours.
</p>

    -> Taux de rafraichissement (cursor bar)
    -> Latitude  (String)
    -> Longitude (String)
<br>
<table><thead><tr><th>Météo</th></tr></thead></table>
<h5>Live Météo:</h5>
<p>
    Ce widget affiche disponibilité d'un server. Il informe sur le status (Up ou Down) d'un server selon le lien passer en paramètre.
</p>

    -> Taux de rafraichissement (cursor bar)
    -> Lien du site choisi (String)
<br>
<table><thead><tr><th>Github</th></tr></thead></table>
<h5>Account Infos:</h5>
<p>
    Ce widget affiche les informations relative à votre profil Twitter. Il vous suffit d'avoir créer votre compte sur notre plateforme avec Twitter directement.
</p>

    -> Taux de rafraichissement (cursor bar)
<br>

***
<h3>Qui sommes-nous ?</h3>

<p>
    Avant de vous connecter, vous pouvez scroller vers le bas pour tomber sur notre page “qui sommes-nous ?”. Vous pourrez en savoir un peu plus sur les supers développeurs de ce site.
</p>
<br>
<br>
<br>
<h5>©Copyright User Dashboard Documentation Roméo TALOVICI & Sitpi Kevin RAJENDRAN</h5>