<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="java.util.Properties"%>
<%@page import="com.lapeyre.declic.configurations.ConfigTool"%>
<html>
<head>
	<title>Version produit</title>
	<meta http-equiv="Content-Type" content="text/html">
</head>
<body>
<%
		//Get number version
		Properties configurationProperties = ConfigTool.getConfigurationPropertiesResource();
		String versionNumber = configurationProperties.getProperty("version.number");
		if(StringUtils.isNoneBlank(versionNumber) && request != null){
			request.setAttribute("versionNumber",versionNumber);
		}
		
      	long heapSize = Runtime.getRuntime().totalMemory(); 
		long heapMaxSize = Runtime.getRuntime().maxMemory();
		long heapFreeSize = Runtime.getRuntime().freeMemory(); 
		
		float heapSizeGBytes =(float) (new Float(heapSize) / 1073741824);
		float heapMaxSizeGBytes =(float) (new Float(heapMaxSize) / 1073741824);
		float heapFreeSizeGBytes =(float) (new Float(heapFreeSize) / 1073741824);
		float heapUsedGBytes = heapMaxSizeGBytes - heapFreeSizeGBytes;
		
		if(request != null){
			request.setAttribute("heapSize",heapSizeGBytes);
			request.setAttribute("heapMaxSize",heapMaxSizeGBytes);
			request.setAttribute("heapFreeSize",heapFreeSizeGBytes);
			request.setAttribute("heapUsedGBytes",heapUsedGBytes);
		}
		if(request.getParameter("refresh") != null){
				response.setIntHeader("Refresh", new Integer(request.getParameter("refresh")));
		}
		
%>
<pre>
JVM memory information: <%=com.ibm.websphere.runtime.ServerName.getDisplayName()%>
maxMemory in JVM    ${heapMaxSize} 
Size of java heap   ${heapSize} 
Used Memory in JVM  ${heapUsedGBytes}  
freeMemory in JVM   ${heapFreeSize}  
</pre>

</br>
</br>
</br>

Current : v${versionNumber}

	<pre>   
Changelog
=========


version v2.0.10
--------------

	360: ajout de l'attribut automaticResponseUrl à l'appel Mercanet
	361: Stockage authorisationId pour faciliter rapprochement bancaire
	364: [MERCANET] logs retours Mercanet



version v2.0.09
--------------
	256: correction calcul ecopart en double et affichage
	352: Fiches produits SM : Masquer prise de RDV par défaut
	323: Prise de RDV - Ajouter champ mail
	147: Sticky header
	346: Tracking - Etape panier
	347: Tracking - Etape identification tunnel
	349: Tracking - Etape livraison
	350: Tracking - Etape paiement
	150: Tracking-A implémenter en dur- Variable "Product category"
	336: Fiche produit - Caractère d'échappement
	310: Pages familles - syntaxe HTML KO
	254-305: Suppression des URL longs
	204-232: problèmes d'affichage de "mes magasin" sur Safari iOS/OSx
	161: Fiche produit : Phrase indispo
	331: Page 404 : Coquille orthographique
	334.3: Optimisation front, correction appels js sur statics (hors dojo)
	301: [Tunnel Pro] empêche qu'une nouvelle adresse devienne l'adresse de facturation
	357: [StoreLocator]- Quota dépassé - Cause : erreur d'appel API


version v2.0.08
--------------
	249	CMS - Certaines catégories ne sont pas associables aux MEA
	297	Si les items sont non buyables, la fiche produit reste sur le ProductLevel
	298	Impossible de ce creer/modifier une adresse si RNVP indisponible


version v2.0.07
--------------
	256	prix promo popin
	271 [Confirmation de commande] - Problème emplacement appel Framework js
	276+279 gestion des redirections

version v2.0.06
--------------
	265 Message d'erreur dans le mail de prise en compte
	264 id Transaction Mercanet pas le bon
	130 [Création compte Pro] - chevauchement des 2 formulaires (particulier et pro)
	245+248 Pages sous-familles : Liste des catégories soeurs
	Fixes graphiques
	

version v2.0.05
--------------
	Mercanet v2 : conf PRD
	257	Page "Meubles de la collection"
	pb de deadlock


version v2.0.04
--------------
	augmentation du seuil pour eviter les deadlocks
	desactiver le scheduler sur les fronts
	correctifs http sitemap
	255	prixpromo rouge
	186+253	affichage des resultats si non famille/univers
	
	

version v2.0.03
--------------

	130	[Création compte Pro] - chevauchement des 2 formulaires (particulier et pro)
	141	CSS Blocs Services Home
	208	[Magasins Loggé] Services livraison mal affichés
	220	Le prix barrés n'apparait pas au panier sur INT 2 V8 sur un code en promo /soldes
	227	Affichage facette - libellé non alligné



version v2.0.02
--------------
	121	[famille produit] renvoi en haut de page absent
	125	[famille produit] zone SEO absente
	126	[identification] graphisme pas respecté
	130	[Création compte Pro] - chevauchement des 2 formulaires (particulier et pro)
	135	[Formulaire de création de compte_champ télephone] - Absence de msg d'erreur quand présence caractères spéciaux ou numéro trop l
	140	Footer : Mise à jour année
	143	[fiche produit standard] nuancier
	146	Expand Recherche - Image catégories
	148	Recherche : Onglet éditorial - wording à changer
	157	Première connexion : modifier le texte à cookie et supprimer le bouton OK
	160	[Panier - Code promo] message de prise en compte présent après suppression du code
	165	Ajout panier : Pb affichage image
	171	Fiche produit sur mesure: supprimer bénéfice client
	173	Header : Expand "Magasin" absent
	174	Storeloc: wording
	178	Raccorder le formulaire de demande de rendez-vous à Salesforce
	181 [Catalogue papier_page produit] - Pb dimension visuel
	200	Correction CSS
	202	[MAG] Affichage de la Home page du Mag KO
	210	[Magasins - itinéraire] Popin inutilisable
	213	[Fiche magasin] - Impossible de partager infos (desktop)
	215	[MAGAZINE] Affichage erroné
	

version v2.0.01
--------------
	fix footer 
	fix prix barrés 
	fix header tunnel livraison mobile
	
	

version v2.0
--------------
	Migration v8
	Refonte graphique
	113	Blocage de la livraison sur les produits soldés
	83	Catégories non mises à jour à cause d'une erreur technique



version v1.13 RC2
---------------
	73	data layer add to cart
	75	data layer confirmation commande
	91	data Layer contact
	94	data Layer newsletter
	95	data Layer carrousel
version v1.13 RC1
---------------
	18	page monitoring ppr
	20	Prise en compte d'un attribut sur les CCN pour afficher ou non les CCN dans le header
	82	mise a jour catalogues papier
	85	promo article prefere (cas coeff=1)
	89	data Layer newsletter display
	93	[Colisage] Prix au m2 incorrect
	

	
version v1.12 RC1 ( 03/03/2017)
---------------
	19	Appel WebService : Int�gration des demandes de RDV du formulaire WEBs
	66	Grille tarifaire au poids : RG en cas de poids non renseign�
	68	[Commande] - Commande Pro - Adresse de livraison forc�e � Adresse de Facturation
	70	Ajout d'une variable Page Produit - Suivi r�seaux sociaux
	Import produit : Fix bug buyable

	25	[Data layer ] - Ajout d'une variable Banni�re Home page
	26	[Data layer ] - Ajout d'une variable Banni�re Univers
	27	[Data layer ] - Ajout d'une variable Banni�re Famille
	28	[Data layer ] - Ajout d'une variable Formulaire de contact
	29	[Data layer ] - Ajout d'une variable Page Produit - Partage
	30	[Data layer ] - Ajout d'une variable Pop in newsletter
	71	[Data layer ] - Ajout d'une variable Pi�ce Habitation
	74	[Data layer ] - Ajout de variables - Fiche produit
	69	[Data layer ] - Ajout d'une variable Bouton Appel magasin
<!-- 
73	[Data layer ] - Ajout de variables "ajouts au panier"
75	[Data layer ] - Ajout de variables - Page confirmation de commande
 -->	
	
version v1.11 RC2 ( 27/02/2017)
---------------
	0068	Commande Pro - Adresse de livraison forc�e � Adresse de Facturation

version v1.11 ( 23/02/2017)
---------------
	0022	Mise � jour redirections SEO
	0041	Page Fiche produit - Section Avis client : informations non conformes
	0047	Page Identification - "Email Mot de passe oubli�" : champ Email non pr�-rempli
	0060	[Data layer ] - formatage donn�e prix produit panier/commande
	0025/0027/0028/0029/0030	[Data layer ] 
	0064	Promotion export�e comme un Coupon
	Atout prix	
	Mail confirmation
	Frais de livraison au poids
	<!--  WS Demande de prise de RDV -->

version v1.10 RC2 (27/01/2017)
---------------
	0036 0038  0039 0042 Correction adresse facturation client pro (#32 #27 #28 #29)
	0040	Fiche magasin - Bouton Epingl� : comportement non conforme en mode non logg� (#1)
	0050	Fiche produit - Section Avis client : informations non conformes
	0051	Lien notice de montage
	0002	Fix export paniers abandonn�s + parametrage a la minute
	0053	Fiche produit - Barre de navigation : comportement � revoir
	0052	Fiche produit Collection - Bloc Carrousel : affichage non conforme
	0022	Mise � jour redirections SEO
	Mise � jour configuration applicative (perf/secu)
	Configurateur : appel HTTPS
	Store Locator - Pin Magasin : comportement non conforme au changement de magasin (#38 - Tina23)
	Pages institutionnelles / Articles - Picto Temps de lecture (#39 - Tina26)

version v1.10 RC1 (24/01/2017)
---------------
	BV : appel DECLIC et non GTM
	Adresse facturation client pro
	3750	Compte light : controle d'adresse
	0002	Export paniers abandonn�s
	0015	Plus de suppl�ment �tage
	Import : split flux produit/asset
	


version v1.9.02 (12/01/2017)
---------------
	fix promo carrelage
	fix monitoring PPR
	fix import product - champ buyable
	correction d'exceptions : resa drive date vide, search ".", ordertracking avec des caracteres comme des chiffres arabes, erreur BDD
	export commande : pas d'ajustement si pas de montant associ�
	affichage promo desc + cgu en mobile
	image email

version v1.9.01 (05/01/2017)
---------------
	fix import produits

version v1.9.0 (21/12/2016)
---------------
	3407	[Passage en HTTPS] - balise canonical en HTTPS
	3548	[CONTENT WCS] Cr�er un content-type MEA
	3697	Am�lioration des performances : Mettre en place un sous-domaine static.lapeyre.fr
	3750	[Tunnel de commande] Formulaire de cr�ation d'adresse : contr�le RNVP non conforme
	3768	[notice de montage] Lien dans le mail de partage KO
	3763	[Formulaire Creation Compte Light] - perte du contr�le sur le format du Code Postal (min 4chiffres)


version v1.8.0 (14/12/2016)
---------------
	3547	[CMS- FLUX] Exposer un service de r�cup�ration du d�tail d'une MEA
	3623	[Responsive] Mise au panier : comportement KO au back navigateur
	3668	[Tunnel de commande] [IE11] Page Livraison : comportement non conforme du bloc S�lection de magasin
	3752	[R�gression][Catalogue] Affichage Page Famille Carrelages KO
	3760	[Suivi de commande] Affichage non conforme en mode PRO
	3761	[IE11/Edge][Tunnel de commande PRO] Affichage non conforme d'un libell�
	3763	[Formulaire Creation Compte Light] - perte du contr�le sur le format du Code Postal
	3766	[Confirmation de commande] - Erreur de date de dispo produit affich�e
	3769	[flux FPC] non rattachement d'une FPC
	3771	[Flux Client] Echec EAI si idCrm = NON RENSEIGNE
	3770	[Flux categorie] mise � jour simultan�e Sales et Master catalog
	Configurateur : suppression de projet et pagination


version v1.7.01 (06/12/2016)
---------------
	parametrage acces configurateur

version v1.7.0 (23/11/2016)
---------------
	3128	impossible de d�s�pingler un magasin
	3575	[Firefox] [Tunnel de commande] Page Livraison : comportement KO pour la recherche de magasin
 	3648	[Compte client] Cr�ation de liste d'achat : taille maximale du titre non conforme
	3655	[Compte client] Page Mon profil : comportement non conforme
	3687	[PROMO WCS] activer les code promo WCS
	3688	[PROMO WCS] Cr�ation Promo Custom -X% sur article pr�f�r�
	3691	CR-03: Hash (rather than encrypting) the passwords with a strong algorithm (e.g. SHA256)
	3701	Creation page de monitoring des services h�berg�s par le site
	3712	[PROMO WCS] Display Promotion Price
	3717	[PROMO WCS] Proximity Promotion Message - Page panier
	3741	Promotions combinables+empilables: les promos n'apparaissent pas toutes dans le mail de confirmation
 	3742	[Commande] billto_email erron� sur certaines instructions de paiement
	3743	Rajouter le code postal (champ obligatoire) sur le formulaire "Webmaster"
 	3744	[Ajout CSS Mercanet] - ajout d'une CSS custo pour mercanet version mobile
 	Promo - gestion des codes promo

version v1.6.03 (09/11/2016)
---------------
	Configurateur : param�trage

version v1.6.02 (27/10/2016)
---------------
	3723	[Compte client light] Impossible de valider le formulaire Ajouter une adresse dans le tunnel de vente
	3728	[Partage] Comportement non conforme du bloc de pictos d'une fiche Magasin
	3731	[Compte client] Page Cr�ation/Modification d'adresse : non affichage des messages RNVP
	3738	[Compte client full][R�gression] Cr�ation de compte via le tunnel bloqu�e � cause d'un mauvais contr�le RNVP
	Configurateur : param�trage

version v1.6.01 (20/10/2016)
---------------
	3428	[Navigation top] Lien Newsletter : non contextualis� si logg� avec un compte abonn� � la Newsletter
	3632	[Newsletter] Contr�les sur les champs non conformes
	3666	[Suivi de commande] Page D�tails d'une commande : information de date cliquable
	3683	[Soldes] Page KO
<!-- 	3687	[PROMO WCS] activer les code promo WCS  -->
	3723	[Compte client light] Impossible de valider le formulaire Ajouter une adresse dans le tunnel de vente
	3724	[Flux Client] - PRO - code patronyme � 1 dans les infos pro pour une civilit� � 5
	3725	[Emails] Confirmation de cr�ation de compte Light : valeurs non conformes
	3726	[Tunnel de commande] Page Livraison : faute d'orthographe
	3727	[Partage] Affichage non conforme de la popin de confirmation
	3731	[Compte client] Page Cr�ation/Modification d'adresse : non affichage des messages RNVP
	3732	[Compte client] Page D�tails Liste d'achat vide : bouton "Retour" absent
	3734	[IE11] [Store Locator] [R�gression] Affichage non conforme des blocs Magasins
	3735	[Fiche produit] [R�gression] Popin Vid�o : affichage non conforme

version v1.6.0(12/10/2016)
---------------
	3440	[Compte client] Page Identification : contr�le KO sur le format de l'email
	3581	[Responsive] Confirmation Ajout au panier : affichage non conforme
	3582	[Responsive] Fiche produit : positionnement non conforme du champ Quantit� sur iPhone 6
	3583	[Responsive] Popin Newsletter : affichage non conforme sur iPhone6+
	3592	[Responsive/iOS] Store Locator - Vue Liste : affichage des blocs Magasins non conforme
	3612	[Responsive] [TAB] Pages Formulaires et FAQ : affichage non conforme
	3621	[Responsive] [Tunnel de commande] Header mobile : absent sur les pages du tunnel
	3637	[IE11] Partage par email : comportement KO
	3650	[Compte client] Listes d'achat : comportement KO en mode non logg�
	3666	[Suivi de commande] Page D�tails d'une commande : information de date cliquable
	3668	[Tunnel de commande] [IE11] Page Livraison : comportement non conforme du bloc S�lection de magasin
	3682	[Responsive] [Android 4.4] Header : affichage KO sur certaines pages
	3684	[Responsive] [Android 4.4] Facettes : affichage KO des facettes de type "range"
	3685	[Responsive] [TAB] Page Panier : probl�me d'alignement
	3692	[RECOMMAND PROMOTION] Le widget recommand Promotion ne s'affiche plus
	3694	Ajout "transaction_newcustomer" dans le datalayer
	3695	Frais de livraison non pris en compte
	3696	Am�lioration des performances - Mise en place de PageSpeed
	3697	Am�lioration des performances : Mettre en place un sous-domaine static.lapeyre.fr
	3699	Int�gration du configurateur : services d'authentification
	3700	Creation compte client light
	3705	[COUPON] Le coupon RATE_ITEM ne s'applique que sur la Qt� 1 pour certains carrelage
	3708	Dermande de mise � disposition d'URL
	3714	Pb popin inscription Newsletter
	3715	Champs source Mails Cabestan
	3718	Mail de confirmation - changement adresse Contact center
	3721	[CONFIGURATEUR] Int�gration dans les wishlist
	3722	[DataLayer] - Transaction - Variable mal nomm�e


version v1.5.05(06/10/2016)
---------------
	Fix param�trage destinataires mails

version v1.5.04(29/09/2016)
---------------
	3709	[Email de contact] - Ajout numero magasin dans le corps de l'email de contact
	3711	Num�ro de tel mails

version v1.5.03(21/09/2016)
---------------
	3703+3706	Notice de montage incorrectement int�gr�e

version v1.5.02(09/09/2016)
---------------
	3428	[Navigation top] Lien Newsletter : non contextualis� si logg� avec un compte abonn� � la Newsletter
	3455	[Home page] Bloc push Produits : probl�me d'affichage
	3563	[Store Locator] Mode logg� : adresse de d�part non conforme dans la popin Calcul d'itin�raires
	3569	[Compte client] Page Identification : d�doublonnage KO
	3573	[Tunnel de commande] Page Panier : probl�me d'alignement
	3610	[Partage] [iOS9] Clic sur les pictos de partage sur les r�seaux sociaux : comportement KO
	3615	[Responsive] Store Locator : affichage non conforme du dernier bloc Magasin
	3617	[Responsive] Page Mes listes d'achat : affichage non conforme sur grands �crans
	3618	[Tunnel de commande] [R�gression] Page Confirmation : mention "Acompte" non conforme
	3645	[Recherche] Tri sur les produits : comportement non conforme pour le tri "Meilleures ventes"
	3660	[Store Locator] [R�gression] Calcul de la position de l'utilisateur : comportement KO
	3669	[Tunnel de commande] Mode logg� PRO : donn�es non conformes sur le bloc Adresse
	3686	[Responsive] Pictos et visuels : probl�me de qualit�
	3689	[Tunnel de commande] Impossible de valider et poursuivre la commande
	3690	[Tunnel de commande] Page Livraison : Comportement non conforme shopadre


version v1.5.01(01/09/2016)
---------------
Correctifs
	3128	impossible de d�s�pingler un magasin
	3476	[Commande Carrelage] - int�gration du num�ro de lot dans la commande
	3560	[Store Locator] Mode non logg� : d�s�lection du magasin s�lectionn� impossible
	3566	[Compte client] Expiration de session : affichage KO
	3568	[Catalogue/Recherche] Bouton Comparateur : comportement non conforme
	3593	[Responsive] D�connexion : aucun lien
	3604	Actions SEO- R��criture d'URL Automatique dans le dur pour pagination, retirer "grid" de l'url
	3606	Taille de l'identifiant des ASSET
	3607	[Recherche] Saisie non limit�e � 254 caract�res
	3608	[PRO] Page Lapeyre PRO : page KO
	3619	[Tunnel de commande] Page Confirmation : texte � corriger
	3629	[Datalayer GTM] - Modification valeur user_id
	3631	[Newsletter] Champ obligatoire non signal� par une ast�risque
	3632	[Newsletter] Contr�les sur les champs non conformes
	3636	[Footer] Liens R�seaux sociaux : liens pas en https
	3638	[Partage] Partage par email non fonctionnel
	3641	[Confirmation Commande] - modification de texte
	3642	[Email Confirmation de commande] - Modifcation de texte
	3644	[Header] [R�gression] Lien Comparateur : rollover non conforme
	3646	[Facettes] Comportement non conforme des fl�ches d'expand
	3654	[Emails] Confirmation de cr�ation de compte : fautes � corriger
	3656	[Compte client] Page Mon profil : positionnement des messages d'erreur non conforme
	3662	[Suivi de commande] Formulaire de recherche de commande : absence des ast�risques sur les champs obligatoires
	3663	[Suivi de commande] Formulaire de recherche de commande : message d'erreur non conforme
	3664	[Suivi de commande] Page Liste des commandes : �l�ments non cliquables
	3665	[Suivi de commande] Page D�tails d'une commande > 15 jours : bouton "Annulation" non conforme
	3666	[Suivi de commande] Page D�tails d'une commande : information de date cliquable
	3667	[Tunnel de commande] Page Livraison : absence de l'ic�ne Horaires dans le bloc Magasin
	3669	[Tunnel de commande] Mode logg� PRO : donn�es non conformes sur le bloc Adresse
	3670	[Formulaires] Mode logg� PRO : validation des formulaires KO (champ manquant)
	3671	[Formulaires] Formulaire Partenariat : taille maximum du champ Raison sociale non conforme
	3674	[Tunnel de commande] Libell� promotion non cliquable
	3679	[Formulaires] Mode logg� PRO : pre-remplissage des champs incoh�rents
	3680	[Responsive] Store Locator : comportement non conforme apr�s recherche de magasin
Am�liorations
	3405	[Version des statiques] - modifications de CSS et JS obligent � un vidage de cache navigateur
	3600	Lenteurs d'affichage
	3625	Maquette (jpeg+psd) Popin de paiement
	3639	AU-10: Send a mail when a modification is done to a user's account on the frontend.	
CMS
	3640	AU-06: Update the password policy on CMS backend to require at least 8 characters and 2 complexity criteria.
	

version v1.5.0 (19/08/2016)
---------------
	IBM	cumulative fix #3
	1287	[Header Panier] - Les produits sont affich�s en doublon
	1330	[Panier] - Le panier affiche des doublons	
	3324	sitemap vid�o � cr�er
	3464	[Barre de recherche] IE11 : affichage non conforme
	3471	[HTTPS] - Mixed content http/https - Formulaire email
	3513	[PROMO] gestion du colisage - foire au carrelage
	3538	[PROMO WCS] g�rer le filtre par attribut au niveau de la config promo
	3539	[SEARCH] Les contenus pr�sents dans le dossier "cach�" remontent dans le search
	3545	[WIDGET RECO PRODUIT] Configuration de l'affichage des Reco
	3549	[FIX PACK] Passer l'APAR JR55919
	3554	Nettoyage traces des logs de Prod
	3556	releaseID absent du xml de l'order
	3574	[Tunnel de commande] Page Inscription : probl�me d'affichage
	3576	[Catalogue] [Tunnel de commande] Mode logg� PRO : affichage de la mention HT non conforme
	3577	[Tunnel de commande] Page Panier - Catalogues papier : pr�sence du Code avantage non conforme
	3578	[Tunnel de commande] Page Livraison - Catalogues papier : �l�ments incoh�rents
	3584	Changement de proxy pour les appels web services externes
	3586	[Responsive] Menu mobile : entr�es Newsletter et Suivi de devis sur la m�me ligne
	3587	Wording � corriger dans message erreur 404
	3593	[Responsive] D�connexion : aucun lien
	3594	[Emails] Confirmation de commande : fautes � corriger
	3596	[Tunnel de commande] Page Confirmation : pr�sence d'un double espace
	3597	Ajustement CSS - Macaron carte fid�lit�
	3599	Mode de paiement multiple sur commnade
	3601	[Vue Liste] - Disparition du bouton 'Acheter en ligne'

version v1.4.07 (16/08/2016)
---------------
	3498 - notices de montage - FIX
	3324/3540 - Sitemap video - FIX conf proxy
	3553 - Pas d'ARC dans le cas d'erreurs technique - FIX

version v1.4.06 (05/08/2016)
---------------
	3571 - Commande Promo] - Code Tarif Promo KO
	3572 - [PROMO FID] Recap Panier - absence montant de la remise

version v1.4.05 (04/08/2016)
---------------
	3561 - Carte FID: pb de d�clenchement
	3558 - Carte FID: pb sur le panier

version v1.4.04 (02/08/2016)
---------------
	3522 - d�sactiver l'interrogation des stocks sur les FPC
	3543 - [CONF] targetiser les cache marketing
	3555 - Le code Tarif n'est pas export� dans ProcessOrder

version v1.4.03 (01/08/2016)
---------------
	3515 - [FIDELITE] Gestion du segment "fid�lit�"
	3552 - [Management Center] Champs additionnels description promotions

version v1.4.01 (27/07/2016)
---------------
	3540 - [SITEMAP - INT] Le sitemap CMS ne contient pas les vid�os
	3542 - [FIDELITE] ribbon-ad offre fid�lit� non affich� sur les produits mono-SKU
	3541 - [VIDEO] Affichage des vid�os dans l'article �ditorial

version v1.4.0 (26/07/2016)
---------------
	3497 - [COMMANDES] Perte des promo en cas d'annulation de paiement
	3534 - [MEA Megamenu] Les MEAs dans le folder subMenuLeft ne remontent pas
	3503 - [PROMO] Affichage des promotions dans le panier
	3501 - [PROMO] Export des promotions
	3500 - [PROMO] champs additionnels dans le param�trage des promos
	3499 - [PROMO] Gestion des promos WCS
	3443 - [Tunnel de commande] Bloc R�capitulatif Panier - Catalogues papiers : montant total non conforme
	3515 - [FIDELITE] Gestion du segment "fid�lit�"
	3529 - Urls � corriger : Vignettes des sous cat�gories
	3528 - Retrait de la ligne FAQ dans robots.txt
	3527 - R��criture URL premi�re page de la pagination
	3518 - Actions SEO- G�rer les codes erreur 200
	3516 - Actions SEO- Supprimer les balises canonicals
	3535 - Affichage vignette r�sultats de recherche Free HTML		
	3324 - sitemap vid�o � cr�er
	3532 - [FIDELITE] Affichage ribbon-ad offre fid�lit�
	3498 - [NOTICE MONTAGE] Afficher les notice de montage � l'item
	3519 - Actions SEO- Retirer param�trage en dur de certaines urls (g�n�r� par le module de crosslinking)

version v1.3.06 (12/07/2016)
---------------
	3505 - Changement Sujet Formulaire contact
	3511 - 3512 - PB pastille de dispo des produits
	3508 - Pb encoding Flux Criteo
	3521 - [STOCK] Gestion du r�sultat de stock - prise en compte quantit�

version v1.3.05 (04/07/2016)
---------------
	3492 - D�formation logo Instagram
	3491 - [Page Livrasion/Retrait] - Retrait ou Drive - Masquer la ligne Frais de livrasion	
	3483 - [Ratings] Impl�mentation api BVSEO
	3485 - Delta constat� en prix commande accelerator et prix captur� Mercanet
	3392 - [T2S] Int�gration tri-Liste sur pages familles
	3490 - Code 200 au lieu de 404 templates pages erreurs
	3489 - XML Flux Criteo mal form�
	3488 - Flux Google Shopping KO
	3480 - Acc�s flux Criteo
	
version v1.3.04 (29/06/2016)
---------------
	3478 - Toutes les pages - Absence bandeau Soldes
	3477 - Fiche produit - Gestion bandeau + pastille Soldes
	3481 - [Formulaire cr�ation compte] - r�duire le champ pr�nom - maxlength 60
	3484 - [Soldes] - Js bloqu� par des doubles Quotes
	3486 - XSS Vulnerabilty
	Affichage bandeau promo et ribbonad en vue liste

version v1.3.03 (23/06/2016)
---------------
	3446	[Fiche produit] Produit en promotion : comportement au clic sur les conditions de l'offre non conforme
	3472	Ajustement flux criteo
	3473	[SOLDES] Pastilles mal affich�e
	3474	[SOLDES] Des produits remontent en soldes alors qu'ils ne devraient pas
	3475	[SOLDES] le bandeau solde ne s'affiche pas
	T2S	reco : Erreur parametre inconnu

version v1.3.02 (17/06/2016)
---------------
	3421	[Store Locator] Barre de recherche de magasin : contr�le non conforme
	3422	[Store Locator] Carte : zoom non conforme apr�s une recherche donnant plusieurs r�sultats dans un rayon de 150km
	3439	[Tunnel de commande] Page Panier : comportement KO pour une commande indisponible sur un magasin donn�
	3443	[Tunnel de commande] Bloc R�capitulatif Panier - Catalogues papiers : montant total non conforme
	3451	[Catalogue] Popin Confirmation d'ajout � la liste d'achat : comportement non conforme
	3468	[Tunnel de commande] Page Panier : comportement KO au changement de magasin
	3469	[Tunnel de commande] Page Livraison : page KO

version v1.3.01 (14/06/2016)
---------------
	2883	Les statuts des commandes magasin envoy�es � DECLIC sont tous � En cours
	3158	Supprimer les notes Visitor Book des fiches magasins dans D�clic
	3391	Cr�ation flux produits Criteo
	3406	N� de tel mail de confirmaton de commande � modifier
	3408	Vidage des caches
	3412	Mise � jour logo Instagram Footer
	3415	[Emails] Confirmation de cr�ation de compte : champs "T�l�phone" manquants
	3416	[Emails] Confirmation de cr�ation de compte : faute � corriger
	3417	[Mega Menu] probl�me d'affichage des blocs MEA
	3419	[Home page] Zone de push produits : banni�re "promo" non affich�e
	3430	[Compte client] Modification de donn�es personnelles : comportement non conforme
	3433	[Catalogue] Pages Famille (Category) et Sous-Famille : fonctionnalit� de tri KO
	3439	[Tunnel de commande] Page Panier : comportement KO pour une commande indisponible sur un magasin donn�
	3443	[Tunnel de commande] Bloc R�capitulatif Panier - Catalogues papiers : montant total non conforme
	3449	Mise � jour logo Instagram Footer mails
	3454	[Barre de navigation] Chrome et Safari : probl�me d'affichage
	3456	[Catalogue] Blocs Produits (view teaser grid) : fonctionnalit� d'ajout � la liste d'achat KO
	Target2Sell ranking - debrayage

version v1.3.00 (07/06/2016)
---------------
	2883	Les statuts des commandes magasin envoy�es � DECLIC sont tous � En cours
	3380	Vuln�rabilit� de type XSS stock�e
	3381	Vuln�rabilit�s de type XSS volatiles
	3386	Absence de protection anti-CSRF
	3390	[MENU NAVIGATION] Administration de 3 entr�es de menu
	3392	[T2S] Int�gration tri-Liste sur pages familles
	3397	[Formulaire Client PART] - Suppression Champs date de naissance
	3399	[Synchro Client CRM] - Compte PRO
	3406	N� de tel mail de confirmaton de commande � modifier
	3409	Ajout d'un traitement suppl�mentaire pour les SOLDES
	3410	Cr�ation d'un onglet suppl�mentaire promo
	[T2S] 	Reco - nouvelles pages + data, onclick fix�
	Ribon ad � l'item


Hotfix v1.2.07b (25/05/2016)
---------------
	3404 email confirmation de commande ko
	S�curite popup login
	3398: Pro avec Encours - ne pas proposer ce mode de paiement

version v1.2.07 (23/05/2016)
---------------
	Fix visuel categorie
	Target2Sell : correctifs valeurs transmises tracking / onclick

version v1.2.06 (20/05/2016)
---------------
	3398	Pro avec Encours - ne pas proposer ce mode de paiement
	3354	Int�gration Target2Sell couche basse
	Promo imbattable
	Flag solde

version v1.2.05 (17/05/2016)
---------------
	3144	compte pro et recap panier retrait de la ligne frais de livraison si Frais = 0
	3358	Creation compte client - rendre obligatoire la saisie d'au moins un n� de tel
	3389	Prise en compte des retours d''A/B tasty sur le tunnel de commande
	3393	[WS /headerfooter/{categories}] gestion des ID de cat�gories erron� (case sensitive)
	3395	MEA Free HTML page PromotionSearchDisplay sur mobile
	3396	Div BazaarVoice Fiche produit + Wording
	Target2Sell Recommendations - gestion de proxy et de timeout


version v1.2.04 (12/05/2016)
---------------
	1130	[Liste d'achat] - Mauvais titre produit sur la popin de confirmation d'ajout du produit
	1325	[Panier] - Le titre du produit n'est pas conforme
	3138	supprimer la colonne tva de la page panier pour les parts
	3202	Le telechargement des coordonn�es GPS KO ne fonctionn pas sur iPhone
	3242	le cross-sell de la home page propose 1 seul produit sur mobile
	3260	Il n'y a plus de prix sur les cross-sell Target2Sell
	3340	Image d�form�e fiche produit
	3350	suppression de la pagination
	3354	Int�gration Target2Sell couche basse
	3358	Creation compte client - rendre obligatoire la saisie d'au moins un n� de tel
	3361	Guide de pose - mise en oeuvre WCS
	3362	Ajout d'un onglet "bonnes affaires" dans les items de menu
	3365	[Formulaire cr�ation compte PRO] - SIRET valide rejet�
	3379	Ajout FAQ menu Mobile/Tablette
	3388	Passage � paiement 100% en retrait
	3389	Prise en compte des retours d'A/B tasty sur le tunnel de commande



version v1.2.03 (18/04/2016)
---------------
	3264	[Maps API] - Modification appel maps API -
	3310	[Produit de remplacement] - pop in syst�matique
	3334	En prod, il y a une r�gression graphique sur l'affichage de l'adresse de facturation de la page paiement
	3338	search sur la marque Grohe ne fonctionne pas
	3339	Validation compte Google Webmaster Tool
	3342	La page livraison empeche de passer � la page paiement sous iPhone 5
	3346	[Fiche Produit] stock - Indisponible m�me quand date d'appro existe
	3349	suppl�ment �tage sur colissimo
	3353	[Catalogue Papier] - selection adresse de livraison impossible
	bug affichage promo
	messages d'erreur logs : setHeader, appel search mauvais profil, page categorie sans id
	Workflow commande : ajout statut intermediaire (w) pour gestion licenses
	Page 404 sur appel extract T2S,googlesite, googleshop 


version v1.2.02 (05/04/2016)
---------------
	623		[zone de facette] Le pav� "Ma s�lection" ne doit pas �tre visible quand celui-ci est vide
	1070	[Page famille] Lors du clic sur une facette, la page se recharge bien mais nous sommes positionn� en bas de page
	3181	la recherche sur les mots "garde corps" renvoie des r�sultats incoh�rents
	3199	Navigation compte client - ajout d'un menu de navigation
	3221	[Mobile] Il faudrait pouvoir rabattre le menu en "slidant" vers la gauche
	3326	Ajustement CSS
	3330	Le menu de l'espace mon compte doit �tre affich� sur la page de confirmation de cr�ation de compte
	Evol Ribbon ad
	Affichage dispo aujourd'hui

version v1.2.01 (01/04/2016)
---------------
	331		[Contenu dossier] - Dossier en mode grille
	623		[zone de facette] Le pav� "Ma s�lection" ne doit pas �tre visible quand celui-ci est vide
	765		[Page de Promotion] La facette de promotion ne doit pas appara�tre dans la page de Promotion
	1070	[Page famille] Lors du clic sur une facette, la page se recharge bien mais nous sommes positionn� en bas de page
	3121	Bug lien Service client
	3138	supprimer la colonne tva de la page panier pour les parts
	3163	Ajout instagram r�seaux sociaux
	3181	la recherche sur les mots "garde corps" renvoie des r�sultats incoh�rents
	3199	Navigation compte client - ajout d'un menu de navigation
	3203	Le picto vid�o et le temps de lecture s'affichent sur le sous-titre du contenu
	3221	[Mobile] Il faudrait pouvoir rabattre le menu en "slidant" vers la gauche
	3274	[Flux Client JMS] - Donn�es manquantes
	3297	CMS - Ajout en BO et affichage des fermetures exceptionnelles
	3302	Pages d'erreur qui renvoient un status 200 au lieu de 400
	3307	le changement de mot de passe ne fonctionne plus en recette
	3313	[Configuration P1] - PPR - modification appel BIFROST
	3315	[Controle Adresse] - livraison
	3316 	Masquer wording page listing promo
	3318	Accelerator : dur�e de session � �tendre
	3321	CMS - Pr�cision horaires Drive
	3322	Balisage SITEMAP
	MC - ajout onspecial comme filtre/rank/sort
	MC - ajout item par defaut
	fix valeurs par d�faut effectif et �tage
	fix export client donn�es manquantes
	fix arrondis (3 chiffres front pour parquet et controle passant lors de la soumission)
	fix erreur js page univers
	fix 404 sur mapping inexistant
	fix erreur recherche commande identifiant non num�rique
	search - exclusion des marques lors du stemming

version v1.2.00 (23/03/2016)
---------------
	1821	[Suivi de devis] - Anomalie graphique sur la zone magasin
	2885	Dans le message de confirmation de commande, j'ai null � la place de la date de disponibilit� de la commande
	3127	twitter : proposer un partage de type twitter cards
	3180	La recherche sur le mot "marquise" renvoie d�s la page 2 des produits incoh�rents
	3182	livraison - changer de magasin
	3189	Mail  confirmation cr�ation compte - liens KO
	3199	Navigation compte client - ajout d'un menu de navigation
	3210	La poubelle sur iphone de la page panier est difficile � cliquer
	3248	Evolution grille tarif Colissimo
	3249	[Cache Header IHS] - pas d'info cache dans les en tete HTTP
	3265	Am�lioration SEO : Ajouter dans la description des banni�res leurs tailles
	3269	[Transaction Mercanet] - le num�ro de commande transmis � Mercanet lors de la transaction est faux
	3270	suivi des devis - Probleme coh�rence prix devis / prix affich�
	3272	[Mise � jour Horaire magasin] - mise � jour impossible
	3274	[Flux Client JMS] - Donn�es manquantes
	3277	[Data layer] - price basket_products
	3278	[Paiement] - Le service de paiement est indisponible
	3279	[IDCRM] - IDCRM sett�e � 'undefined'
	3280	[Devis] - Suivi de devis non loggu� - affichage diff�rent de la r�ponse WS CRM
	3281	[Mercanet] - erreur configuration
	3285	Ajout T2Sell sur la page recherche
	3286	IE9 bouton OK effac� du sticky d'acceptation des conditions d'utilisation des cookies
	3287	[Visuel Principal] - Mobile - visuel principal produit ne s'affiche pas
	3300	CMS - pouvoir lancer une recherche d'article lors de l'ajout d'un contenu li�
	fix d'erreurs (cas magasin inconnu, search sliders/maxPageItems, searhc profileName incorrect)

version v1.1.01 (15/03/2016)
---------------
	3255	Desactiver les appels � GMap pour trouver les magasins les plus proches ... et fix nearestshop
	3256	accelerator - d�tail commande incomplet
	Retrait etage "aucun"


version v1.1.00 (10/03/2016)
---------------
	3177	Donn�es ouvertures exceptionnelles encore pr�sentes
	3179	G�n�ration du Flux produits Target2Sell
	3184	Newsletter - confirmation inscription - libelle Bouton
	3186	Partage : le partage google+ fait sortir du
	3187	Apres avoir �pingl� un contenu, on retourne sur pinterest et non sur le site Lapeyre.fr
	3189	Mail  confirmation cr�ation compte - liens KO
	3190	Suppression bouton annuler - changement de mot de passe.
	3201	La popin newsletter mobile n'est pas responsive - test� sur iPhone 5 et Nexus 5
	3204	La popin de transformation des listes d'achats mobile n'est pas responsive
	3206	Zone de reassurance absente sur la page livraison/retrait mobile et desktop
	3207	Magasin par d�faut - Wording � modifier
	3211	Le zoom mobile est plus petit que l'image principale. Il faut donc le supprimer
	3212	R�seaux sociaux en double sur fiche produit catalogue papier mobile
	3213	[Livraison] crash dans la page
	3214	Partage email KO  sur contenu �ditorial avec apostrophe dans le titre
	3215	EMail contact : le libell� des champs n'apparait pas dans l'email
	3217	Libell� vid�os fiche produit collection - orthographe
	3227	page panier sans totaux pour les commandes Mixtes
	3232	Les pdf interactifs des catalogues papiers ne s'affichent plus sur le front
	3233	Target2Sell -  changement ID
	3236	changement wording changement de mot de passe suite � un oubli
	3237	Probleme mails akio -  changement d'expediteur du mail
	3245	Accelerator : liste de commandes
	3248	Evolution grille tarif Colissimo
	fix client inconnu SV2 sur login
	fix arrondis lors de la soumission de la commande ("service paiement indisponible")
	fix Target2Sell (CDATA et produits manquants)

version v1.0.19 (03/03/2016)
---------------
	3071	Mail de confirmation de commande : wording � changer
	3116	Comparateur : lien dans le header
	3147	Android, Le bouton d'ajout au panier n'est pas assez visible sur les fiches produits - en attente WAX
	3151	les catalogues papiers ne sont plus accessibles et g�n�rent des pages 404
	3156	popin de connexion
	3167	wording fiche produit
	3174	Page Confirmation de commande - orthographe
	3175	[Login] - Acc�s page login depuis le conetnu editorial - 404
	Am�liorations Target2sell
	bascule live PROD

version v1.0.18 (01/03/2016)
---------------
	3090	Facette Prix : probleme borne inf�rieure
	3109	QW : page confirmation de commande
	3112	pas de message-mot de passe oubli�
	3114	[Facette] les facettes configur�es ne remontent pas en front
	3116	Comparateur : lien dans le header
	3117	cms repertoire cach�
	3120	creation de compte message d'erreur code postal
	3121	Bug lien Service client
	3122	supprimer la descente catalogue du footer
	3125	partage de fiche produit
	3130	il manque une majuscule au bouton "itin�raire"
	3132	store locator : suppression du picto drive
	3133	fiche magasin : Effacer les ouvertures exceptionnelles
	3134	fiche magasin sans avis
	3135	fiche magasin : impression
	3142	les facettes sont repli�es par d�faut sur la page resultat de recherche
	3143	Sur mobile, Les CGV n'apparaissent sur la page d'accueil
	3151	les catalogues papiers ne sont plus accessibles et g�n�rent des pages 404
	3161	Popin Magasins - Changement libell� + taille police 
	3162	Accelerator - probleme avec Impression d�tail commande
	Correction email contact
	R�tablissement cache search

version v1.0.17 (23/02/2016)
---------------
	3064	SEARCH : La recherche article doit pouvoir se faire pour les articles avec moins de 7 chiffres
	3065	imprimer la commande
	3066	Ajout du moyen de paiement sur email confirmation et page de confirmation
	3067	Confirmation de commande : ajouter le reste � payer et montant total commande
	3072	[Flux Google Shopping] - Le flux contient des produits non publi�
	3084	[Page newsletter] - Inscription - d�sinscription impossible
	3085	LISTE d'ACHATS : bouton retour inactif
	3090	Facette Prix : probleme borne inf�rieure
	3094	Header  - lien Newsletter - non actif sur Mac et GTAB
	3105	Suivi des commandes - Message aucune commande Web mal positionn�
	3106	Ajout Adresse - alignement champs sur Iphone 5S
	3107	Expiration de session taille Bouton Ignorer et Coninuer
	3108	Store locator - superposition info Google Map et infos Magasin. (Iphone 5S)
	3110	Search - r�sultat - prix - faire apparaitre le range
	3112	pas de message-mot de passe oubli�
	3113	Search : Ne plus tenir compte du b�n�fice client dans dans la recherche
	CMS : am�lioration page MEA
	Mise en place VIP CMS prod
	Init Export target2Sell


version v1.0.16 (18/02/2016)
---------------
	3002	[d�tail commande] - Affichage du reste � payer sur une commande termin�e
	3007	Il ne faut pas arrondir les unit�s de mesure pour le carrelage
	3045	Fiche Article (iphone 6)  - Lecture vid�o non possible
	3061	[Panier] -Carrelage - M2 arrondis
	3062	[Flux commande] - Arrondis carrelage conserv� dans le flux
	3072	[Flux Google Shopping] - Le flux contient des produits non publi�
	3074	Creation de compte - orthographe sur message erreur adresser
	3075	Fiche produit (mobile view) : probleme affiche sticky dispo
	3076	Menu mobile mon compte inaccessible -
	3077	Page identification (mobile view) - bouton se connecter semble gris�
	3079	Mobile view : Impssible d'ajouter en panier
	3080	(Mobile view) - Storelocator - Itin�raire - taille boutons
	3081	Store locator - choix magasin pr�f�r�
	3082	[Fiche produit standard] -  Overlap de "Description D�taill�e" sur la s�lection magasin
	3083	[Fiche produit standard] affichage Statut de stock disponible le
	3084	[Page newsletter] - Inscription - d�sinscription impossible
	3085	LISTE d'ACHATS : bouton retour inactif
	3088	Caroussel produit HP : 1 seul produit affich� au lieu de 4 (Safari)
	3091	Comparateur - mise en place du picto ajouter �  la liste d'achats
	3092	Suivi devis - orthographe
	3093	Page identification MAC - destructur�e
	3095	Page identification - affichage destructur� sous Galaxy Tab
	Bascule PPR en P1

version v1.0.15 (15/02/2016)
---------------
	2986	Refonte Liste Produits
	2996	iphone 5 passage en mode paysage
	3027	facette sur la cat�gorie
	3030	facette sur produit inconnue
	3037	renommage liste achat
	3039	probl�me avec effacer la s�lection
	3040	menu mobile - on ne peut le fermer
	3041	bouton fermer de la newsletter contient des ???
	3042	erreur liste achat
	3043	contenu liste achat - mobile affichage
	3044	bas de la liste d'achat - des radio buttons apparaissent
	3048	Changement texte - echec connexion compte client.
	3050	Search - probleme comptage de FPC
	3051	[Header] - liste des cat�gories limit�e � 10 items.
	3052	Orthographe sur Message de deconnexion compte client
	3053	Message erreur recherche devis positionn� trop bas
	3055	Orthographe - suivi de commande - Contr�le champ n� de commande
	3056	[Fiche produit] -Carrelage - M2 diff�rents entre calculateur et affichage de la valeur
	3057	[Fiche produit standard] -Webcombo - le select n'est pas enti�rement cliquable
	flux newsletter - Cabestan

version v1.0.14 (09/02/2016)
---------------
	2883	Les statuts des commandes magasin envoy�es � DECLIC sont tous � En cours
	3018	liste univers inactive
	3019	champs de mot de passe perdu trop petits
	3020	mise � jour donn�es provoque page blanche
	3021	message mon compte � revoir
	3023	creation de compte et melange de comtpes
	3026	le menu mobile disparait..
	3028	popin compte client - bouton mot de passe oubli� HS
	3029	popin compte client - se connecter provoque crash
	3036	Dans l'�cran d'inscription, mauvais affichage pour un pro du b�timent
	3038	Le bouton "Cr�er son compte" ne marche pas, ni dans la pop-up "Se connecter/s'inscrire", ni dans la fen�tre "Inscription"

version v1.0.13 (03/02/2016)
---------------
    2883    Les statuts des commandes magasin envoyes a DECLIC sont tous a En cours (cas Chantier programm� en attente de dev CRM )
    2909    Formulaire d'annulation commande pour un pro avec civilite MR/MME
    2955    Formulaire contact - Lettres possibles dans le Champ "No de document (commande, facture, devis, etc.) "
    2981    Refonte de la page LOGIN
    2982    Refonte Formulaire cr�ation de compte
	2983	Refonte Navigation contenu Editorial
    2984    Refonte du header - header light
    2985	Refonte StoreLocator
    2987    [page Paiement] - Encours - message d'erreur quand encours valable
    2989    Creation MEA Free HTML fiche produit Cuisine et bains
    2991	Suppression du - Lapeyre (dans les title)
    2993    Search - Facettes non filtrees
    2994	au retour de paiement (annul�), certains menus sont en anglais
	2995	compte client iphon - mauvais comportement
	2997	en iphone, l'url du bouton Accueil est faux
	2998	collections - probl�me d'alignement
	2999	calcul du total colisage
	3000	[Collection] - position texte Compotype invers�s
	3001	[Produit Standard] Dysfonctionnement refresh des visuels surlles changement de select
	3004	Questions sur les visuels
	3008	panier mobile - probl�me affichage �tat des stocks
	3009	mobile - ajout code avantage - pas de r�action
	3011	mobile - tunnel changement de magasin
	3013	[Fiche produit collection] - Premier swatch tronqu�

	2986 partiel : Refonte Liste Produits - Suppression de la QuickView

    QW33    Comparateur
    QW40    Affichage dispo panier
    CMS-BO	Nouvelle vue - liste des MEA positionnees par categorie
    Facettes categories : masquage des sous-categories soeurs sur selection
    Fix carousel articles


version v1.0.12.1 (20/01/2016)
---------------
	Fixes affichages des facettes (cat�gories, sliders, promotion)
	Fix design formulaire synchro

version v1.0.12 (13/01/2016)
---------------
	0316	[Contenu] - Dossier libell� du bouton
	0474	[Search contenus] - Anomalies graphiques sur l'onglet contenu
	1894	[Synchro CRM] - Le lien identifiez-vous ne renvoi pas sur la bonne page si le client est connect�
	1896	[Creation de compte] - Le lien identifiez-vous ne renvoi pas sur la bonne page si le client est connect�
	2108	[Livraison] - Adresse de livraison/facturation - Le pays n'est jamais affich� lorsqu'il est diff�rent de la France
	2931	Erreurs formulaire confirmation cr�ation de compte
	2945	l'id du magasin ne doit pas �tre affich� dans le mail
	2946	Les vignettes ne doivent pas �tre affich�es pour un produit de type catalogue papier
	2949	Mise � jour lien Inbenta
	2950	perte de la recherche dans la balise title si utilisation de l'autocompletion
	2951	perte d'information dans la popin panier
	2952	il ne doit pas y avoir de troncature sur le libell� du produit sur la page panier
	2957	Choix magasin de retrait
	2962	accelerator - client - onglet commandes magasin
	2968	[Meuble de collection] - vue liste affiche la collection, pas les meubles
	2970	[Order Status] - liste de commandes - statut termin� non pris en compte � l'affichage
	Facettes : sliders pour des champs num�riques hors prix
	Facettes : arborescence cat�gorie
	Swatch en liste d�roulante si possible

version v1.0.11 (16/12/2015)
---------------
	2596	MEA banniere - Rendu diff�rent si slide unique ou carrousel
	2773	Banni�re lien vers un produit (recherche)
	2875	Partage d'un produit via Pinterest
	2887	Pour la mise � jour du num TVA, pr�-rempli avec FR, tous les champs doivent �tre vid�s et re-renseign�s
	2907	Bouton "ajouter au panier" actif pour article disponible uniquement en magasin
	2932	[Maps API] - ModificationMethode d'authentification API for Work
	2933	[Fiche produit] - Libell� long non tronqu�/masqu� - Fierfox only
	2940	[Fiche produit standard] - suppression info bulle
	2941	La promo prix barr� n'est pas affich�e dans la fiche article
	2944	[CMS] NPE si on ne parvient pas � r�cup�rer les cat�gories
	Bascule des configurations de PROD
	gestion prix barres min/max


version v1.0.10 (07/12/2015)
---------------
	2097	[d�tail commande] La date de disponibilit� de la commande n'est jamais affich�e
	2883	Les statuts des commandes magasin envoy�es � DECLIC sont tous � En cours
	2902	Date de disponibilit� non affich�e pour un produit non en stock mais avec une date de r�appro
	2907	Bouton "ajouter au panier" actif pour article disponible uniquement en magasin
	2911	[meta ] - Robots en doublon
	2912	La civilit� n'est pas correctement affich� dans l'email
	2913	si le magasin n'a pas d'horaire drive alors ses horaires doivent �tre centr�s
	2916	[Canonical] - Suppression de la balise Canonique sur les familles, la recherche
	EVO 	affichage unite vente legale
	fix pinterest
	fix affichage de facettes
	Opitmisation statiques (minification et autres)

version v1.0.9 (23/11/2015)
---------------
	2884 Ecart de prix entre DECLIC et CRM sur un poste d'installation dans un devis
	
	email responsive
	partage pinterest
	Search : retablissement recherche "standard" (pas 4 caracteres min)
	Paiement : retour mercanet en https + annulation de commande sur echec de paiement
	statut SI indispo
	Imports produits : longueur champ accentu�s

version v1.0.8 (16/11/2015)
---------------
	2462	[Fiche magasin] - Envoi d'email
	2596	MEA banniere - Rendu diff�rent si slide unique ou carrousel
	2801	[Fiche magasin] - Envoi d'email
	2873	[Partage Facebook] - Quickview - pas de partage facebook
	2875	Partage d'un produit via Pinterest
	2879	[Fiche produit] - [INT2] affichage dispo stock absente


version v1.0.7 (09/11/2015)
---------------
	2820	Update Compte client  est possible sans le remplissage de tous les champs obligatoires
	2841	[Magasins pr�f�r�s] - detoppage magasin pr�f�r� -
	2781	[Catalogue] Le comparateur ne fonctionne pas sur GTAB
	2712	Bouton "Rechercher mon devis " est gris� 
	2866	Texte tronqu� dans la page d'identification
	2865	Identification d'un client sans devis et sans commande sur le site
	2864	Popin lors du click sur el bouton " Supprimer mon compte "
	2872	[Email] - mail de mot de passe oubli� - valeur du mot de passe syst�matiquement � {2}
	2475	Web Analytics : Ajout des rayons pour chaque produit dans le Data Layer
	JR52613 APAR IBM corrigeant un bug sur appels search

version v1.0.6 (02/11/2015)
---------------
	2723	Suivi de commande/ D�tail d'une commande -  Erreur chemin de fer
	2751	[Catalogue] - Nombre de produit dans le comparateur
	2773	Banni�re lien vers un produit (recherche)
	2794	Script GTM emp�che l'ajout au panier d'un catalogue papier
	2801	[Fiche magasin] - Envoi d'email
	2807	correction faute d'ortographe
	2812	modification compte client CRM - etage >11 mal int�gr�
	2835	Msg d Exception lors d'un creation de compte Via Synchro
	2840	[Desactivation client] - Pas de mise � jour CRM
	2844	[Compte client] - Compte PRO - Entit� juridique Administration

version v1.0.5 (26/10/2015)
---------------
	2665	[Redirection Mercanet] - Redirection automatique post paiement
	2678	Modification lien Menu Lapeyre Pro
	2723	Suivi de commande/ D�tail d'une commande -  Erreur chemin de fer
	2806	[creation de compte] - optin email, courrier
	2811	modification compte client - format t�l�phone mobile


version v1.0.4 (19/10/2015)
---------------
	0257	[Header] - Affichage du pr�nom et du nom d'un client professionnel
	1425	[Header panier] - Anomalie sur le nombre de produits au panier
	1528	[Fiche magasin] - La popin de partage ne se ferme pas lorsque l'on clique en dehors
	1789	[Suivi de devis] - Anomalie graphique sur la zone bouton de conversion
	1920	[Suivi de devis] - Anomalie sur la popin de conversion
	1921	[Suivi de devis] - Anomalie sur la popin de conversion
	1928	[Suivi de devis] - Anomalie sur la zone produit
	2097	[d�tail commande] La date de disponibilit� de la commande n'est jamais affich�e
	2469	Web Analytics : Variable transaction_store_id vide al�atoirement - Data Layer
	2540	Web Analytics : Variable transaction_store_id vide al�atoirement - Data Layer
	2598	Accelerator - Erreur sur tentative d'acc�s aux commandes magasins d'un client
	2759	Accelerator - Erreur sur tentative d'acc�s aux commandes magasins d'un client
	2767	(CMS Back offcie] Affichage diff�rent entre Desktop et mobile pour une MEA Carroussel
	2768	Recette Declic - L'environnement de recette n'est pas accessible
	2769	Pagination : pb de lien prev/next
	2775	[ Suivi de commande] - Suivi de devis
	2778	[Home et transverse] le panier est vide sans le "0" sur Ipad
	2788	[CMS Back office] Le MEA du mail de la r�servation du cr�neau drive ne s'affiche pas correctement sur les 2 Etape 1 et 2
	2800	Modification lien Menu Lapeyre Pro


version v1.0.3 (12/10/2015)
---------------
	Mise � jour produit IBM WCS 7.0.0.9 (ifixes) & WAS/IHS/Plugin (7.0.0.37 + fixes s�curit�)

	962	[Management center - preview] - L'identification est tr�s tr�s lente
	1476	[Store locator] - La page se recharge plusieurs fois
	2302	[Fiche magasin] - taille du champ adresse
	2359	[Search] - dysfonctionnement de la barre de recherche
	2390	Page d'ajout d'adresse de facturation sur Iphone 5
	2595	[Compte client] - La distance n'est pas affich�e sours le picto "y aller" du "Les Magasins Lapeyre les plus proches"
	2597	[Contact] - Erreur d'envoie du message contact
	2611	CMS : Interpr�tation du Javascript dans le WYSIWYG
	2612	Le picto de chargement n'est pas centr� dans l'�cran sur mobile Galaxy S4
	2616	[CMS] - Les saisies des calendrier et du bloc "Mot du directeur" sont impossibles sous IE
	2617	/DECLIC/Store Locator/declic-6156:Store Locator-101_Consulter le store Locator - Zone de magasin proche -  recherc-Chrom
	2624	[Mobile] Boutons sticky
	2670	Le panier ne se vide pas
	2680	[Creation de compte] - Champ telephone fixe devient tel pro
	2683	[Data layer] - data non renseign�e - transaction new customer
	2684	[Data layer] - data non renseign�e - transaction payment method
	2685	[Tunnel] - un message d'avertissement informe que le n� de t�l�phone est obligatoire mais le libell� ne porte pas d' "*"
	2688	[Tunnel] Le bouton "Chercher" dans la page retrait\livraison n'est pas correctement affich�e
	2694	CMS : la zone "Editer le contenu HTML" est vide
	2698	[Tunnel] - Le lien info moyen de paiement est manquant dans la page Paiement
	2699	[Tunnel] le libell� Confirmation n'est pas correctement positionn� sur la page de confirmation
	2723	...CLIC/Suivi de commande/declic-6323:Suivi Commande-_Ipad_3.3 Front-office : D�tail d'une commande -  Ex�cut� sur  ON (
	2726	Chargement codes postaux �les
	2730	Erreur suivi de devis
	2731	Web Analytics : Ajout des rayons pour chaque produit dans le Data Layer
	2733	[Tunnel] Affichage du moyen de paiement "en cours" pour un client pro sans encours
	2739	/DECLIC/Tunnel de commande/Tunnel de commande_3/declic-7595:TUNNEL-997_IPAD_6.1 Front-office : Page de paiement -  Execu
	2745	fiche magasin - il manque le picto drive � cot� des horaires
	2747	[Storelocator] Pas d'affichage de l'unit� m�tre pour un distance inf�rieure � 1000 m�tre
	2748	[CMS Back-office] Le lien contact n'est pas pr�sent sur le footer
	2749	[Fiche magasin] - taille du champ adresse
	2750	[Tunnel] Pas de remont�e de frais de livraison TRANSPORTEUR dans la page paiement
	2752	[Tunnel] Pas d'affichage des frais de colissimo pour un pro avec encours dans la page paiement

version v1.0.2 (05/10/2015)
---------------
	2049	[Livraison] - Anomalie zone adresse de livraison (ajout loader)
	2276	[TagManager] - Datalayer - variable � null
	2351	[compte client] - Connexion
	2385	[Tunnel] - La s�lection du magasin avec le code postal du magasin "Gournay" ne remonte pas sous IE11
	2389	[Tunnel] - le format de dates n'est pas correctement affich� dans la page retrait livraison
	2528	[Tunnel] - Le format de la date n'est pas conforme dans le message d'information (zone7)
	2532	Creation client PRO : La raison sociale redescend dans les champs 'contact' et 'nom g�rant'
	2629	Probl�me d'affichage Cf copie d'�cran
	2633	Espace client - Mes listes d'achats- champs non visible pour cr�er une liste d'achat
	2635	action sendmail publique en free HTML
	2636	Web Analytics : Absence marqueur GTM page oubli de mot de passe
	2643	[compte client] Anomalie graphique sur la page liste d'achats
	2644	Rechercher un devis non fonctionnel
	2657	[CMS Back-office] La saisie d'une date de fin de validatit� ant�rieure � la date de d�but de publication est possible
	2664	[Tunnel] IL manque un espace entre le mot "avantages" et "?" dans le bloc avantage de la page panier
	2674	[Contact & FAQ] la mention **Au moins un champ doit �tre renseign� est a supprimer des formulaires
	2675	[Contact & FAQ] la mention **Au moins un champ doit �tre renseign� est affich�e au dessus des mentions l�gales


version v1.0.1 (28/09/2015)
---------------
	1368	[Fiche Produit] Lors de la saisit d'une surface avec un nombre � virgule, une erreur NAN apparait
	1622	[Suivi de commande] - Anomalie graphique sur r�sultat de recherche
	2055	[Retrait] - Anomalie zone adresse de facturation
	2060	[Paiement] - Anomalie graphique zone haute
	2061	[Paiement] - Anomalie graphique zone haute
	2276	[TagManager] - Datalayer - variable � null
	2277	[TagManager] - Datalayer - esapce dans les declaration de variables
	2278	[TagManager] - Datalayer - format de prix transaction
	2279	[TagManager] - Datalayer - format de prix panier
	2280	[TagManager] - Datalayer - valeur � 0 et negative
	2339	[Tunnel] - Pas de message d'erreur pour la recherche d'un code postal INCONNU dans l'onglet Drive de la page Livraison\Retrait
	2349	[Tunnel] - Le bouton "Pr�c�dent" n'est pas gris� en page 1 du bloc drive
	2364	Fonction + et - non fonctionnelles sur la page panier
	2382	[StoreLocator] - Pas de remont�es des "magasins les pluse proches" dans le storelocatore avec IE11
	2389	[Tunnel] - le format de dates n'est pas correctement affich� dans la page retrait livraison
	2415	[contact/FAQ] - probleme d'affichage
	2488	[Suivi Commande] - Statut erron� - commande termin�e au lieu de disponible
	2528	[Tunnel] - Le format de la date n'est pas conforme dans le message d'information (zone7)
	2529	Cr�ation de compte : libell� "les champs marqu�s d''une * sont obligatoires"
	2532	Creation client PRO : La raison sociale redescend dans les champs 'contact' et 'nom g�rant'
	2533	Modification compte client :, la date de naissance devient obligatoire.
	2537	Web Analytics : Pb acc�s donn�es variables basket_total et transactionTotal - Data Layer
	2538	Web Analytics :
	2539	Web Analytics : Renseigner la variable env_template page Comparateur - Data Layer
	2541	Web Analytics : Limitation 3 produits dans le panier - Data Layer
	2569	[Store locator] - Affichage des magasins � plus 150 de l'adresse principale
	2574	[Flux client] - Segment Magasin pr�fer� du client absent
	2580	[tunnel commande] ajout d'une adresse de livraison - donn�es erron�es
	2589	[Catalogue] - affichage ipad
	2593	Mail de validation de commande  erreur
	2599	/DECLIC/Aide - Contact - Emails v3/declic-5132:Contacts Emails-61_7.2 Front-office - Liste des formulaires+7.2.3 Front-o
	2601	[Facette contenu editorial] - Facette Field1 absente du front
	2602	[Contact] - le champ de saisie ne fonctionne pas


version v1.0.0 (22/09/2015)
---------------
	0337	[Fiche Produit] Le fil d'ariane sur la fiche produit n'est pas bon apr�s avoir effectu� une recherche
	0481	[Famille] lorsqu'on arrive sur la fiche produit en provenance du comparateur, le fil d'ariane n'est pas bon
	0614	[Fiche produit] Le fil d'Ariane n'est pas bon lorsqu'on acc�de � un produit via un espot de produit
	0766	[Fiche Produit] En provenance de la page des promotions, le fil d'ariane de la fiche produit n'est pas le bon
	0836	[Fiche produit sur mesure] La zone de prix et la zone d'en dessous ne sont pas conforme aux maquettes.
	1299	[Fiche Produit] Le dernier �l�ment du fil d'Ariane doit �tre le nom du produit sur lequel on est.
	1622	[Suivi de commande] - Anomalie graphique sur r�sultat de recherche
	1954	[Retrait] - CRM - La zone civilit� ne doit proposer que les valeurs : M. et Mme
	2302	[CMS] longueur des champs adresse
	2357	Calendrier Drive sur 3 jours
	2368	Affichage du cr�neau drive non conforme sur Iphone
	2393	Param�tres d'adresse manquant dans l'export cde WCS
	2398	Suivi de Commande avec Compte Client Pro
	2399	[TagManager] - Datalayer - Arbo produit absente du datalayer en acc�s direct � la fiche produit
	2420	[SEO] - Canonical Pages magasins
	2436	EC59 : uniformisation du fil d'ariane
	2437	EC53 : URL produit dans les vues grille et liste
	2453	[CMS] EC89 : affichage du nom physique de l'image en plus du ALT dans l'arborescence media
	2454	[Compte Client] - Pas de remont�e dela commande magasin apr�s synchronisation
	2480	Article - r�gression sur la pagination
	2488	[Suivi Commande] - Statut erron� - commande termin�e au lieu de disponible
	2489	[Suivi de commande] - Le statut de la commande magasin est "Termin�"
	2496	SITEMAP : Am�liorations
	2498	[SEO] - T�l�chargement fichier sitemap catalogue KO
	2503	[Declic - Jeux de donn�e] - Importation du fichier CSV pour Google place
	2508	[Suivi de commande] - La commande magasin ne peut pas atteindre le statut "Exp�di� le" 
	2510	[SEO] - Canonical Pages CMS
	2512	[CMS Front ] - texte fonctionnel - Recommender cet article
	2514	Ajout d'adresse de livraison non fonctionnel
	2518	[Compte client] - Formulaire de mise � jour donn�es compte PART  - Champ civilit�
	2523	MEA carrousel - Un bouton vide s'affiche si on ne renseigne rien dans le champ
	2524	MEA carrousel - Un aplat gris s'affiche si on ne renseigne rien dans le champ accroche
	2527	[Lapeyre] - L'intitul� "Les plus proche" n'est pas conforme
	2530	Creation compte client- remplacer bouton continuer mes achats par enregistrer
	2534	Modification compte clien PART : les valeurs civilit� autres que Monsieur et Madame sont possibles
	2535	Probleme de montant sur la page mode de paiement
	2550	[Catalogue] - Le bouton "Ajouter � ma liste d'achat" est pr�sent pour un catalogue papier dans le comparateur
	2556	[Catalogue] - Pop-up video YouTube
	EC86	corrections colisage
	EVOL	Suivi commande back office : detail de commande - affichage d'informations compl�mentaires livraison et paiement
	EVOL	Suivi commande back office : liste des commandes magasins d'un client - affichage d'informations compl�mentaires (magasin)
	EVOL	[CMS] banni�res (ajout des dates de validit�)
	FIXS	[CMS] url images contrib front (sitemap)
	FIXS	[CMS] horaires : contr�le format heure/minute

version v0.1.31 (15/09/2015)
---------------
	0836	[Fiche produit sur mesure] La zone de prix et la zone d'en dessous ne sont pas conforme aux maquettes.
	1745	[Suivi de devis] - Anomalie graphique libell�
	1898	[Retrait Drive] - Anomalies graphiques zone de recherche de magasin (ancre en cas d'erreur)
	1954	[Retrait] - CRM - La zone civilit� ne doit proposer que les valeurs : M. et Mme
	2270	Synchro CRM client - remont� info adresses depuis la CRM KO
	2281	[TagManager] - Datalayer - numero client CRM fix� � 2
	2315	Non affichage du message de confirmation d'envoi du mot de passe
	2337	[Tunnel] - Le pictogramme "Horaires" du magasin par d�faut dans l'onglet "Retrait en magasin" est pr�sent
	2352	[Tunnel] - Le bouton "Valider mes choix" n'est pas gris� avec aucun cr�neau drive s�l�ctionn�
	2380	Affichage des  cr�neaux horaires sous la forme  HH/MM  dans l'onglet Drive
	2391	Formulaire d'adresse du Iphone non conforme
	2397	Error Message / Commande Annul� + Mauvais Magasin selectionn�
	2410	[Contact & FAQ] Les champs du formulaire "Valider votre commande internet" ne sont pas pr�remplis avec le compte logu�
	2413	Pb d 'affichage Texte Mandatory Fields
	2415	[contact/FAQ] - probleme d'affichage
	2420	[SEO] - Canonical Pages magasins
	2421	[SEO] - Canonical Pages CMS
	2422	[Tunnel] - Le montant de l'acompte est affcih� dans le r�cap panier de la page "Retrait\livraion"
	2451	[Compte client] - La balises sont pr�sentes dans le messge d'avertissement qu'un mail est d�j� connu apr�s synchronisation
	2452	EC93 : rendre les liens de pagination accessible sur les pages cat�gories
	2458	[Compte client] - L'intitul� "liste d'achat" est pr�sent � la place de "Mes listes d'achat dans le header de l'espace client
	2459	[Compte client] - La MEA de la page de confiirmation de compte n'est pas correctement affcih�e
	2477	Erreur sur l'export wishlist
	2481	Absence de la balise H1 sur le titre Aide/FAQ
	EC86_colisage 
	logon : log si inconnu du crm
	fix import tarif (offerprice double)
	optimisations (search + wishlist)
	mea banniere si pas de banniere

version v0.1.30 (07/09/2015)
---------------
	Evolution compte client
	Evolution gestion du colisage
	1626	[Cr�ation de compte] La liste d�roulante concernant la civilit� du formulaire de cr�ation de compte n'est pas conforme
	1651	[Synchro CRM] - popin confirmation : Anomalie graphique zone texte
	1798	[contact] clic sur logo du mail re�u suite � la saisie du formulaire "suivre votre commande internet" renvoie sur page blanche
	1861	[Suivi de devis] - Anomalie graphique sur la popin de transformation
	1954	[Retrait] - CRM - La zone civilit� ne doit proposer que les valeurs : M. et Mme
	2016	[compte client] le message de confirmation d'envoi de mail lors de la saisie du formulaire ne s'affiche pas via une popin
	2158	[SEO] - Balise HX - Univers
	2161	[SEO] - Balise HX - Sous-famille
	2177	[SEO] - Balise HX - Famille
	2243	[SITEMAP] Le sitemap CMS g�n�r� ne respecte pas le format attendu
	2302	[Fiche magasin] - taille du champ adresse
	2383	[CMS] - Impossible de D�publier un contenu avec le profil "publieur"
	2392	[Tunnel] - La MEA ne s'affiche pas dans la page de confirmation d'une commande
	2396	[Flux Client] - Client Pro - balises vides


version v0.1.29 (31/08/2015)
---------------
	547	[Comparateur] La zone de produit n'est pas centr� par rapport au titre
	724	[Home page] - Anomalies graphiques sur un widget
	727	[Home page] - Widget s�lection du mois anomalies graphiques
	1238	[Search produit] - Lorsque je souhaites ajouter un produit � la liste d'achats, la page se "casse" dans certains cas
	1355	[Panier] - Anomalies graphiques zone �co-part
	1394	[Panier] -  libell�  ( bouton "continuer mes achats" ) � mettre en minuscule
	1527	[Fiche produit standard] - Anomalies graphiques zone mes options
	1615	[Suivi de commande] - Anomalie graphique zone du bas
	1619	[Suivi de commande] - Anomalie graphique sur r�sultat de recherche
	1622	[Suivi de commande] - Anomalie graphique sur r�sultat de recherche
	1672	[Suivi de commande] - Anomalie graphique en �tant logu� en part zone menu
	1757	[Retrait] - Anomalie graphique zone recap panier
	1759	[Retrait] - Anomalie graphique zone dispo commande
	1760	[Retrait] - Anomalie graphique zone dispo commande
	1979	[Livraison] - Anomalie graphique zone adresse de facturation
	2043	[Confirmation] - Anomalie graphique
	2155	[SEO] - Balise HX - Homepage
	2158	[SEO] - Balise HX - Univers
	2159	[SEO] - Balise HX - Store locator
	2161	[SEO] - Balise HX - Sous-famille
	2163	[SEO] - Balise HX - Search produit
	2165	[SEO] - Balise HX - Liste de meubles
	2167	[SEO] - Balise HX - Home du mag
	2170	[SEO] - Balise HX - Home du mag
	2172	[SEO] - Balise HX - Fiche produit sur mesure
	2174	[SEO] - Balise HX - Fiche produit standard
	2175	[SEO] - Balise HX - Fiche magasin
	2177	[SEO] - Balise HX - Famille
	2183	[SEO] - Balise HX - Contact webmaster
	2184	[SEO] - Balise HX - Contact webmaster
	2186	[SEO] - Balise HX - Comparateur
	2188	[SEO] - Balise HX - Collection
	2190	[SEO] - Balise HX - Catalogue papier
	2191	[SEO] - Balise HX - Article
	2192	[SEO] - Balise HX - Article
	2193	[SEO] - Balise HX - Article
	2194	[SEO] - Balise HX - Article
	2195	[SEO] - Balise HX - Article
	2251	[SEO] Fichier Robot.txt absent
	2289	Marqueur GTM manquant
	2350	[ Tunnel ] - page confirmation
	2356	[Catalogue] - Erreur d'affichage produit en stock
	2365	compte existe d�j� - le message contient du code html
	2366	[Tunnel] - La r�f�rence de l'article n'est pas affich�e dans le r�cap panier
	2372	[Tunnel] - retrait/livraison
	2386	[Tunnel] - La TVA de 20% est affich�e pour un client professionnel
	Google Shopping
	fix tunnel pour l'article catalogue papier


version v0.1.28 (24/08/2015)
---------------
	 801	[Fiche magasin] - Arrondi des notes
	 836	[Fiche produit sur mesure] La zone de prix et la zone d'en dessous ne sont pas conforme aux maquettes.
	1322	[Panier] - Anomalies graphiques sur les lignes produit
	1328	[Panier] - Anomalies graphiques sur le header du panier
	1449 	[Search contenu] - La recherche est stricte
	2301	[R�f�rentiel] - Mise � jour de la grille Colissimo expert
	2327 	Paiement par traite - incoh�rence des montants
	2331	[compte client] - creation compte client Impossible
	2336	[tunnel] - ajout d'une adresse de facturation
	2338 	[Formulaire de contact] - le formulaire ne semble pas �tre envoy�
	2343	[gestion colissimo] - articles 0704290 et 0591150 topp�s colissimo mais information non retransmise
	gestion du callback Mercanet
	optimisation des quotas Google
	CMS : Hot fix boucle infinie dans la r�cup�ration des horaires drive
	images sitemap
	bug init liste des magasins 

P1 - XCanal
	2255	envoi mail statut SAP  DISP - [Suivi commande] - le statut DISP n'est pas int�gr�
	

version v0.1.27 (18/08/2015)
---------------
	1286	[Header Panier] - Anomalies graphiques sur l'aper�u du panier
	1359	[Identification] - Positionnement Message d'erreur suite � un e-mail non reconnu
	1572	[Search produit] - En mode liste l'application de swatch ne met pas � jour le visuel du produit
	1740	[Panier] - Anomalie sur l'ajout de quantit� d'un produit
	1741	[Retrait] - Le bloc magasin doit devenir rouge au survol de de la souris
	1745	[Suivi de devis] - Anomalie graphique libell�
	1829	[Mode de paiement] - Le montant de l'acompte et du reste � payer doit toujours �tre affich�
	1836	[Mode de paiement] - La popin du paiement par carte n'a pas le rendu attendu
	1844	[Contact] Erreur g�n�rique lorsque la liste des magasins n'est pas renseign� dans le formulaire "Proposer un partenariat"
	1845	[Contact] Aucune d'erreur lorsque le jour de date de cr�ation n'est pas renseign� dans le formulaire "Proposer un partenariat"
	1846	[Contact] Aucune erreur lorsque le mois de date de cr�ation n'est pas renseign� dans le formulaire "Proposer un partenariat"
	1847	[Contact] Aucune erreur lorsque l'ann�e de date de cr�ation n'est pas renseign� dans le formulaire "Proposer un partenariat"
	1848	[Contact] Aucune erreur lorsque le jour de date d'�ch�ance n'est pas renseign� dans le formulaire "Proposer un partenariat"
	1849	[Contact] Aucune erreur lorsque le mois de date d'�ch�ance n'est pas renseign� dans le formulaire "Proposer un partenariat"
	1850	[Contact] Aucune erreur lorsque l'ann�e de date d'�ch�ance n'est pas renseign� dans le formulaire "Proposer un partenariat"
	1851	[Contact] Aucune erreur lorsque le domaine de comp�tence n'est pas renseign� dans le formulaire "Proposer un partenariat"
	1853	[Contact] erreur lorsque le num�ro de t�l�phone portable n'est pas renseign� dans le formulaire "Proposer un partenariat"
	1947	[Retrait] - Anomalie graphique zone adresse facturation (hover rouge)
	2009	[compte client] le message de confirmation d'envoi de mail lors de la saisie du formulaire ne s'affiche pas via une popin
	2013	[compte client] le message de confirmation d'envoi de mail lors de la saisie du formulaire ne s'affiche pas via une popin
	2016	[compte client] le message de confirmation d'envoi de mail lors de la saisie du formulaire ne s'affiche pas via une popin
	2022	[compte client] le message de confirmation d'envoi de mail lors de la saisie du formulaire ne s'affiche pas via une popin
	2052	[Livraison] - Anomalie zone adresse de livraison
	2055	[Retrait] - Anomalie zone adresse de facturation
	2092	[d�tail commande] connect� en tant que Pro, le montant total HT n'est pas bien calcul� dans le d�tail de la commande
	2110	[TUNNEL, WISHLIST, COMMANDE, DEVIS, MAILS] Gestion des prix
	2255	[Suivi commande] - le statut DISP n'est pas int�gr�
	2267	[Commande] L'adresse de livraison ajout�e lors de la cr�ation de commande n'est pas prise en compte
	2275	[Commande] Les prix ne sont pas align�s avec les intitul�s dans la commande
	2282	[Retrait Drive] - Anomalies graphiques zone de recherche de magasin
	2309	[ Tunnel ] - affichage creneau 5.1.1.3

P1 - XCanal
	2255	[Suivi commande] - le statut DISP n'est pas int�gr�
	2267	[Commande] L'adresse de livraison ajout�e lors de la cr�ation de commande n'est pas prise en compte

version v0.1.26 (10/08/2015)
---------------
	875		[Aide/FAQ] - La partie aide/faq n'est pas responsive
	1040	[Fiche Produit] - popin de remplacement produit - La popin indiquant que le produit r�f�renc� est remplac� ne s'affiche pas
	1058	[Produit de substitution] la popin qui s'affiche ne correspond pas � la maquette
	1322	[Panier] - Anomalies graphiques sur les lignes produit
	1324	[Panier] - Le prix barr� n'est pas affich� dans le total par ligne
	1437	[QuickView] La quickView n'est pas conforme aux maquettes
	1484	[Gestion Coupon] - Coupon non affich� dans le suivi de commande
	1566	Flux client WCS > CRM > Flag Stop t�l�phone � 1 par defaut
	1685	[mail de confirmation de commande] Des points interrogation(???) sont affich�s � la fin du champ N� Voie � tort
	1726	[Interface client WCS -> EAI] gestion des adresses
	1770	[d�tail commande] L'eco participation n'est pas repris dans le detail de la commande
	1772	[d�tail commande] connect� en tant que Pro, le montant totale de la commande n'est pas suivi du sigle HT
	1773	[Interface client WCS-EAI] - update client - info codeAPESecondaire � ne pas renvoyer
	1811    [contact] Les libell�s des champs faisant partie de l'email ne sont pas en gras	
	1812    [contact] Dans le mail de contact, le libelle "Num�ro de document (facture, devis etc)" est coll� � la valeur du champ	
	1830	[Mode de paiement] - Les CGV ne s'affichent pas au clique sur le libell�
	1844	[Contact] Erreur g�n�rique lorsque la liste des magasins n'est pas renseign� dans le formulaire "Proposer un partenariat"
	1852	[Contact] Aucun email n'est envoy� lors de la saisie de tous les champs obligatoire dans le formulaire "Proposer un partenariat"
	1854	[Contact] erreur lorsque le num�ro de t�l�phone professionnel n'est pas renseign� dans le formulaire "Proposer un partenariat"
	1966	[Fiche article] - affichage disponibilit� de stock
	2053	[Livraison] - Anomalie zone adresse de livraison
	2054	[Paiement] - Anomalie zone recap panier
	2087	[Paiement] - Le coupon n'apparait pas sur le recap panier
	2088	[Panier] - Les totaux du panier d'un pro sont faux
	2089	[Retrait] - L'application d'un coupon rate_item supprime les totaux
	2092	[d�tail commande] connect� en tant que Pro, le montant total HT n'est pas bien calcul� dans le d�tail de la commande
	2095	[d�tail commande] Le montant TTC est bizarrement inf�rieur au montant HT
	2149	[Mode de paiement] - Le suppl�ment �tage ne doit pas �tre mutualis� avec les frais de livraison
	2205	[SEO] - Microdonn�es sur la fiche produit catalogue(SKU)
	2250	[DRIVE] La page de reservation du cr�neau Drive n'est accessible qu'en mode logg� sur PPR
	2252	[d�tail commande] - erreur de valorisation de TVA
    2259    [CMS] - Le dossier emplacement emp�che l'acc�s aux articles
    2264	[CMS] - Services dans les fiches magasins
	2269	Paiement d'une commande par CB en mode Livraison
	2270	Synchro CRM client - remont� info adresses depuis la CRM KO
	2272	[Panier] Impossible de saisir la quantit� d'un article dans un panier
	2274	R�sidus de coupon dans une commane
	2285	[Search] - Caract�re interdit
	2286	[Header]- Cat�gorie absentes du menu catalogue
	2295	[Compte client] - Formulaire de synchro pro - SIRET pr� rempli

version v0.1.25 (03/08/2015)
---------------
	2256	[MEA Vignette] Lien vers un dossier
	2242	[SITEMAP] Erreur � la g�n�ration du sitemap wcs
	1503	[BO CMS] - Validation d'un article valid� avec le profil publieur
	562		[Contenu �ditorial] - Le carrousel de produits ne s'affiche pas sur les produits li�s
	1856	[Confirmation de creation de compte] - La page n'est jamais affich�e
	1606	[Suivi de commande] - La recherche ne renvoie pas la date de la commande
	2103	[compte client] transformation d'un client part en pro - aucune popin de confirmation ne s'affiche attestant le bon d�roul�
	2101	[detail commande] aucune popin de confirmation lors du clic sur le bouton �pingler de la zone de magasin
	2102	[compte client] lors de la modification d'information d'un compte pro aucune popin  de confirmation ne s'affiche
	1736	[mes adresses] La page mes adresses n'est pas conforme � la maquette - pas de picto de suppression d'adresse principale
	2254	[Compte client] - Pas d'affichage du champ "Nom de l'adresse" pour une adresse principale
	2249	[CONTACT] Soumission du formulaire en AJAX
	2257	[DRIVE] A la validatio du cr�neau Drive, on a une erreur g�n�rique
	2259	[CMS] - Le dossier emplacement emp�che l'acc�s aux articles
	2250	[DRIVE] La page de reservation du cr�neau Drive n'est accessible qu'en mode logg� sur PPR
	1096	[Auto-compl�tion] - Les caract�res accentu�s ne sont pas g�r�s
	1362	[Retrait/Livraison] - Les onglets ne sont pas conformes � la maquette
	2239	[Panier] - Champ quantit� : affichage des quantit�s sup�rieures � 3 digit tronqu�es
	1269	[Impossible de se connecter] - Message navigateur affich� de mani�re al�atoire
	2244	[LIVRAISON] Eligibilit� Colissimo
	2096	[d�tail commande] la liste des attributs de d�finition avec leur valeur n'est pas affich� dans le cas d'un produit standard
	1930	[Retrait] - Lenteur importante pour la s�lection d'un magasin
	1957	[Livraison] - le client part2 est envoy� sur le mauvais onglet suite � une modification d'adresse de livraison + lenteur
	1931	[Retrait] - Lenteur importante pour l'ouverture de la popin adresse
	2091	[d�tail commande] La tva n'est pas reprise dans le d�tail de la commande
	1873	[Retrait Drive] - Anomalies graphiques zone cr�neau drive
	2100	[d�tail commande] le clic sur le pictogramme "�pingler" rend anormalement long l'ajout du magasin dans les magasins pr�f�r�s
	2055	[Retrait] - Anomalie zone adresse de facturation
	2093	[d�tail commande] connect� en tant que Pro, le montant total TVA n'est pas bien calcul�
	1827	[Livraison] - La modification du pays d'une adresse envoi le client sur l'onglet retrait
	1828	[Livraison] - La s�lection d'une adresse renvoi sur l'onglet retrait avant de revenir sur l'onglet livraison
	2236	Affichage TVA Tunnel - Taux � 25%
	1844	[Contact] Erreur g�n�rique lorsque la liste des magasins n'est pas renseign� dans le formulaire "Proposer un partenariat"
	2016	[compte client] le message de confirmation d'envoi de mail lors de la saisie du formulaire ne s'affiche pas via une popin
	2002	[compte client] le message de confirmation d'envoi de mail lors de la saisie du formulaire ne s'affiche pas via une popin
	2022	[compte client] le message de confirmation d'envoi de mail lors de la saisie du formulaire  ne s'affiche pas via une popin
	2009	[compte client] le message de confirmation d'envoi de mail lors de la saisie du formulaire ne s'affiche pas via une popin
	2013	[compte client] le message de confirmation d'envoi de mail lors de la saisie du formulaire ne s'affiche pas via une popin
	2216	[SEO] - Microdonn�es sur la fiche produit collection (Offerdetails)
	1811	[contact] Les libell�s des champs faisant partie de l'email ne sont pas en gras
	2225	[SEO] - Microdonn�es sur la fiche produit standard (Offerdetails)
	2205	[SEO] - Microdonn�es sur la fiche produit catalogue(SKU)
	2210	[SEO] - Microdonn�es sur la fiche produit collection(SKU)
	2218	[SEO] - Microdonn�es sur la fiche produit standard (SKU)
	2226	[SEO] - Microdonn�es sur la fiche produit sur mesure(SKU)
	2207	[SEO] - Microdonn�es sur la fiche produit catalogue (price)
	2212	[SEO] - Microdonn�es sur la fiche produit collection (price)
	2219	[SEO] - Microdonn�es sur la fiche produit standard (price)
	2220	[SEO] - Type de Microdonn�es sur la fiche produit standard
	2228	[SEO] - Microdonn�es sur la fiche produit sur mesure (price)
	2209	[SEO] - Microdonn�es sur la fiche produit catalogue (currency)
	2208	[SEO] - Microdonn�es sur la fiche produit catalogue (availability)
	2215	[SEO] - Microdonn�es sur la fiche produit collection (currency)
	2221	[SEO] - Microdonn�es sur la fiche produit standard (currency)
	2229	[SEO] - Microdonn�es sur la fiche produit sur mesure sans prix (price)
	2213	[SEO] - Microdonn�es sur la fiche produit collection sans prix (price)
	2231	[SEO] - Microdonn�es sur la fiche produit sur mesure (currency)
	2222	[SEO] - Microdonn�es sur la fiche produit standard (availability)
	2234	[SEO] - Microdonn�es sur la fiche produit sur mesure (Offerdetails)
	2217	[SEO] - Microdonn�es sur la fiche produit collection (vid�o)
	2105	[compte client] Lors de la cr�ation d'une adresse, apr�s validation, l'utilisateur n'est pas redirig� vers le carnet d'adresse
	2214	[SEO] - Microdonn�es sur la fiche produit collection (availability)
	2106	[compte client] Lors de la modification d'une adresse, apr�s validation, l'utilisateur n'est pas redirig� vers le carnet d'adres
	2084	[Panier] - L'avertissement d'un coupon non appliquable n'est pas lisible
	2098	[d�tail commande] Le Mode de livraison "Livraison � domicile" n'est jamais repris ou affich�
	2104	[compte client] L'utilisateur mineure a la possibilit� de cr�er un compte client
	1932	[Retrait] - Anomalie popin adresse
	1812	[contact] Dans le mail de contact, le libelle "Num�ro de document (facture, devis etc)" est coll� � la valeur du champ
	1852	[Contact] Aucun email n'est envoy� lors de la saisie de tous les champs obligatoire dans le formulaire "Proposer un partenariat"
	1162	[Mega menu] - Un d�lai compris entre 0,5 et 1 seconde doit �tre ajout� avant affichage du m�ga menu
	1160	[Home page] - R�gression sur l'affichage des MEA banni�re
	1285	[Header Panier] - Il est impossible d'acc�der � la page panier � partir de 4 produits s�lectionn�s
	1020	[Search contenus] - R�gression sur le bouton suivant
	908		[Page Famille] - Mobile: probl�me lors du clic sur les boutons de pagination
	1590	[Search produit] - Comportement de la pagination diff�rent sur mobile
	293		[QuickView] Redirection mauvaise lors de l'ajout � la liste d'achat pour un utilisateur non identifi�
	237		[mode de vue] Le mode de vue (grille/liste) doit s'appliquer sur toutes familles et ce pour une m�me session
	236		[R�gle de tri] les r�gles de tri doivent s'appliquer sur toutes les familles et ce pour une m�me session
	1958	[Livraison] - Ouverture popin modification d'une adresse de facturation
	1238	[Search produit] - Lorsque je souhaites ajouter un produit � la liste d'achats, la page se "casse" dans certains cas
	1236	[Famille] - Le bouton d'ajout � la liste d'achat ne fonctionne plus dans certains cas en mode liste et en mode grille
	2240	[ACCELERATOR] afficher le n� commande magasin et le statut SI
	220		[page univers] Au survol de la souris sur le visuel d'une famille le titre de la famille n'est pas surlign�	
		


version v0.1.24
---------------

	2081	[Panier] - Le bouton de validation du panier fonctionne alors qu'il est gris�
	1967	[Retrait] - La s�lection de cr�neau drive ne s'affiche plus
	2150	[HEADER] Liens QuickLinks Suivi devis et Suivi commande KO si logg�
	2052	[Livraison] - Anomalie zone adresse de livraison
	2144	[liste d'achat] Lors de la conversion de la liste d'achat en panier, le visuel du produit non achetable ne s'affiche pas
	1937	[Livraison] gestion des messages d'erreur
	2203	[SEO] - Type de Microdonn�es sur une fiche magasin (tel)
	2202	[SEO] - Type de Microdonn�es sur une fiche magasin (name)
	2199	[SEO] - Microdonn�es sur un dossier (breadcrumb)
	2196	[SEO] - Microdonn�es sur un article (breadcrumb)
	2204	[SEO] - Type de Microdonn�es sur une fiche magasin (Review-aggregate)
	2201	[SEO] - Microdonn�es sur une fiche magasin (breadcrumb)
	2232	[SEO] - Microdonn�es sur la fiche produit sur mesure (article)
	2224	[SEO] - Microdonn�es sur la fiche produit standard (article)
	2233	[SEO] - Microdonn�es sur la fiche produit sur mesure (article)
	2223	[SEO] - Microdonn�es sur la fiche produit standard (article)
	2180	[SEO] - Balise H1 - Contact
	2153	[SEO] - Balise HX - Homepage
	2176	[SEO] - Balise HX - Famille
	2173	[SEO] - Balise HX - Fiche produit standard
	2183	[SEO] - Balise HX - Contact webmaster
	2151	[SEO] - Balise H1 - Homepage
	2182	[SEO] - Balise H1 - Contact webmaster
	2160	[SEO] - Balise HX - Sous-famille
	2162	[SEO] - Balise HX - Search produit
	2154	[SEO] - Balise HX - Homepage
	2164	[SEO] - Balise HX - Liste de meubles
	2152	[SEO] - Balise HX - Homepage
	2169	[SEO] - Balise HX - Home du mag
	2166	[SEO] - Balise HX - Liste de meubles
	2189	[SEO] - Balise HX - Catalogue papier
	2171	[SEO] - Balise HX - Fiche produit sur mesure
	2187	[SEO] - Balise HX - Collection
	2185	[SEO] - Balise H1 - Comparateur
	2077	[Paiement] - Anomalie graphique zone magasin
	2076	[Paiement] - Anomalie graphique zone haute
	2074	[Paiement] - Anomalie graphique zone haute
	2073	[Paiement] - Anomalie graphique zone haute
	2072	[Paiement] - Anomalie graphique zone haute
	2071	[Paiement] - Anomalie graphique zone haute
	2070	[Paiement] - Anomalie graphique zone haute
	2069	[Paiement] - Anomalie graphique zone haute
	2067	[Paiement] - Anomalie graphique zone haute
	2068	[Paiement] - Anomalie graphique zone haute
	2066	[Paiement] - Anomalie graphique zone haute
	2065	[Paiement] - Anomalie graphique zone haute
	2064	[Paiement] - Anomalie graphique zone haute
	2063	[Paiement] - Anomalie graphique zone haute
	2061	[Paiement] - Anomalie graphique zone haute
	2060	[Paiement] - Anomalie graphique zone haute
	2059	[Paiement] - Anomalie graphique zone haute
	2058	[Paiement] - Anomalie graphique zone haute
	2046	[Confirmation] - Anomalie graphique
	2045	[Confirmation] - Anomalie graphique
	2178	[SEO] - Balise H1 - Dossier
	2099	[d�tail commande] Au clic sur le pictogramme  "y aller" de la zone d'info de magasin aucun �venement ne se produit
	2094	[d�tail commande] dans la partie magasin du d�tail de la commande, les pictos �pingl�s et "y aller" sont d�cal�s vers le bas
	2012	[SEO] - Sous-famille meta index,follow
	2008	[SEO] - Univers meta index,follow
	2015	[SEO] - Fiche produit standard meta index,follow
	2010	[SEO] - Famille meta index,follow
	2018	[SEO] - Fiche produit collection meta index,follow
	2017	[SEO] - Fiche produit sur mesure meta index,follow
	2021	[SEO] - Liste de meubles meta index,follow
	2019	[SEO] - Fiche produit catalogue papier meta index,follow
	2025	[SEO] - Promotions meta index,follow
	2023	[SEO] - Liste de meubles meta title
	2026	[SEO] - Page liste des Promos  meta title
	1756	[Retrait] - Anomalie graphique zone recap panier
	1755	[Retrait] - Anomalie graphique zone recap panier
	1758	[Retrait] - Anomalie graphique zone recap panier
	1757	[Retrait] - Anomalie graphique zone recap panier
	2080	[Paiement] - Anomalie graphique zone magasin
	2051	[Livraison] - Anomalie zone adresse de livraison
	2056	[Retrait] - Anomalie zone adresse de facturation
	2042	[Retrait] - Anomalie etage zone adresse de facturation
	1989	[compte client] Anomalie graphique sur la page de contact
	1641	[cr�ation de compte] Le message d'erreur obtenu lors de la cr�ation de compte avec un email d�j� connu est un peu trop technique
	2133	[SEO] - Identification meta title
	2128	[SEO] - Newsletter meta title
	2129	[SEO] - Newsletter meta noindex,nofollow
	2134	[SEO] - Identification meta noindex,nofollow
	2126	[SEO] - Mes magasins meta noindex,nofollow
	2125	[SEO] - Mes magasins meta title
	2112	[SEO] - Carnet d'adresse meta noindex,nofollow
	2123	[SEO] - D�tail d'un devis meta noindex,nofollow
	2111	[SEO] - Carnet d'adresse meta title
	2122	[SEO] - D�tail d'un devis meta title
	2113	[SEO] - Ajout/modification d'adresse meta noindex,nofollow
	2116	[SEO] - D�tail d'une liste d'achats meta title
	2114	[SEO] - Ajout/modification d'adresse meta title
	2119	[SEO] - D�tail d'une commande meta title
	2115	[SEO] - Liste d'achats meta title
	2120	[SEO] - D�tail d'une commande meta noindex,nofollow
	1990	[compte client] Anomalie graphique sur la page de contact
	1994	[compte client] Anomalie graphique sur la page de contact
	1993	[compte client] Anomalie graphique sur la page de contact
	2143	[SEO] - Confirmation de commande meta noindex,nofollow
	2142	[SEO] - Confirmation de commande meta title
	2131	[SEO] - Panier meta title
	2140	[SEO] - Paiement meta noindex,nofollow
	2139	[SEO] - Paiement meta title
	2137	[SEO] - Retrait meta noindex,nofollow
	2132	[SEO] - Panier meta noindex,nofollow
	2148	[liste d'achat] Le titre de la zone d'espot marketing est affich� alors qu'aucun produit n'y est configur�
	2136	[SEO] - Retrait meta title
	2147	[liste d'achat] anomalie graphique dans la page de liste des liste d'achat
	2145	[liste d'achat] Lors de la conversion de la liste d'achat en panier, la mention HT ne s'affiche pas pour le produit non achetabl
	2146	[liste d'achat] connect� en tant que pro, dans la page "mes liste d'achats" le format date n'est pas conforme
	1771	[mes adresses] Modification du nom de connexion(header) lors du changement d'adresse principale.
	2085	[Panier] - Le coupon "AMOUNT" de 10 euros devrait �tre appliqu� sur un panier de 20 euros
	2107	[Livraison] - Il est possible de se faire livrer un catalogue en dehors de la France
	2086	[Panier] - La suppression d'un coupon n'est pas r�percut�e sur le total du panier
	1968	[Liste d'achat] - L'url publique de partage g�n�re une page avec un message d'erreur
	1710	[Suivi de devis] - Anomalie graphique sur le fil d'ariane
	1709	[Suivi de devis] - Anomalie sur le fil d'ariane
	1992	[compte client] Anomalie graphique sur la page de contact
	1611	[Suivi de devis] - Libell� du fil d'ariane
	2005	[SEO] - Recherche commande url non conforme
	2001	[SEO] - Devis url non conforme
	2083	[Paiement] - L'achat de catalogue papier est bloqu�
	2029	[SEO] - R�sultat de recherche meta title
	2041	[Suivi commande] le message d'information lorsqu'aucune commande web n'a �t� faite n'est pas bon
	2040	[Suivi commande] le titre de la section "Commandes magasin" ne doit pas s'afficher si aucune commandes n'est r�cup�rer
	2037	[SEO] - Creation de compte meta noindex,nofollow
	2036	[SEO] - Creation de compte meta title
	2039	[SEO] - Synchro CRM meta noindex,nofollow
	2038	[SEO] - Synchro CRM meta title
	2034	[SEO] - Mot de passe oubli� meta title
	2033	[SEO] - Mot de passe oubli� meta noindex,nofollow
	2032	[SEO] - Login meta noindex,nofollow
	2031	[SEO] - Login  meta title
	2027	[SEO] - Comparateur meta title
	2028	[SEO] - Comparateur noindex,follow
	2003	[SEO] - Devis meta title
	2006	[SEO] - Recherche commande meta title
	2004	[SEO] - Devis meta noindex,nofollow
	2007	[SEO] - Recherche commande meta noindex,nofollow
	1998	[SEO] - FAQ meta index,follow
	1988	[Livraison] - Anomalie graphique zone adresse de facturation
	1975	[Livraison] - Anomalie graphique zone adresse de facturation
	1982	[Livraison] - Anomalie graphique zone adresse de facturation
	1692	[Suivi de devis] - Le bouton d'ajout au panier ne doit pas �tre propos� si le devis est �chue
	1919	[Suivi de devis] - Anomalie sur la popin de conversion
	1918	[Suivi de devis] - Anomalie sur la popin de conversion
	1922	[Suivi de devis] - Anomalie sur la popin de conversion
	1921	[Suivi de devis] - Anomalie sur la popin de conversion
	1997	[SEO] - Contact meta index,follow
	1917	[Suivi de devis] - Anomalie sur la popin de conversion
	2000	[SEO] - Store locator meta index,follow
	1996	[SEO] - Homepage meta index,follow
	1995	[SEO] - Homepage meta title
	1916	[Suivi de devis] - Anomalie sur la popin de conversion
	1915	[Suivi de devis] - Anomalie sur la popin de conversion
	1858	[Suivi de devis] - Anomalie graphique sur la popin de transformation
	1857	[Suivi de devis] - Anomalie graphique sur la popin de transformation
	1860	[Suivi de devis] - Anomalie graphique sur la popin de transformation
	1859	[Suivi de devis] - Anomalie graphique sur la popin de transformation
	1999	[SEO] - Store locator meta title
	1861	[Suivi de devis] - Anomalie graphique sur la popin de transformation
	1790	[Retrait] - Le magasin du panier est modifi� suite � l'identification
	1970	[Livraison] - Anomalie graphique zone adresse de facturation
	1969	[Livraison] - Anomalie graphique zone adresse de facturation
	1981	[Livraison] - Anomalie graphique zone adresse de facturation
	1971	[Livraison] - Anomalie graphique zone adresse de facturation
	1980	[Livraison] - Anomalie graphique zone adresse de facturation
	1979	[Livraison] - Anomalie graphique zone adresse de facturation
	1983	[Livraison] - Anomalie graphique zone adresse de facturation
	1978	[Livraison] - Anomalie graphique zone adresse de facturation
	1977	[Livraison] - Anomalie graphique zone adresse de facturation
	1984	[Livraison] - Anomalie graphique zone adresse de facturation
	1972	[Livraison] - Anomalie graphique zone adresse de facturation
	1985	[Livraison] - Anomalie graphique zone adresse de facturation
	1974	[Livraison] - Anomalie graphique zone adresse de facturation
	1987	[Livraison] - Anomalie graphique zone adresse de facturation
	1986	[Livraison] - Anomalie graphique zone adresse de facturation
	1973	[Livraison] - Anomalie graphique zone adresse de facturation
	1901	[Retrait Drive] - Anomalies graphiques zone de recherche de magasin
	1903	[Retrait Drive] - Anomalies graphiques zone de recherche de magasin
	1902	[Retrait Drive] - Anomalies graphiques zone de recherche de magasin
	1905	[Retrait Drive] - Anomalies graphiques zone de recherche de magasin
	1904	[Retrait Drive] - Anomalies graphiques zone de recherche de magasin
	1907	[Retrait Drive] - Anomalies graphiques zone de recherche de magasin
	1906	[Retrait Drive] - Anomalies graphiques zone de recherche de magasin
	1909	[Retrait Drive] - Anomalies graphiques zone de recherche de magasin
	1908	[Retrait Drive] - Anomalies graphiques zone de recherche de magasin
	1911	[Retrait Drive] - Anomalies graphiques zone de recherche de magasin
	1910	[Retrait Drive] - Anomalies graphiques zone de recherche de magasin
	1897	[Retrait Drive] - Anomalies graphiques zone cr�neau drive
	1867	[Retrait Drive] - Anomalies graphiques zone cr�neau drive
	1869	[Retrait Drive] - Anomalies graphiques zone cr�neau drive
	1738	[Retrait] - Certaines zones du bloc magasin ne sont pas cliquables
	1933	[Retrait] - Anomalie graphique popin adresse
	1293	[Header Panier] - Le recap panier vide n'est pas conforme � la maquette
	1761	[Retrait] - Anomalie graphique zone dispo commande
	1760	[Retrait] - Anomalie graphique zone dispo commande
	1762	[Retrait] - Anomalie graphique zone dispo commande
	1759	[Retrait] - Anomalie graphique zone dispo commande
	1778	[Panier] - Anomalie graphique sur libell� colonne
	1777	[Panier] - Anomalie graphique sur libell� colonne
	1779	[Panier] - Anomalie graphique sur colonne total ttc
	1776	[Panier] - Anomalie graphique sur la zone d'entete
	1775	[Panier] - Anomalie graphique sur la zone total
	1774	[Panier] - Anomalie graphique sur la zone TVA
	1924	[Suivi de devis] - Anomalie sur la zone produit
	1332	[Panier] - Anomalies graphiques sur le total du panier
	1926	[Suivi de devis] - Anomalie sur la zone produit
	1925	[Suivi de devis] - Anomalie sur la zone produit
	1928	[Suivi de devis] - Anomalie sur la zone produit
	1927	[Suivi de devis] - Anomalie sur la zone produit
	1929	[Suivi de devis] - Anomalie sur la zone colonne
	1752	[Retrait] - Anomalie graphique zone magasin
	1751	[Retrait] - Anomalie graphique zone magasin
	1964	[Livraison] - Anomalie graphique zone adresse de facturation
	1963	[Livraison] - Anomalie graphique zone adresse de facturation
	1962	[Livraison] - Anomalie graphique zone adresse de facturation
	1961	[Livraison] - Anomalie graphique zone adresse de facturation
	1944	[Compte client] formulaire mon compte n'est pas conforme aux maquettes
	1943	[oubli de mot de passe] Le formulaire d'identification n'est pas conforme aux maquettes
	1941	[oubli de mot de passe] Le formulaire d'identification n'est pas conforme aux maquettes
	1939	[oubli de mot de passe] Le formulaire d'oubli de mot de passe n'est pas conforme aux maquettes
	1955	[Retrait] - Anomalie graphique zone adresse facturation
	1938	[oubli de mot de passe] Le formulaire d'oubli de mot de passe n'est pas conforme aux maquettes
	1950	[Retrait] - Anomalie graphique zone adresse facturation
	1949	[Retrait] - Anomalie graphique zone adresse facturation
	1965	[Livraison] - Anomalie graphique zone adresse de facturation
	1951	[Retrait] - Anomalie graphique zone adresse facturation
	1960	[Livraison] - Anomalie graphique zone adresse de facturation
	1953	[Retrait] - Anomalie graphique zone adresse facturation
	1874	[Retrait Drive] - Anomalies graphiques zone cr�neau drive
	1868	[Retrait Drive] - Anomalies graphiques zone cr�neau drive
	1871	[Retrait Drive] - Anomalies graphiques zone cr�neau drive
	1365	[panier] - Le panier n'est pas persistant pour un anonyme
	1811	[contact] Les libell�s des champs faisant partie de l'email ne sont pas en gras
	1812	[contact] Dans le mail de contact, le libelle "Num�ro de document (facture, devis etc)" est coll� � la valeur du champ

	[Integration]
	1570	[Formulaire cr�ation adresse] -Carnet adresse : Adresse email obligatoire
	1565	Creation de compte Client - Etage par d�faut devrait �tre sur 'Aucun'
	1568	[Formulaire Creation Compte] - PRO - libel� Code NAF � renommer
		

version v0.1.23
---------------
	1357	[Identification] - Anomalies graphiques sur la page d'identification (bas de page)
	1604	[Suivi de commande] - La recherche renvoie des r�sultats sur des associations num�ro de commande + magasin de gestion invalide
	1607	[Suivi de commande] - La recherche renvoie un statut faux suite � une premi�re recherche
	1608	[Suivi de commande] - La recherche renvoie un statut faux suite � une premi�re recherche (second cas)
	1628	[cr�ation de compte] Dans le formulaire d'inscription, l'espace entre le libell� et les boutons radio est trop importante
	1652	[Synchro CRM] - popin confirmation : Anomalie graphique zone informative
	1654	[Synchro CRM] - popin confirmation : Anomalie graphique zone boutons
	1670	[Suivi de commande] - Anomalie graphique en �tant logu� en part zone image
	1679	[mail de confirmation de commande] Le libelle "D�tail Panier"  doit �tre affich� en gras dans le mail
	1681	[mail de confirmation de commande] Le titre des produits du Panier"doit �tre affich� en gras dans le mail
	1682	[mail de confirmation de commande] Le prix de chaque produit du Panier doit �tre affich� en gras dans le mail
	1683	[mail de confirmation de commande] Le libell� "mode d'enl�vement de votre commande"doit �tre affich� en gras dans le mail
	1684	[mail de confirmation]  Les libell�s adresse de facturation et de livraison ne sont pas align�s dans le mail
	1693	[Suivi de devis] - Le clique sur le bouton "Epingler" g�n�re un loader qui met plus de 10 secondes � s'effacer
	1695	[Suivi de devis] - Parcours client suite � erreur de recherche
	1697	[Suivi de devis] - Le clique sur le bouton "Y aller" ne fonctionne pas
	1699	[panier] Connect� en tant que Pro, tous les prix doivent �tre suivis de la mention HT
	1700	[mail de confirmation de commande] Pour un client Pro, dans le mail de confirmation, les prix des articles ne sont pas HT
	1701	[mail de confirmation de commande] Pour un client Pro, le prix des frais de livraison n'est pas HT
	1702	[mail de confirmation de commande] Pour un client Pro,  le prix du suppl�ment �tage n'est pas suivi de la mention HT
	1703	[mail de confirmation de commande] Le montant total de la commande est exprim� en TTC au lieu de HT
	1707	[mail de confirmation de commande] Dans le mail, les blocs produits ne sont pas du tout align�s
	1708	[mail de confirmation] Dans le mail, les boutons de disponibilit�s sont en orange  alors que le produit est disponible
	1711	[Suivi de devis] - Anomalie graphique sur la zone haute
	1716	[Suivi de devis] - Anomalie graphique sur la zone produit sur mesure
	1717	[Suivi de devis] - Anomalie graphique sur la zone produit sur mesure
	1721	[Suivi de devis] - Anomalie graphique sur la zone produit sur mesure
	1722	[Suivi de devis] - L'impression a un rendu tr�s d�grad�
	1729	[mon Compte] Dans mon compte, la liste d�roulante ne se positionne pas sur l'�tage r�el mais plut�t sur la 1ere entr�e
	1734	[ajout d'adresse] Le formulaire d'ajout d'adresse n'est pas tout � fait conforme � la maquette - A�ration
	1740	[Panier] - Anomalie sur l'ajout de quantit� d'un produit
	1743	[Suivi de commande] - Anomalie graphique en �tant logu� en part
	1746	[Suivi de devis] - Anomalie graphique zone de saisie
	1747	[Suivi de devis] - Anomalie graphique zone de liste
	1763	[Retrait] - Anomalie graphique separateur
	1780	[Suivi de devis] - Anomalie graphique sur la zone produit standard
	1781	[Suivi de devis] - Anomalie graphique sur la zone produit standard
	1782	[Suivi de devis] - Anomalie graphique sur la zone produit standard
	1783	[Suivi de devis] - Anomalie graphique sur la zone produit standard
	1784	[Suivi de devis] - Anomalie graphique sur la zone montant total
	1785	[Suivi de devis] - Anomalie graphique sur la zone montant total
	1786	[Suivi de devis] - Anomalie graphique sur la zone montant total
	1787	[Suivi de devis] - Anomalie graphique sur la zone montant total
	1791	[Retrait] - L'affichage des horaires n'est pas exploitable
	1792	[Suivi de devis] - Anomalie graphique sur la zone du bas
	1793	[Suivi de devis] - Anomalie graphique sur la zone magasin
	1796	[contact] clic sur logo du mail re�u suite � la saisie du formulaire "Validez votre commande internet" renvoie sur page blanche
	1797	[contact] clic sur logo du mail re�u suite � la saisie du formulaire "Contactez notre webmaster." renvoie sur une page blanche
	1798	[contact] clic sur logo du mail re�u suite � la saisie du formulaire "suivre votre commande internet" renvoie sur page blanche
	1801	[contact] clic sur logo du mail re�u suite � la saisie du formulaire "proposez un partenariat" renvoie sur une page blanche
	1803	[contact] clic sur logo du mail re�u suite � la saisie du formulaire "contactez notre service client" renvoie sur page blanche
	1804	[contact]  clic sur logo du mail re�u suite � la saisie du formulaire "questionner le service export" renvoie sur page blanche
	1816	[Retrait] - Le systeme n'arrive pas a determiner un magasin par defaut dans certain parcours client
	1822	[Suivi de devis] - Anomalie graphique sur la zone magasin
	1823	[Suivi de devis] - Anomalie graphique sur la zone magasin
	1824	[Suivi de devis] - Anomalie graphique sur la zone haute
	1825	[Panier] - Le clique sur le bouton "continuer mes achat" g�n�re une page cacher suite � l'ajout au panier d'un devis
	1826	[Retrait] - L'onglet drive n'est jamais affich�
	1830	[Mode de paiement] - Les CGV ne s'affichent pas au clique sur le libell�
	1831	[Mode de paiement] - Le lien "plus d'infos sur le paiement en carte" doit toujours �tre affich�
	1835	[Mode de paiement] - La popin du paiement ne se ferme pas au clique en dehors
	1836	[Mode de paiement] - La popin du paiement par carte n'a pas le rendu attendu
	1837	[Contact] Mauvais message d'erreur lorsque la civilit� n'est pas renseign� dans le formulaire "contacter notre service client"
	1838	[Contact] Mauvais message d'erreur lorsque la civilit� n'est pas renseign� dans le formulaire "Valider votre commande internet"
	1839	[Contact] Mauvais message d'erreur lorsque la civilit� n'est pas renseign� dans le formulaire "Contacter notre Webmaster"
	1840	[Contact] Mauvais message d'erreur lorsque la civilit� n'est pas renseign� dans le formulaire "Suivre votre commande internet"
	1842	[Contact] Mauvais message d'erreur lorsque la civilit� n'est pas renseign� dans le formulaire "Questionner le service Export"
	1843	[Contact] Mauvais message d'erreur lorsque le repr�sentant n'est pas renseign� dans le formulaire  "Proposer un partenariat"
	1844	[Contact] Erreur g�n�rique lorsque la liste des magasins n'est pas renseign� dans le formulaire "Proposer un partenariat"
	1845	[Contact] Aucune d'erreur lorsque le jour de date de cr�ation n'est pas renseign� dans le formulaire "Proposer un partenariat"
	1846	[Contact] Aucune erreur lorsque le mois de date de cr�ation n'est pas renseign� dans le formulaire "Proposer un partenariat"
	1847	[Contact] Aucune erreur  lorsque l'ann�e de date de cr�ation n'est pas renseign� dans le formulaire "Proposer un partenariat"
	1848	[Contact] Aucune erreur lorsque le jour de date d'�ch�ance n'est pas renseign� dans le formulaire "Proposer un partenariat"
	1849	[Contact] Aucune erreur lorsque le mois de date d'�ch�ance n'est pas renseign� dans le formulaire "Proposer un partenariat"
	1850	[Contact] Aucune erreur lorsque l'ann�e de date d'�ch�ance n'est pas renseign� dans le formulaire "Proposer un partenariat"
	1851	[Contact] Aucune erreur lorsque le domaine de comp�tence n'est pas renseign� dans le formulaire "Proposer un partenariat"
	1852	[Contact] Aucun email n'est envoy� lors de la saisie de tous les champs obligatoire dans le formulaire "Proposer un partenariat"
	1855	[Confirmation de creation de compte via synchro CRM] - La page n'est jamais affich�e
	1856	[Confirmation de creation de compte] - La page n'est jamais affich�e
	1864	[Retrait Drive] - Les jours de fermeture exceptionnel drive ne sont pas affich�s en gris�
	1877	[Suivi de devis] - R�gression sur la liste des magasins propos�s
	1878	[ajout d'adresse] Le formulaire d'ajout d'adresse n'est pas tout � fait conforme � la maquette - nom adresse
	1879	[compte client] Dans le formulaire contacter notre service client, quand on est logu�, la civilit� n'est jamais reprise
	1880	[compte client] Dans le formulaire Valider votre commande internet, quand on est logu�, la civilit� n'est jamais reprise
	1881	[compte client] Dans le formulaire contacter notre Webmaster, quand on est logu�, la civilit� n'est jamais reprise
	1882	[compte client] Dans le formulaire suivre votre commande internet, quand on est logu�, la civilit� n'est jamais reprise
	1883	[compte client] Dans le formulaire proposer un partenariat, quand on est logu�, la civilit� n'est jamais reprise
	1884	[compte client] Dans le formulaire questionner le service export, quand on est logu�, la civilit� n'est jamais reprise
	1885	[compte client]dans mes commandes, le montant de chaque commande doit �tre align�s sur les chiffres apr�s la virgule
	1887	[Liste d'achat] Le champ date de cr�ation n'est pas en gras comme sur les maquettes
	1889	[Liste d'achat] Le libell� "Partager sur" n'est pas correctement positionn� conform�ment aux maquette
	1890	[Liste d'achat] les images de r�seaux sociaux ne sont pas centr� par rapport au prix comme sur les maquettes
	1891	[Liste d'achat]dans mes mes listes d'achat, le montant de chaque commande doit �tre align�s sur les chiffres apr�s la virgule

	[Integration]
	1565	Creation de compte Client - Etage par d�faut devrait �tre sur 'Aucun'
	1568	[Formulaire Creation Compte] - PRO - libel� Code NAF � renommer
	1570	[Formulaire cr�ation adresse] -Carnet adresse : Adresse email obligatoire

	1726	[Interface client WCS -> EAI] gestion des adresses
	1773	[Interface client WCS-EAI] - update client - info codeAPESecondaire � ne pas renvoyer


versiov v0.1.22
---------------
	724		[Home page] - Anomalies graphiques sur un widget
	1286	[Header Panier] - Anomalies graphiques sur l'aper�u du panier
	1293	[Header Panier] - Le recap panier vide n'est pas conforme � la maquette
	1328	[Panier] - Anomalies graphiques sur le header du panier
	1349	[Panier] - Anomalie graphique sur l'alerte d'indisponibilit�
	1362	[Retrait/Livraison] - Les onglets ne sont pas conformes � la maquette
	1404	[Fiche magasin] - R�gression sur le picto �pingler de la pin
	1414	[Fiche produit] - Le sigle HT a une taille plus importante que sur la maquette en mode grille
	1415	[Fiche produit sur mesure] - R�gressions graphiques
	1433	[Dossier] - Anomalies graphiques en vue liste
	1475	[Search contenus] - La recherche proposes des termes approchants incoh�rents
	1512	[Fiche produit standard] - Ajout au panier impossible dans certains cas
	1564	[Search contenu] - La pagination ne fonctionne pas de la m�me mani�re que celle de l'onglet produit
	1578	[MEA banniere] - Anomalie graphique sur la zone du titre
	1586	[Fiche produit ] - Mauvais titre de produit sur la popin de confirmation d'ajout du produit au panier
	1591	[Fiche produit standard] - Anomalies graphiques sur le zoom
	1605	[Suivi de commande] - Contr�le absent sur le champ num�ro de commande
	1631	[Cr�ation de compte] Les valeurs de la liste "Effectif" ne sont pas du tout les bonnes
	1635	[Cr�ation de compte] Dans le mail re�u lors de la cr�ation de compte, le champ b�timent non valoris� est tout de m�me affich�
	1636	[Cr�ation de compte] Dans le mail re�u lors de la cr�ation de compte, la valeur du champ �tage n'est pas repris
	1642	[oubli de mot de passe] Le lien  "Mon compte"figurant dans le mail de modification de mot de passe n'est pas bon .
	1643	[oubli de mot de passe] Le lien "Lapeyre.fr"figurant dans le mail de modification de mot de passe n'est pas bon
	1646	[Synchro CRM] - Anomalie graphique sur la croix de fermeture
	1647	[Synchro CRM] - popin confirmation : Anomalie graphique sur la croix de fermeture
	1660	[modification compte Client] Dans le formulaire, le libell� "ajouter un num�ro" doit �tre un bouton et non un simple libell�
	1662	[Mon compte] Dans le formulaire mon compte, l'ann�e de naissance ne va pas au del� de 1995
	1663	[mon compte] Dans le header de l'espace client, le type de client (pro/part) doit �tre affich�en italique
	1667	[Suivi de commande] - Anomalie graphique en �tant logu� en part
	1669	[Suivi de commande] - Anomalie graphique en �tant logu� en part zone type
	1670	[Suivi de commande] - Anomalie graphique en �tant logu� en part zone image
	1685	[mail de confirmation de commande] Des points interrogation(???) sont affich�s � la fin du champ N� Voie � tort
	1686	[mail de confirmation de commande] Dans le mail,pour la partie Adresse,  le champ �tage est repris avec de mauvaise valeur
	1690	[Suivi de devis] - Anomalie sur la popin de conversion
	1691	[Suivi de devis] - Anomalie graphique sur la couleur de fond en fonction de la validit�
	1694	[Suivi de devis] - Parcours client suite au clique sur �pingler
	1696	[Suivi de devis] - Contr�le absent sur le champ num�ro de devis
	1698	[Commande] La disponibilit� stock ne s'affiche plus au niveau de la quickview d'un produit
	1704	[mail de confirmation de commande] dans la partie adresse de facturation et livraison, l'�tage est repris au niveau de la voie
	1711	[Suivi de devis] - Anomalie graphique sur la zone haute
	1712	[Suivi de devis] - Anomalie graphique sur la zone haute
	1713	[Suivi de devis] - Anomalie graphique sur la zone haute
	1714	[Suivi de devis] - Anomalie graphique sur la zone haute
	1715	[Suivi de devis] - Anomalie graphique sur la zone haute
	1716	[Suivi de devis] - Anomalie graphique sur la zone produit sur mesure
	1717	[Suivi de devis] - Anomalie graphique sur la zone produit sur mesure
	1718	[Suivi de devis] - Aucun prix n'est affich� pour les produits sur mesure du devis
	1719	[Suivi de devis] - Anomalie graphique sur la zone produit sur mesure
	1720	[Suivi de devis] - Anomalie graphique sur la zone produit sur mesure
	1721	[Suivi de devis] - Anomalie graphique sur la zone produit sur mesure
	1723	[Suivi de devis] - Anomalie graphique sur la zone produit standard
	1725	[Suivi de devis] - La r�f�rence d'un produit standard n'est pas affich�e
	1732	[ajout d'adresse] Le formulaire d'ajout d'adresse n'est pas tout � fait conforme � la maquette - Bouton "Retours aux adresse"
	1733	[ajout d'adresse] Le formulaire d'ajout d'adresse n'est pas tout � fait conforme � la maquette - "Nom Adresse"
	1734	[ajout d'adresse] Le formulaire d'ajout d'adresse n'est pas tout � fait conforme � la maquette - A�ration
	1735	[mes adresses] La page mes adresses n'est pas tout � fait conforme � la maquette
	1738	[Retrait] - Certaines zones du bloc magasin ne sont pas cliquables
	1739	[Identification] - Le lien sur l'�tape 1 ne fonctionne pas
	1764	[d�tail commande] La typologie utilis� n'est pas la m�me que sur les maquettes

	[Integration]
	1625	[DETAIL DEVIS] mauvais WS + gestion erron�e des donn�es

versiov v0.1.21
---------------
	257		[Header] - Affichage du pr�nom et du nom d'un client professionnel
	616		[facette de la page de r�sultat de recherche] Les attributs de facettes ne figurent pour aucun produits retourn�s
	727		[Home page] - Widget s�lection du mois anomalies graphiques
	872		[Footer] - Anomalie graphique dans la zone newsletter
	1076	[Preview management center] - Probl�me sur le widget s�lection du mois
	1211	[Home page] - R�gression sur l'affichage des MEA vignettes en 33%
	1274	[Liste d'achat] - R�gression sur l'ajout � la liste d'achat
	1303	[Liste d'achat]  la liste des attributs de d�finition avec leur valeur n'est pas reprise dans la liste d'achat
	1391	[Fiche magasin] - Anomalie graphique zone magasins
	1411	[Contenu article] - R�gression sur l'affichage du carrousel
	1429	[Fiche produit collection] - Anomalie graphique sur le carrousel d'images
	1438	[Header] Logu� en tant que pro2, le libell� du magasin du header chevauche la zone de recherche
	1459	[QuickView] La partie descriptif n'est pas la m�me que sur la fiche produit.
	1460	[fiche Produit] Les visuels secondaires de la fiche produits doivent �tre sur une ligne
	1462	[Famille] L'affichage des produits de la page famille en vue liste n'est pas conforme � la maquette
	1497	[Fiche Produit] le libell� NAN apparait dans le champ quantit� lorsqu'on efface le contenu et qu'on clic sur le "+"
	1498	[Page famille] En vue liste, le libell� NAN apparait dans le champ quantit� lorsqu'on efface le contenu et qu'on clic sur le "+"
	1501	[liste d'achat] - Mobile - Connect� en tant que pro, lors de la consultation d'une liste d'achat, les prix ne sont pas HT
	1504	[QuickView] Lors de l'affichage du quickView depuis le comparateur de produit, les attributs ne s'affichent pas
	1510	[Famille] - Anomalie graphique sur liste zone de famille
	1524	[PANIER] date dispo commande erron�e dans le cas d'une transfo de wishlist en panier
	1530	[Interrogation stock] - Probl�me de d�clenchement si on acc�de directement � une fiche produit
	1532	Page livraison: loader infini + dispo stock KO
	1534	Coupons: application des coupons apres login pro
	1538	[Page famille] - Mobile - Regressison sur l'affichage des boutons de pagination (Suivant et pr�c�dent)
	1544	[Fiche produit] Le fil d'ariane sous Safari ne s'affiche pas correctement
	1545	[Page Famille] Le fil d'ariane sous Safari ne s'affiche pas correctement au niveau de la page famille
	1549	[Home page] - Anomalies sur la zone des r�seaux sociaux
	1550	[Contenu article] - La taille de l'image d'ent�te est beaucoup plus grande que sur la maquette
	1551	[Contenu article] - Anomalies sur la zone auteur
	1552	[Contenu article] - Anomalies sur la zone paragraphe
	1554	[Contenu article] - Anomalies sur la zone pagination
	1555	[Contenu dossier] - Anomalie sur la zone haute
	1556	[Contenu dossier] - Anomalie sur la vue liste d'un article associ�
	1561	[Univers] - Probl�me d'affichage des familles de certains univers
	1562	[Famille] - Probl�me d'affichage des sous-familles de certaines familles
	1579	[MEA banniere] - Anomalie graphique sur la zone du bouton
	1580	[MEA banniere] - Anomalie graphique sur la zone des boutons de passage d'un slide � l'autre
	1583	[Newsletter] - L'affichage de la newsletter a subi une r�gression graphique
	1585	[page Famille] La quickView ne s'affiche plus lorsqu'on est sur la page famille
	1586	[Fiche produit ] - Mauvais titre de produit sur la popin de confirmation d'ajout du produit au panier
	1592	[Fiche Produit collection] Le titre "Produit en Image" est affich� alors qu'aucun produit secondaire n'est disponible

	[Integration]
	241	CMS : mail demande de changement de mot de passe
	1523	Fiche client: code effectif requis


versiov v0.1.20
---------------
	277		[Newsletter] - Message d'erreur
	508		[Store locator] - Fiche magasin - Les notes remont�es dans les avis clients ne sont pas conformes
	724		[Home page] - Anomalies graphiques sur un widget
	728		[Home page] - Anomalie graphique sur un widget produit et contenu
	872		[Footer] - Anomalie graphique dans la zone newsletter
	910		[Page Univers] - Mobile: MEA univers est affich� � tort
	984		[Page de resultat de recherche] La zone MEA de recherche est pr�sente � tort sur la page de r�sultat de recherche
	1035	[Home page] - Anomalies graphiques sur la quick view
	1045	[Menu de navigation] - Lien "Lapeyre pro"
	1080	[Fiche magasin] - Anomalie graphique sur popin de partage
	1094	[Famille] - Absence des attributs de d�finition d'une collection en mode liste
	1143	[Fiche produit standard] -La popin de confirmation d'ajout au panier ne s'affiche pas correctement
	1159	[fiche produit collection] - Anomalie graphique swatch
	1233	[Fiche produit standard] - Ajout au panier anomalie graphique
	1237	[Fiche produit standard] - Autre anomalie graphique sur info bulle
	1241	[Search produit] - Pagination anomalie graphique
	1275	[Store locator] - R�gression sur le footer
	1277	[Liste d'achat] - R�gression graphique
	1282	[Famille] - R�gression : Les MEA s'affichent sur mobile
	1292	[Header Panier] - Anomalies graphiques sur le recap panier
	1320	[Retrait] - Identification suite � une perte de session et perte de navigation
	1331	[Retrait] - Anomalies graphiques sur le header light
	1335	[Liste d'achat] la popin de conversion de la liste d'achat en panier ne se ferme pas quand on clique en dehors de la popin
	1343	[liste d'achat] Ajout d'un produit sans prix � une liste d'achat a pour effet d'afficher le libell� prix en attente.
	1351	[Panier] - Code avantage - Le libell� doit �tre align� � gauche
	1355	[Panier] - Anomalies graphiques zone �co-part
	1366	[R�cap panier] - Anomalies graphiques sur la zone des �co-participations
	1386	[Fiche produit collection] - Zone descriptif d�taill�
	1395	[Store locator] - Anomalie graphique picto �pingl� sur pin
	1398	[Fiche magasin] - R�gression graphique sur popin GPS
	1404	[Fiche magasin] - R�gression sur le picto �pingler de la pin
	1409	[Page Famille] la mention prix selon compo type apparait alors que le produit ne dispose pas de prix
	1422	[Livraison/Drive] carrousel des cr�neaux et pb graphiques
	1427	[Home du mag] - R�gression sur l'affichage du menu de l'espace �ditorial
	1430	[Fiche produit sur mesure] - Anomalies graphiques zone descriptif
	1436	[IDENTIFICATION] redirection apr�s cr�ation de compte
	1454	[Quick view] - R�gression : Perte de l'opacit� en arri�re plan
	1473	[Quick view] - L'interrogation stock est graphiquement diff�rente de la fiche produit
	1477	[Header] - R�gression sur la troisieme ligne
	1480	[Fiche produit collection] - Les vid�os ne s'affichent pas
	1502	[QUICK VIEW] Attributs de d�finition non affich� lorsque la quick-view est charg�e depuis le comparateur
	1516	[PANIER] Tarif Carrelage faux
	1518	[Fiche produit standard] Le descriptif d�taill� est vide cependant l'onglet est tout de m�me affich�
	1519	[POPIN AJOUT WISHLIST] Blocage ajout � la wishlist apr�s cr�ation de la liste
	1525	[Search produit] - Le bouton "Trouver mon magasin" n'est plus affich� sur les produits catalogue papier
	1527	[Fiche produit standard] - Anomalies graphiques zone mes options
	1531	[Famille] - Anomalie graphique s�parateur entre les blocs produits
	1536	[Contenu article] - R�gression : Le bouton de pagination d'un article ne s'affiche plus correctement

	[Integration]
	1420	[Fiche produit standard] Assets fantomes


versiov v0.1.19
---------------
	342		[search] La recherche sur une r�f�rence d'article ne fonctionne pas correctement
	366		[Home du mag] - A�ration entre les titres et les contenus
	376		[Fiche produit] la zone d'onglet "Description d�taill�" est vide cependant elle est tout de m�me affcih�e
	748		[Home du mag] - A�ration entre les blocs quand une section est vide
	903		[Page Famille] - Mobile: Le libell� prix pour les dimensions est tronqu� � tord
	1035	[Home page] - Anomalies graphiques sur la quick view
	1076	[Preview management center] - Probl�me sur le widget s�lection du mois
	1085	[Store locator] - Anomalie graphique sur la liste des magasins
	1129	[Liste d'achat] - Anomalie graphique sur les libell�s longs
	1208	[Fiche produit standard] - Anomalie graphique popin informative mes options
	1216	[Fiche produit standard] - la popin d'ajout � la liste d'achat n'est pas visible lorsque l'on scroll
	1229	[Famille] - Anomalie graphique sur la zone de s�lection promotions
	1235	[Fiche produit standard] - Les pictos doivent �tre affich�s sous le descriptif d�taill�
	1265	[Fiche produit standard] - caract�res non autoris�s sur le champ quantit�
	1294	[Header Panier] - La r�f�rence n'est jamais affich�e
	1298	[Liste d'achat] Le titre du produit ajout� � la liste d'achat n'est pas le m�me que celui de la fiche produit
	1302	[Liste d'achat] La r�f�rence du produit n'est pas reprise dans la liste d'achat
	1303	[Liste d'achat]  la liste des attributs de d�finition avec leur valeur n'est pas reprise dans la liste d'achat
	1306	[Liste d'achat] Le libell� de la liste d'achat doit �tre tronqu� � 50 caract�res dans la page de liste des listes d'achat
	1319	[Panier] - Validation de panier impossible sans interrogation stock
	1322	[Panier] - Anomalies graphiques sur les lignes produit
	1323	[Panier] - Les prix affich�s sur une m�me ligne produit sont incoh�rents
	1326	[Page panier] - Anomalies graphiques sur la zone haute
	1328	[Panier] - Anomalies graphiques sur le header du panier
	1329	[Panier] - La disponibilit� de la commande n'est jamais affich�e
	1332	[Panier] - Anomalies graphiques sur le total du panier
	1334	[Liste d'achat] Dans la page de liste des liste d'achat,  le signe euro apparait en dessous du prix.
	1337	[Liste d'achat] Visuel non conforme lors de la transformation de la liste d'achat en panier pour les produits non vendables
	1338	[Liste d'achat] La popin de transformation de la liste d'achat en panier bloque toute la navigation
	1339	[Liste d'achat] Dans la page de liste d'achats,en page une, une erreur appara�t lors du clic sur le bouton "plus r�cente"
	1340	[Liste d'achat] Dans la page de liste d'achats,en derni�re page, une erreur appara�t lors du clic sur le bouton "plus ancienne"
	1342	[Liste d'achat] L'ajout d'un produit � la liste d'achat celui-ci devrait appara�tre en premier de la liste.
	1346	[Liste d'achat] Incoh�rence entre le prix unitaire HT et le prix unitaire TTC
	1350	[Panier] - Le mot "Unit�" est affich� sur certains produits
	1354	[Panier] - Code avantage - Le champ doit �tre limit� � 17 caract�res
	1357	[Identification] - Anomalies graphiques sur la page d'identification (bas de page)
	1358	[Identification] - Anomalies graphiques sur la page d'identification
	1360	[Identification] - Anomalies graphiques sur la page d'identification
	1362	[Retrait/Livraison] - Les onglets ne sont pas conformes � la maquette
	1363	[Page panier] - Le bouton "Valider ma commande" n'est pas conforme � la maquette
	1364	[Panier] - Zone code avantages
	1367	[Liste d'achat] A la cr�ation d'une liste d'achat la saisie du nom est limit� � 64 caract�res
	1384	[liste d'achat] La liste d'achat sur mobile n'affiche pas le nombre total de produit la composant
	1386	[Fiche produit collection] - Zone descriptif d�taill�
	1387	[Search contenu] - Probl�me de "clique" sur les premiers �l�ments de chaque groupe de facette
	1394	[Panier] - Anomalies graphiques zone haute
	1399	[Store locator] - Anomalies graphiques zone de recherche
	1406	[Fiche produit] Le zoom sur le visuel principal est �norme sous Safari
	1408	[Page de Liste de meubles] Aucune facette ne s'affiche dans la page de resultat de meuble
	1423	[LIVRAISON] Magasin propos� � plus de 150km
	1424	[CLIENT/TUNNEL] Bloc adresse : erreur d'affichage si Etage vide
	1426	[Article] - Anomalies sur le bouton "Lire cet article"
	1427	[Home du mag] - R�gression sur l'affichage du menu de l'espace �ditorial
	1428	[Fiche produit catalogue] - Probl�me de clique sur le picto enveloppe
	1429	[Fiche produit collection] - Anomalie graphique sur le carrousel d'images
	1430	[Fiche produit sur mesure] - Anomalies graphiques zone descriptif
	1431	[Fiche produit standard] - Anomalie graphique champ quantit�
	1433	[Dossier] - Anomalies graphiques en vue liste
	1437	[QuickView] La quickView n'est pas conforme aux maquettes
	1438	[Header] Logu� en tant que pro2, le libell� du magasin du header chevauche la zone de recherche
	1440	[Fiche produit] La couleur du magasin de la zone de disponibilit� stock n'est pas reprise
	1441	[Fiche Produit standard] - La fiche produit standard n'est pas conforme aux maquettes
	1445	[Recherche COMMANDE] Les commandes termin�es ne remontent pas
	1446	[Search contenu] - Anomalies graphiques
	1447	[Famille] - Probleme sur le bouton d'ajout a la liste d'achat en mode liste
	1448	[Store locator] - La recherche ne fonctionne plus sans partage de position
	1451	[Search produit] - Certaines recherches font perdre les facettes
	1456	[Zone de facette] La zone de facette n'est pas conforme au maquette lorqu'un attribut facetable est plier
	1458	[QuickView] La disposition des visuels secondaires est contraire � la maquette
	1464	[Search contenu] - Groupe de facette propos� vide
	1466	[Search contenu] - R�gression : Les facettes de contenus ne s'affichent plus correctement
	1473	[Quick view] - L'interrogation stock est graphiquement diff�rente de la fiche produit
	1482	[Creation Commande] - Erreur lors de la cr�ation de commandes
	1485	[Confirmation commande] - Nom du magasin en dur dans la page de confirmation de commande

	[Integration]
	112	Fonctionnement du bouton � la liste d'achat
	202	WS resaCreneauDrive retourne une trame vide
	495	WS � utiliser en PPR
	1418	Concatenation B�n�fice client/caract�ristiques techniques
	1421	[Fiche produit Sur mesure] Pictos non affich�s
	1442	Synchronisation par docId impossible
	1488	Champs manquants dans l'export commande


versiov v0.1.18
---------------
	284	[BO CMS] - Cr�ation d'article �ditorial impossible avec un profil contributeur
	287	[mode Liste] Saisi de lettre possible dans le champ quantit�
	300	[BO CMS] - Droits sur un valideur
	315	[BO CMS] - Impossible de cr�er un article dans un dossier �ditorial avec un profil publieur
	358	[Contenu article] - Pagination anomalies graphiques
	366	[Home du mag] - A�ration entre les titres et les contenus
	367	[Home du mag] - Section "La parole LAPEYRE"
	390	[Fiche produit sur mesure] Le graphisme des fiches produissur mesure sans prix ne semble pas conforme aux maquettes
	463	[BO CMS] - Ajout d'un tag difficile dans certains cas
	474	[Search contenus] - Anomalies graphiques sur l'onglet contenu
	482	[Article �ditorial] - Anomalies graphiques zone de cross-content
	522	[Comparateur] Dans le comparateur, le bouton acheter vos meubles n'a pas le bon style.
	537	[Famille] - Anomalie graphique entre la MEA et la zone haute d'une famille
	561	[Contenu �ditorial] - Anomalie graphiques sur les produits li�s
	672	[Fiche Produit] Le libell� concernant l'eco participation doit �tre en gras
	706	[Fiche magasin] - Anomalie graphique typo mot du directeur et zone actualit�s
	748	[Home du mag] - A�ration entre les blocs quand une section est vide
	775	[Store locator] - Demande permanente de validation de partage de position
	894	[Article] - Anomalies graphiques sur la zone de partage
	941	[Article] - Zone description de l'auteur
	973	[Menu de navigation du mag] - Anomalies graphiques sur le menu du mag
	974	[Menu de navigation instit] - Anomalies graphiques sur le menu des pages institutionnels
	1015	[Fiche magasin] - Anomalies graphiques sur la fiche magasin
	1034	[G�olocalisation] - Le partage de position doit �tre accept� plusieurs fois
	1092	[Famille] - Anomalies graphiques zone de facette
	1129	[Liste d'achat] - Anomalie graphique sur les libell�s longs
	1133	[Fiche produit standard] - Quantit� n�gative et message d'erreur d�grad�
	1136	[Fiche produit standard] - Anomalie graphique swatch s�lectionn�e
	1141	[Liste d'achat] - Popin de confirmation - Le visuel par d�faut n'est pas affich� quand le produit n'a pas d'image
	1173	[Fiche produit collection] - Le picto vid�o n'est pas celui des maquettes
	1189	[zone de facette] Le slider de prix affiche un intervalle de prix en borne inf�rieur
	1206	[comparateur] l'image du bouton 'Achetez vos meubles" apparait en d�call� sur le bouton
	1212	[Home page] - R�gression : MEA liens en 33% et 50%
	1252	[Liste d'achat] Impossible de supprimer une liste d'achat. Un message d'erreur apparait
	1257	[Fiche produit catalogue] - Ajout au panier impossible
	1270	[comparateur] un produit collection disposant du bouton "Achetez vos meubles" ne dispose plus de ce bouton dans le comparateur
	1272	[G�olocalisation] - Le partage de position est demand� en permanence sous Firefox
	1274	[Liste d'achat] - R�gression sur l'ajout � la liste d'achat
	1277	[Liste d'achat] - R�gression graphique
	1281	[Fiche produit standard] - R�gression sur l'ajout au panier
	1283	[Famille] - R�gression sur l'affichage du cross-content
	1285	[Header Panier] - Il est impossible d'acc�der � la page panier � partir de 4 produits s�lectionn�s
	1286	[Header Panier] - Anomalies graphiques sur l'aper�u du panier
	1288	[Header Panier] - Le libell� du bouton d'acc�s � la page panier n'est pas le bon
	1289	[Header Panier] - La popin doit s'afficher au survol de la souris
	1290	[Header Panier] - La quantit� doit �tre � z�ro lorsqu'il n'y a pas de produits dans le panier
	1291	[Quick view] - Anomalie graphique sur les catalogues papiers
	1292	[Header Panier] - Anomalies graphiques sur le recap panier
	1305	[Popin ajout liste d'achat] Popup d'ajout � la liste d'achat non conforme au maquette.Le titre du produit n'est pas en gras
	1321	[Panier] - Le champ quantit� accepte les lettres et autres caract�res non appropri�s
	1327	[Livraison/Retrait] - Le r�cap panier d�forme la page
	1344	[Liste d'achat] Lors de la suppression d'une liste d'achat, l'utilisateur est redirig� sur cette m�me liste d'achat � tort
	1353	[Panier] - Code avantage - Message d'erreur sur mauvais code avantage
	1368	[Fiche Produit] Lors de la saisit d'une surface avec un nombre � virgule, une erreur NAN apparait
	1370	[fiche produit] - Mobile- Impossible de saisir une virgule dans le champ surface
	1371	[Fiche produit] le champ surface affiche 000 lorqu'on supprime toute le svaleurs pr�sentes dans le champ
	1374	[zone de facette] Mauvais ordre d'affichage des valeurs de facettes
	1375	[Zone de facette] Apr�s une 1ere selection de facette, certaines valeur de facettes ne retournant aucun produits sont affich�es
	1378	[Fiche Produit] Dans la zone d'option les valeur d'attribut de definition ne s'affiche pas bien que l'attribut s'affiche
	1382	[Page famille] En vue liste, pour le champ quantit� il est toujours possible de saisir des lettres
	1383	[Page famille] Le libell� prix pour les dimensions ne s'affiche plus en mode liste
	1385	[Comparateur] - Anomalies graphiques
	1387	[Search contenu] - Probl�me de "clique" sur les premiers �l�ments de chaque groupe de facette
	1388	[Fiche magasin] - Anomalie graphique map Google
	1389	[Fiche magasin] - Anomalie graphique zone du bas
	1390	[Fiche magasin] - Anomalie graphique zone notes
	1391	[Fiche magasin] - Anomalie graphique zone magasins
	1392	[Fiche magasin] - r�gression anomalie graphique sur les horaires
	1393	[Fiche magasin] - Anomalie graphique magasin sans services
	1396	[Store locator] - Pictos pour �pingler ou retirer l'�pingle
	1398	[Fiche magasin] - R�gression graphique sur popin GPS
	1400	[Store locator] - R�gression graphique
	1401	[Store locator] - R�gression graphique sur titre
	1405	[Panier] - Probl�me sur le bandeau promo
	1413	[Store locator] - R�gression sur l'affichage des pictos de partage
	1414	[Fiche produit] - Le sigle HT a une taille plus importante que sur la maquette en mode grille
	1415	[Fiche produit sur mesure] - R�gressions graphiques

	[Int�gration]
	0607	[Produit] [Item]- suppression de SKU - Flux produit
	1056	Export Client

versiov v0.1.17
---------------
	291	[QuickView] Probl�mes graphique sur le QuickView
	324	[Contenu dossier] - Article d'un dossier ajustements graphiques
	413	[fiche produit Collection] La fiche produit collection ne correspond pas � la maquette
	467	[Search contenus] - Valeur de facette longue
	555	[Produit sur mesure] Le libell� de l'onglet "Caract�ristiques techniques" n'est pas le bon
	572	[Home page] - Anomalies graphiques sur une MEA carrousel
	622	Fiche produit] la date de disponibilit� doit s''afficher en orange
	640	[Zone de facette] Lorsqu'il y a un certain nombre d'attributs pour une facette, ceux ci ne sont pas align�s
	667	[Fiche produit collection] La vue liste des produits collection pas conforme aux maquettes
	671	[Fiche Produit] le libell� r�f�rence de l'article n'est pas conforme aux maquettes
	701	[Fiche magasin] - Anomalie graphique lorsqu'il y a plusieurs num�ros de t�l�phones
	717	[Fiche produit standard] La liste des pictos doit se faire sur une ligne de 4 picto maximum
	732	[Header] - MEA dans le menu de navigation
	745	[Home du mag] - Produit qui ne devrait pas apparaitre dans le push produit
	788	[Store locator] - Map non utilisable dans certains cas
	796	[FIche produit collection] La fiche produit collection n'est pas conforme aux maquettes
	818	[Fiche produit standard] La Fiche produit standard n'est pas conforme aux maquettes
	873	[Menu lateral] - Trait de s�paration des univers dans le menu lat�ral
	907	[Page Famille] - Mobile: L'espace entre chaque visuel produit est trop grand.
	924	[Fiche Produit standard] - La fiche produit standard n'est pas conforme aux maquettes
	927	[Fiche Produit] le clic sur bouton annuler de la popin liste d'achat agrandi la popin au lieu de la fermer
	946	[Fiche Produit sur mesure] - Mobile: non conforme au maquette
	987	[Page de r�sultat de recherche] La taille des visuels produits ne semble pas correctes.
	1022	[Fiche Produit standard] Les picto ont des tailles diff�rentes d'une zone � lautre
	1049	[Home page - Quick view] - Anomalies graphiques
	1069	[Fiche produit collection] Certains visuels secondaires ne s'affichent pas.
	1088	[Fiche produit standard] - L'info bulle mes options n'appara�t jamais
	1092	[Famille] - Anomalies graphiques zone de facette
	1093	[Famille] - Anomalies graphiques en mode liste
	1171	[Fiche produit collection] - La vid�o ne s'affiche pas sur iPhone
	1183	[Search contenus] - Les contenus d�publi�s ne sont plus affich�s mais sont toujours pr�sent dans le moteur de recherche
	1195	[Search produit] - Anomalie graphique sur la zone de prix des produits sur mesure
	1208	[Fiche produit standard] - Anomalie graphique popin informative mes options
	1212	[Home page] - R�gression : MEA liens en 33% et 50%
	1213	[Fiche produit standard] - Anomalie graphique sur info bulle
	1214	[Fiche produit standard] - Le clavier appara�t puis disparait sur l'ajout � la liste d'achats
	1215	[Fiche produit standard] - Anomalie graphique sur la popin de confirmation d'ajout � la liste d'achat
	1216	[Fiche produit standard] - la popin d'ajout � la liste d'achat n'est pas visible lorsque l'on scroll
	1217	[Fiche produit standard] - Ajout au panier
	1219	[Fiche produit] le pictogramme est masqu� par les boutons de r�seaux sociaux
	1222	[Famille] - Anomalie graphique sur le bouton pour afficher les promotions
	1223	[Comparateur] - Anomalies graphiques sur le comparateur
	1224	[Fiche magasin] - R�gression : Loader infini lorsqu'un �pingle un magasin
	1225	[Perte de session] - Anomalie graphique
	1226	[Article] - R�gression sur le lien vers le site de l'auteur
	1227	[Fiche produit standard] - La zone "bouge" de gauche � droite au passage horizontal du doigt sur l'�cran
	1228	[Fiche produit sur mesure] - Anomalie graphique sur la ligne d'eco part
	1229	[Famille] - Anomalie graphique sur la zone de s�lection promotions
	1230	[Search contenus] - R�gression sur l'affichage des contenus
	1231	[Univers] - Probl�me d'affichage des familles de certains univers
	1232	[Famille] - Probl�me d'affichage des sous-familles de certaines familles
	1234	[Fiche produit collection] - R�gression : Le carrousel d'image ne s'affiche plus
	1235	[Fiche produit standard] - Les pictos doivent �tre affich�s sous le descriptif d�taill�
	1236	[Famille] - Le bouton d'ajout � la liste d'achat ne fonctionne plus dans certains cas en mode liste et en mode grille
	1237	[Fiche produit standard] - Autre anomalie graphique sur info bulle
	1238	[Search produit] - Lorsque je souhaites ajouter un produit � la liste d'achats, la page se "casse" dans certains cas
	1239	[Fiche produit standard] - Il est possible de saisir des quantit�s � z�ro
	1240	[Univers] - R�gression graphique
	1242	[Widget home page] - R�gression sur l'affichage des produits sur mesure
	1243	[Widget home page] - R�gression sur l'affichage des produits collection + ajout au panier possible
	1244	[Page de r�sultat de recherche] - les �l�ments de la page de r�sultats de recherche ne respecte pas la disposition officielle
	1246	[Comparateur] l'image du bouton "Trouvez mon magasin" apparait en d�cal�
	1247	[Home page] - Anomalie graphique sur MEA carrousel
	1248	[Store locator] - R�gression sur la recherche de magasin
	1249	[Store locator] - R�gression le bouton �pingler ne fonctionne plus pour un client anonyme
	1250	[Fiche magasin] - R�gression : Le bouton epingler n'est plus affich�
	1251	[Fiche produit standard] - Les visuels secondaires ne sont pas correctement affich�s
	1253	[Liste des meubles collection] La page de liste de meubles d'une collection semble vide.
	1254	[Page famille] Le bouton prec�dent semble d�pass� le cadre imparti lorsque les produits sont en vue liste
	1255	[Store locatore] Une grosse partie du nom du magasin du header est cach� par l'input de recherche
	1256	[Store locator] - Il y a trop d'a�ration entre le titre et le fil d'ariane
	1258	[Fiche produit standard] - Anomalies sur la zone des visuels
	1259	[Fiche produit sur mesure] - Les visuels secondaires ne sont pas correctement affich�s
	1260	[Fiche produit sur mesure] - Affichage du visuel en mode zoom
	1261	[Fiche produit collection] - Affichage du visuel en mode zoom
	1262	[Fiche produit standard] - Anomalies graphique sur les visuels secondaires
	1263	[Fiche magasin] - Le bouton epingler gris� est cliquable
	1264	[Search produit] - Ajout � la liste d'achat impossible suite � l'application de facettes
	1265	[Fiche produit standard] - caract�res non autoris�s sur le champ quantit�
	1266	[Search contenus] - Perte des facettes
	1267	[Store locator] - R�gression sur la gestion de la recherche de magasin
	1268	[Search produit] - Gestion des facettes
	1273	[Quick view] - Les pictos sont trop gros et n'ont pas la m�me taille que sur la fiche produit
	1276	[Home page] - Probl�me d'affichage de l'image de fond d'une MEA liens
	1278	[Home du mag] -R�gression : Le push produit ne s'affiche plus
	1279	[Home du mag] -R�gression : Anomalie graphique sur le titre de la section battle
	1284	[Fiche magasin] - R�gression graphique importante

	[Integration]
	607		[Produit] [Item]- suppression de SKU - Flux produit
	1056	Export Client


versiov v0.1.16
---------------
	572 [Home page] - Anomalies graphiques sur une MEA carrousel
	806 [Fiche magasin] - Il manque le s�parateur horizontal en dessous de la zone des adresses
	888 [Home du mag] - Anomalie graphique sur le push produit - fleches a centrer
	284	[BO CMS] - Cr�ation d'article �ditorial impossible avec un profil contributeur
	300	[BO CMS] - Droits sur un valideur
	315	[BO CMS] - Impossible de cr�er un article dans un dossier �ditorial avec un profil publieur
	355	[Contenu article] - Zone recommander cet article
	358	[Contenu article] - Pagination anomalies graphiques
	359	[Home du mag] - A�ration autour du fil d'Ariane
	362	[Home du mag] - Anomalies graphiques sur le push produit
	366	[Home du mag] - A�ration entre les titres et les contenus
	367	[Home du mag] - Section "La parole LAPEYRE"
	369	[Home page] - MEA liste de liens
	376	[Fiche produit] la zone d'onglet "Description d�taill�" est vide cependant elle est tout de m�me affcih�e
	388	[Facette sur les promos] l'ordre d'affichage de la facette sur les promos n'est pas le bon
	411	[Store locator] - Etat �pingl� dans une pin
	419	[Fihe produit collection] La r�f�rence de l'article pour les collections ne doit pas �tre affich�
	474	[Search contenus] - Anomalies graphiques sur l'onglet contenu
	479	[Famille] - Anomalies graphiques dans le carrousel de contenus (cross-content)
	482	[Article �ditorial] - Anomalies graphiques zone de cross-content
	518	[Contenu article] - Anomalie graphique sur un article sans sur-titre
	536	[Univers] - Anomalies graphiques zone haute
	561	[Contenu �ditorial] - Anomalie graphiques sur les produits li�s
	599	[BO CMS] - Noeud d'arborescence propos� alors qu'il n'existe pas sur le front
	644	[Page de liste de meubles] Les produits de la page de liste de meuble d'une collection ne respecte pas l'ordre des s�quences WCS
	741	[Recherche Produit] La facette de range de prix n'est pas bonne apr�s avoir effectu� une recherche
	752	[BO CMS] - Taille du champ accroche d'une MEA carrousel
	760	[Page Famille Collection] La facette de Promotion s'affiche � tord apr�s une premi�re s�lection de facette
	831	[Fiche Produit grille] La quickView s'ouvre mais ne se voit pas sous IE10 � moins de scroller
	842	[Home page] - Anomalie graphique sur une MEA liens
	895	[Article] - Anomalies graphiques sur la zone "pour aller plus loin"
	906	[Search contenus] - R�sultats obtens sur termes inexistants
	922	[Store locator] - Probl�me sur l'action "Y aller"
	941	[Article] - Zone description de l'auteur
	958	[Management center] - Page d'accueil du mode preview
	965	[Search contenus] - Anomalie graphique sur zone onglets
	968	[Fiche Produit collection] - la zone mes options apparait � tort pour le produit collection
	973	[Menu de navigation du mag] - Anomalies graphiques sur le menu du mag
	974	[Menu de navigation instit] - Anomalies graphiques sur le menu des pages institutionnels
	976	[BO CMS] - Pas de message de confirmation sur la mise � jour d'une fiche magasin
	994	[Dossier] - Anomalie graphique sur le footer
	1015	[Fiche magasin] - Anomalies graphiques sur la fiche magasin
	1018	[Fiche magasin] - Le picto �pingl� ne se met pas � jour sur la pin magasin
	1044	[Facetting produit] - Difficult� pour fermer la popin de facetting
	1045	[Menu de navigation] - Lien "Lapeyre pro"
	1054	[comparateur] Les valeurs des attributs pr�sents dans le comparateur doivent �tre ceux de l'article mod�le
	1076	[Preview management center] - Probl�me sur le widget s�lection du mois
	1093	[Famille] - Anomalies graphiques en mode liste
	1105	[Selection de facette] la facette de type swatch color s'affiche mal dans le bloc "ma selection"
	1120	[Store locator] - R�gression sur l'affichage de la pin
	1136	[Fiche produit standard] - Anomalie graphique swatch s�lectionn�e
	1143	[Fiche produit standard] -La popin de confirmation d'ajout au panier ne s'affiche pas correctement
	1148	[Famille] - La popin de confirmation d'ajout au panier ne se ferme pas lorsqu'on clique en dehors de la zone
	1153	[Liste d'achat] - Ajout d'un produit � une liste d'achat vide
	1155	[Famille] - La zone de tris ne propose plus toutes les valeurs possibles
	1171	[Fiche produit collection] - La vid�o ne s'affiche pas sur iPhone
	1172	[Fiche produit collection] - Picto vid�o ne fonctionne pas toujours
	1173	[Fiche produit collection] - Le picto vid�o n'est pas celui des maquettes
	1174	[Produit collection] les produits collections disposent du bouton achetez vos meubles mais ne dispose d'aucun produit
	1177	[Zone de facette] Apr�s une selection de facette, les facettes retourn�es ne sont pas coh�rentes
	1178	[zone ma selection] lors de la selection d'une facette de type swatch color, l'infobulle ne s'affiche pas dans ma selection
	1180	[Mega Menu] - R�gression sur l'affichage du mega menu
	1188	[zone de facette] De gros espaces blanc sont observ�s entre les valeurs de facette
	1190	[Zone de facette] La borne inferieur du slider de prix n'est pas correct
	1194	[Search] - R�gression sur le bouton suivant de la pagination
	1197	[Fiche produit standard] - Anomalie graphique d'alignement
	1198	[Fiche produit sur mesure] - Anomalie graphique
	1199	[Fiche produit collection] - L'�co part n'est pas affich�e au bon endroit
	1200	[Fiche produit collection] - La r�f�rence ne doit pas �tre affich�e
	1206	[comparateur] l'image du bouton "Achetez vos meubles" apparait en d�call� sur le bouton
	1207	[Cross sell & cross content] - R�gression Les zones de cross ne s'affichent plus
	1209	[Fiche produit standard] - Anomalie graphique zone mes options

[Integration]
	66	[univers] Zone de widget Non affich�e sur les pages univers
	112	Fonctionnement du bouton � la liste d'achat
	117	Acc�s au comparateur de prix al�atoire
	495	WS � utiliser en PPR
	507	Prix carrelage diff�rent entre fiche produit et ajout au panier
	590	Fiche Produit Standard - reference de l'article par d�faut erron�e



versiov v0.1.15
---------------
	249	[G�olocalisation] - Le partage de position est demand� en permanence
	254	[Header] - Lien vers l'espace "Mon compte"
	287	[mode Liste] Saisi de lettre possible dans le champ quantit�
	297	[Liste d'achat] Erreur lors de l'ajout d'un produit � une liste d'achat.
	306	[BO CMS] - Ordre des univers de facette
	308	[Recherche] les lib�ll�s des sections de l'autocompl�tion ne sont pas les bons
	346	[Contenu article] - Probleme graphique d'a�ration sur-titre
	350	[Contenu article] - Typo sur le nom de l'auteur
	352	[Contenu article] - Chevron affichage de la description de l'auteur
	400	[Store locator] - Bouton epingler gris�
	467	[Search contenus] - Valeur de facette longue
	598	[Home page] - MEA carrousel anomalie graphique titre contenu 2 et 3
	696	[Fiche Produit] Connect� en tant que PRO, le prix de l'�co part doit �tre suivi de la mention HT.
	717	[Fiche produit standard] La liste des pictos doit se faire sur une ligne de 4 picto maximum
	730	[Header] - Mega menu au survol de la souris
	756	[BO CMS] - Publication � date d'un dossier �ditorial
	775	[Store locator] - Demande permanente de validation de partage de position
	788	[Store locator] - Map non utilisable dans certains cas
	797	[Fiche Produit collection] Mauvais lib�ll� pour la zone de visuel secondaires
	801	[Fiche magasin] - Arrondi des notes
	818	[Fiche produit standard] La Fiche produit standard n'est pas conforme aux maquettes
	824	[Fiche Produit standard] La fiche produit standard en mode grille n'est pas conforme aux maquette
	826	[Zone de facette] Lors de l'expand des valeurs de facette, le nombre de produit devant figurer entre paranth�se ne s'affiche pas
	827	[Fiche Produit sur Mesure] La fiche produit sur mesure en mode grille n'est pas conforme aux maquettes
	836	[Fiche produit sur mesure] La zone de prix et la zone d'en dessous ne sont pas conforme aux maquettes.
	864	[Page Univers] - Mobile: Le nom de l'univers ainsi que les familles de l'univers courant sont repris � tort
	905	[Page Famille] - Mobile: Le libell� du bouton permettant le filtre n'est pas le bon
	906	[Search contenus] - R�sultats obtens sur termes inexistants
	924	[Fiche Produit standard] - La fiche produit standard n'est pas conforme aux maquettes
	931	[Fiche Produit] le visuel secondaire selectionn� n'est pas entour� d'un liser� gris
	939	[store locator] Les magasins pr�f�r�s ne s'affichent plus quand l'utilisateur connect� a refus� la g�olocalisation
	943	[Search contenus] - Zone de tris et comportement �trange
	946	[Fiche Produit sur mesure] - Mobile: non conforme au maquette
	948	[Fiche produit sur mesure] - Mobile: le bouton d'ajout � la liste d'achat est pr�sent � tort
	949	[Fiche produit sur mesure] - Mobile: le bouton trouver mon magasin est pr�sent � tort
	955	[Fiche Produit collection] Le bouton d'ajout � la liste d'ache appara�t � tort
	966	[Comparateur] les lib�ll�s des boutons doivent �tre sur une seule ligne
	991	[Search contenus] - L'ordre des valeurs de facette n'est pas celui param�tr� dans le BO CMS
	993	[Dossier] - Anomalies graphiques d'un dossier en vue liste dans un r�sultat de recherche
	1004	[BO CMS] - Recherche de tags non propos�e
	1005	[BO CMS] - Magasin - Le champ r�gion doit �tre une liste d�roulante
	1016	[Home page] - Probleme d'affichage MEA 33%
	1017	[Home page] - MEA vignette sans accroche
	1019	[Store locator] - R�gression sur la recherche de magasins
	1022	[Fiche Produit standard] Les picto ont des tailles diff�rentes d'une zone � lautre
	1031	[Comparateur] - Anomalies graphiques sur le comparateur
	1034	[G�olocalisation] - Le partage de position doit �tre accept� plusieurs fois
	1037	[Univers] - Anomalies graphiques sur la page univers
	1050	[Article] - Probl�me de navigation sur la page
	1059	[Store locator] - R�gression sur le picto y aller
	1067	[page famille] Lors du clic sur les boutons de pagination des produit d'une famille, le temps de chargement est tr�s long
	1078	[Search produit] - Affichage de l'�co-part
	1082	[Fiche Produit collection] la petite fl�che permettant de plier ou d�plier la section Produits compl�mentaires ne fonctionne pas
	1088	[Fiche produit standard] - L'info bulle mes options n'appara�t jamais
	1090	[Famille] - L'�co-part ne doit pas �tre affich�e en mode liste
	1091	[Famille] - Anomalie graphique sur la zone de s�lection
	1092	[Famille] - Anomalies graphiques zone de facette
	1095	[Fiche produit catalogue] - Le champ quantit� ne doit pas appara�tre sur une fiche produit catalogue
	1097	[Quick view] - Un texte "Unit�" pr�c�d� du prix est affich�
	1100	[Fiche produit sur mesure] - Anomalies graphiques
	1107	[BO CMS] - Valeur de pagination qui dispara�t dans la recherche magasin
	1125	[Fiche produit sur mesure] la mention prix selon compo type apparait alors que le produit ne dispose pas de prix
	1132	[Ajout au panier] - Popin de confirmation d'ajout au panier
	1135	[Ajout au panier] - Ajout de produit avec une quantit� importante
	1137	[Fiche produit standard] - Les pictos ne sont pas affich�s au bon endroit dans le corps de la fiche produit
	1138	[Fiche produit standard] - Anomalie graphique sur le descriptif d�taill�
	1139	[Comparateur] - Un catalogue papier ne doit pas pouvoir �tre ajout� � la liste d'achat
	1140	[Header] - Le nombre de produits dans le panier affiche un caract�re sp�cial
	1144	[search produit] - La recherche sur certains termes g�n�re une page cass�e avec des messages d'erreurs
	1149	[Fiche produit standard] - Le clique sur le titre d'une zone du corps masque les informations
	1150	[famille] - Mauvais libell� de bouton de la liste d'achats
	1151	[Famille] - Ajout � la liste d'achat g�n�re une mauvaise redirection puis une page d'erreur
	1152	[Univers] Le clic sur un univers a pour effet de surligner le libell� de l'univers sans nous rediriger sur la page univers
	1153	[Liste d'achat] - Ajout d'un produit � une liste d'achat vide
	1154	[Sticky header] - Anomalie graphique pour un client pro
	1157	[Store locator] - Les liens sur le mot du directeur ne sont pas visibles facilement

 [Int�gration]
	492	Recherche KO avec caract�res sp�ciaux
	497	Cr�ation d'un compte client via synchronisation CRM KO
	502	Mention "non transformable en ligne" absente dans liste d'achat
	504	Format n� de tel dans bloc adresse
	505	Bloc adresse : hauteur fixe + Libell� civilit�
	556	Chemin de fer absent de la page d'identification
	579	[Produit] - Unit� Vente et unit� colisage identique - coef de conversion 1 - le convertisseur s'affiche
	795	Synchro CRM Pro KO
	800	Erreur � la r�cup des commandes du client
	820	PLantage sur recherche de devis
	821	ACCELERATOR : planatge � la consulmtation d'une commande
	898	Liste des commandes magasins - pbs
	900	Commandes web non affich�e si pas de statut ARC
	1013	ACCELERATOR : Bouton "flagger comme envoy�" ne fonctionne pas sur les commandes catalogue
	1014	Email Confirmation de commande : L'objet du mail est vide
	1046	Tag Manager non appel� sur tout l'espace client
	1047	carrousel cr�neau drive : appeler le CMS sur des tranches de 12 jours
	1048	Magasins sans modes de livraison propos� dans le tunnel
	1057	Synchro PRo -> le client est transform� en PART
	1158	Montant total est augment� lors d'ajout d'un coupon


versiov v0.1.14
---------------
	231 [zone de tri] Dans les pages familles affichant des produits, la liste d�roulante ne dispose pas des bons libell�s de crit�re
	284	[BO CMS] - Cr�ation d'article �ditorial impossible avec un profil contributeur
	300	[BO CMS] - Droits sur un valideur
	315	[BO CMS] - Impossible de cr�er un article dans un dossier �ditorial avec un profil publieur
	319	[Contenu dossier] - Typo du titre et du sous-tire
	364	[Famille] L'ordre par defaut des produits figurants dans la page famille doit �tre l'ordre WCS
	370	[probl�me de donn�es] Aucune facette de type swatch couleur de trouver au niveau du front
	389	[Facette de marque] Les valeurs de facette de marque s'affichent m�me si aucun produit ne r�pondent aux crit�res
	445	[Fiche produit sur mesure] - Zone magasin anomalies graphiques
	486	[Contenu �ditorial] - Contenu �ditorial sans temps de lecture
	523 [store Locator] A la modification de l'adresse de l'utilisateur, le magasin du header ne se met pas � jour
	640	[Zone de facette] Lorsqu'il y a un certain nombre d'attributs pour une facette, ceux ci ne sont pas align�s
	644	[Page de liste de meubles] Les produits de la page de liste de meuble d'une collection ne respecte pas l'ordre des s�quences WCS
	710	[Fiche magasin] - Les liens hypertextes ajout�s dans le mot du directeur ne fonctionne pas
	760	[Page Famille Collection] La facette de Promotion s'affiche � tord apr�s une premi�re s�lection de facette
	838	[Home page] - Ajout au panier dans le widget produit
	903	[Page Famille] - Mobile: Le libell� prix pour les dimensions est tronqu� � tord
	909	[Search contenus] - Recherche et totaux de facette � z�ro
	912	[Search contenus] - Recherche et facetting avec un double comportement
	938	[Article] - El�ments du carrousel coup�s en 2
	992	[Search contenus] - Les facettes de contenus ne fonctionne pas en entenoir comme sur les produits
	994	[Dossier] - Anomalie graphique sur le footer
	1042 [Fiche magasin] - Il manque un s�parateur horizontal en pointill� au dessus du titre de la zone des services
	1077 [Fiche produit collection] - Zone de prix
	1083 [Fiche produit] Le description long contient trois petits point � la fin  laissant croire qu'il est tronqu�
	1086 [Fiche produits] - Taille des pictos
	1098 [Quick view] - Le prix pour la dimension doit �tre align� � gauche
	1099 [Fiche produit standard] - Anomalies graphiques zone de titre + prix pour la dimension
	1100 [Fiche produit sur mesure] - Anomalies graphiques  

versiov v0.1.13
---------------
	254	[Header] - Lien vers l'espace "Mon compte"
	260	[Header] - Mega menu graphisme
	284	[BO CMS] - Cr�ation d'article �ditorial impossible avec un profil contributeur
	300	[BO CMS] - Droits sur un valideur
	302	[BO CMS] - Droits du responsable magasin
	315	[BO CMS] - Impossible de cr�er un article dans un dossier �ditorial avec un profil publieur
	324	[Contenu dossier] - Article d'un dossier ajustements graphiques
	414	[Store locator] - Initialisation de la carte (refus de partage de position)
	432	[Store Locator] La carte n'est pas centr� sur le magasin sur lequel la derni�re interrogation stock a �t� effectu�
	513	[BO CMS] - Modification d'un article "refus� par un valideur" impossible
	534	[BO CMS] - Le dashboard d'un valideur se rafra�chit mal
	600	[BO CMS] - Chargement et rechargement d'une page de modification de MEA
	634	[Home page] - MEA vignette avec des articles non publi�s
	717	[Fiche produit standard] La liste des pictos doit se faire sur une ligne de 4 picto maximum
	730	[Header] - Mega menu au survol de la souris
	752	[BO CMS] - Taille du champ accroche d'une MEA carrousel
	780	[Store locator] - Itin�raire non utilisable sur mobile
	782	[Store locator] - Probl�me d'affichage sur le r�sultat de recherche
	789	[Store locator] - Recherche sans r�sultat
	790	[Store locator] - Initialisation de la carte de France
	796	[FIche produit collection] La fiche produit collection n'est pas conforme aux maquettes
	799	[Fiche magasin] - Anomalie graphique sur la zone des services
	808	[Fiche magasin] - La popin de partage par email d'une fiche magasin n'est pas utilisable
	818	[Fiche produit standard] La Fiche produit standard n'est pas conforme aux maquettes
	836	[Fiche produit sur mesure] La zone de prix et la zone d'en dessous ne sont pas conforme aux maquettes.
	887	[Home du mag] - Le push produit s'efface et devient inutilisable
	918	[Dossier] - Le titre doit �tre affich� sur un maximum de 3 lignes en vue liste
	932	[Fiche produit standard] La fiche produit standard promo est non conforme au maquette
	940	[Store Locator] Comportement bizarre lors du clic sur le bouton �pingler de la pin dans la fiche magasin
	946	[Fiche Produit sur mesure] - Mobile: non conforme au maquette
	952	[Fiche produit collection] - Mobile: Fiche produit collection non conforme au maquette
	968	[Fiche Produit collection] - la zone mes options apparait � tort pour le produit collection
	971	[Fiche magasin] - Zone de partage et icone qui s'efface
	977	[BO CMS] - La pagination de la recherche magasin g�n�re un affichage tr�s d�grad�
	1008	[Page de r�sultat de recherche] Titre de produit � rallonge sur 4 lignes
	1022	[Fiche Produit standard] Les picto ont des tailles diff�rentes d'une zone � lautre
	1024	[Recherche Produit] l'ordre d'affichage des produits de la recherche n'est pas le bon
	1026	[Recherche produit] - La taille des visuels des produits issus du r�sultat de recherche est �norme
	1027	[Resultat de recherche] la page de r�sultat  de recherche en mode liste n'est pas conforme
	1031	[Comparateur] - Anomalies graphiques sur le comparateur
	1033	[Famille] - Affichage tr�s d�grad�
	1036	[D�connexion automatique] - Probl�me sur le bouton connexion suite � une connexion expir�e
	1037	[Univers] - Anomalies graphiques sur la page univers
	1053	[fiche produit] La typologie des titres des zones d'onglet est diff�rentes d'un mot � l'autre
	1059	[Store locator] - R�gression sur le picto y aller
	1060	[Home du mag] - Probleme de carrousel d�form�
	1061	[Fiche Produit Standard] la petite fl�che permettant de plier ou d�plier la section Acc�ssoires ne fonctionne pas
	1062	[Fiche Produit Standard] la petite fl�che permettant de plier ou d�plier la section Produits compl�mentaires ne fonctionne pas
	1063	[fiche Produit] la petite fl�che permettant de plier ou d�plier les informations de description d�taill� ne fonctionne pas
	1065	[BO CMS] - Probleme sur la pagination des tags
	1068	[Page famille] Les visuels des produits de la page famille sont �tir�s en longueur sur le Samsung S4
	1071	[fiche produit collection] Erreur lors de l'acc�s � une fiche produit collection
	1072	|Fiche produit collection] La zone de picto n'est pas du tout conforme aux maquettes
	1075	[Home du mag] - L'article free HTML ne s'affiche pas sur la home du mag
	1079	[Article] - Le carrousel est d�form� et prend la totalit� de l'�cran

  [Int�gration]
	10	Navigateur IE10 - compatibilit� 7 ou 8 ou 9 rejet�
	11	Flux "Produits"
	30	Flux "Promotions"
	497	Cr�ation d'un compte client via synchronisation CRM KO
	502	Mention "non transformable en ligne" absente dans liste d'achat
	504	Format n� de tel dans bloc adresse
	505	Bloc adresse : hauteur fixe + Libell� civilit�
	556	Chemin de fer absent de la page d'identification
	579	[Produit] - Unit� Vente et unit� colisage identique - coef de conversion 1 - le convertisseur s'affiche
	605	[TAG MANAGER] env_template vaut "home" sur la home du Mag
	792	[CMS] Imossible de r�cup�rer les horaires Drive sur un magasin
	794	Impossible de changer le nom d'une adresse (nickname)
	795	Synchro CRM Pro KO
	800	Erreur � la r�cup des commandes du client
	820	PLantage sur recherche de devis
	821	ACCELERATOR : planatge � la consulmtation d'une commande
	840	fermeture image zoom : provoque un plantage
	855	Export commande : champs manquants
	868	[MOBILE] Page panier : disponibilit� illisible
	869	[MOBIL] Header et fil ariane KO sur page identification
	870	[MOBILE] Recap Panier Coup� dans le tunnel
	871	[MOBILE] Adresse de livraison non affich�e en page de paiement si retrait magasin
	898	Liste des commandes magasins - pbs
	900	Commandes web non affich�e si pas de statut ARC
	980	Flux Commande WCS - EAI KO - erreur mapping
	982	[Client] - int�gration client
	1013	ACCELERATOR : Bouton "flagger comme envoy�" ne fonctionne pas sur les commandes catalogue
	1014	Email Confirmation de commande : L'objet du mail est vide
	1046	Tag Manager non appel� sur tout l'espace client
	1047	carrousel cr�neau drive : appeler le CMS sur des tranches de 12 jours
	1048	Magasins sans modes de livraison propos� dans le tunnel
	1057	Synchro PRo -> le client est transform� en PART
 
 
versiov v0.1.12
---------------

Int�gration:
	497		Cr�ation d'un compte client via synchronisation CRM KO
	795		Synchro CRM Pro KO
	821		ACCELERATOR : planatge � la consulmtation d'une commande
	800		Erreur � la r�cup des commandes du client
	1014	Email Confirmation de commande : L'objet du mail est vide
	900		Commandes web non affich�e si pas de statut ARC
	898		Liste des commandes magasins - pbs
	502		Mention 'non transformable en ligne' absente dans liste d'achat
	579		[Produit] - Unit� Vente et unit� colisage identique - coef de conversion 1 - le convertisseur s'affiche
	
Recette Fonctionnelle:	
	811		[Fiche magasin] - La carte Google n'est jamais affich�e sur la fiche magasin
	710		Fiche magasin] - Les liens hypertextes ajout�s dans le mot du directeur ne fonctionne pas
	937		[Store locator] - Regression : Le champ ouverture exceptionnelle et son titre ne sont pas centr�s
	430		[Fiche magasin] - T�l�chargement des coordonn�es GPS invalide
	972		[Fiche magasin] - Le bouton itin�raire ne fonctionne pas
	816		[Store locator] - Le bouton itin�raire n'a plus de libell�
	970		[Fiche magasin] - Fermeture de la popin GPS "casse" l'affichage
	971		[Fiche magasin] - Zone de partage et icone qui s'efface
	1032	[Fiche magasin] - Clique sur le bouton epingler et popin de confirmation absente
	786		[Store locator] - Clique sur le bouton epingler
	774		[Store locator] - Le titre de la page n'est pas affich�
	747		[BO CMS] - Home du mag push produit via des cat�gories
	709		[BO CMS] - Mise � jour du champ "Mot du directeur"
	462		[Cross-content] - Les tags correspondent alors que les mots sont diff�rents
	733		[Home du mag] - Plus rien ne s'affiche sur la home du mag
	513		[BO CMS] - Modification d'un article "refus� par un valideur" impossible
	312		[BO CMS] - Tags non accessibles
	302		[BO CMS] - Droits du responsable magasin
	300		[BO CMS] - Droits sur un valideur
	315		[BO CMS] - Impossible de cr�er un article dans un dossier �ditorial avec un profil publieur
	284		[BO CMS] - Cr�ation d'article �ditorial impossible avec un profil contributeur
	727		[Home page] - Widget s�lection du mois anomalies graphiques
	847		[Home page] - Anomalie graphique widget s�lection du mois
	850		[Home page] - Seule la zone de recherche doit rester en sticky lors d'un scroll vertical dans la descente catalogue
	849		[Home page] - Sticky header page institutionnels
	848		[Home page] - Il n'y a pas de sticky header sur la home du mag
	723		[Home page] - Navigation dans le carrousel d'un widget
	843		[Home page] - MEA vignette et champ accroche MEA
	257		[Header] - Affichage du pr�nom et du nom d'un client professionnel
	461		[Cross-content] - Tags avec plusieurs mots ne fonctionne pas et emp�che la mise en relation famille-CMS
	896		[Article] - Anomalies graphiques sur la zone "retrouver les produits lapeyre concern�s par cet article"
	990		[MEA free HTML] - Le style diverge d'une page � l'autre pour une m�me MEA
	515		[Contenu article] - Anomalie graphique sur le sur-titre
	477		[Famille] - Manque l'affichage du type dans le carrousel de contenus (cross-content)
	1041	[Famille] - R�gression sur le cross-content
	1012	[Liste d'achat] Impossible d'acc�der � notre liste d'achat
	985		[Page de r�sultat de recherche] La mention "X r�sultat pour [mot saisi]" ne devrait pas �tre affich�e
	969		[produit catalogue]Le bouton d'ajout au panier n'apparait pas sur la fiche produit catalogue alors qu'il devrait apparaitre.
	967		[Fiche Produit collection] Les informations de description d�taill�e non affich�e bien qu'elles soient pr�sente sur desktop
	950		[Fiche produit sur mesure] - Mobile: les informations de description d�taill�e n'apparaissent pas bien qu'elles existent
	945		[fiche Produit] Les visuels secondaires de la fiche produits doivent �tre dispos�s de 5 vignettes par lignes
	933		[Fiche Produit standard Promo] Le bouton d'ajout au panier n'est pas visible pour le produit standard suivant:FPC1208490
	925		[Fiche Produit standard] La description d�taill�e n'est pas reprise pour le mobile  alors qu'elle est bien pr�sente
	689		[Fiche produit] Le  long description sup�rieur � 150 caract�res est affich� � la place du b�n�fice client
	582		[Produit catalogue] Produit catalogue avec un prix � 0 est affich� sur Front � tort.
	1009	[Facette]: Les facettes ne sont pas d�plier par d�faut conform�ment aux maquettes
	930		[Fiche Produit Standard] la petite fl�che permettant de plier ou d�plier la section produits complementaires est absente
	929		[Fiche Produit Standard] la petite fl�che permettant de plier ou d�plier la section Acc�ssoires est absente
	928		[fiche Produit] la petite fl�che permettant de plier ou d�plier les informations de description d�taill� est absente
	954		[Fiche produit collection] - Mobile: Les visuels secondaires n'apparaissent pas sous forme de carroussel de gauche � droite
	926		[fiche produit] Le titre du produit est masqu� par l'input de recherche produit
	830		[Fiche Produit] Le zoom sur le visuel principal est coup� sous IE11
	744		[Fiche produit collection] La zone principale de visuel secondaire semble cr�er un mauvais effet sur les visuels
	822		[Menu] Le sous menu ne s'affiche pas au niveau de la page d'identification
	832		[Page de liste des meubles] La page de liste des meubles en vue liste met plus de 40 secondes � s'afficher
	961		[Management center - preview] - La d�connexion g�n�re un message d'erreur qui paralyse le mode preview

version v0.1.11
---------------
Recette Fonctionnelle:
        938     [Article] - El�ments du carrousel coup�s en 2
        936     [Store locator] - Regression : Les titres de certaines sections sont maintenant sur plusieurs lignes
        921     [catalogue] lors de la fermeture de la popin d'ajout au comparateur je suis redirig� vers une page avec ecrit False
        899     [Page Univers] - Mobile: Espace entre le descriptif de l'univers et le visuel de la premi�re famille de l'univers courant
        897     [Page Univers] - Mobile: La page univers n'est pas conforme � la maquette
        881     [Home page] - Le champ sous-titre d'une MEA banni�re doit s'afficher sur une ligne
        878     [Footer] - Probl�me de popin sur l'inscription � la newsletter
        865     [Page Univers] - Mobile: Le nom des familles doit apparaitre sur le visuel de la famille
        810     [Fiche magasin] - La popin de partage des coordonn�es gps dispose d'un affichage d�grad�
        807     [Fiche magasin] - Affichage des num�ros de t�l�phones secondaires
        806     [Fiche magasin] - Il manque le s�parateur horizontal en dessous de la zone des adresses
        799     [Fiche magasin] - Anomalie graphique sur la zone des services
        789     [Store locator] - Recherche sans r�sultat
        754     [Footer] - Anomalie graphique avec 6 MEA liens
        675     [Home page] - MEA liens de 33% avec des boutons non conformes
        674     [Home page] - MEA liens de 50%
        657     [Home page] - MEA liste de liens sur 2 lignes
        511     [Contenu dossier] - Accroche d'un dossier masqu�e
        418     [Store locator] - Popin de confirmation d'�pinglage anomalies graphiques
        368     [Home page] - Affichage du sous-tire d'une MEA banni�re
        247     [Liste d'achats] - Popin de cr�ation d'une liste d'achats
        246     [Comparateur] - Popin ajout de produit impossible
        918     [Dossier] - Le titre doit �tre affich� sur un maximum de 3 lignes en vue liste
        917     [Dossier] - La taille de la typo du titre est trop importante en vue liste
        915     [Dossier] - Le champ accroche est masqu� par le titre
        913     [Dossier] - La taille de la typo du titre est trop importante
        891     [Article] - La taille de la typo du titre en vue liste est trop importante
        844     [Home page] - La MEA carrousel ne s'affiche jamais
        245     [Header] - Lien pour le suivi de devis et de commandes
        839     [Home page] - Il manque le bouton suivre ma commande
        902     [Page Famille] - Mobile: La page Famille ne doit pas afficher l'univers courant et les familles de l'univers courant
        911     [page Famille] - Mobile: Zone de marketing spot affich� � tort
        910     [Page Univers] - Mobile: MEA univers est affich� � tort
        846     [Home page] - MEA banni�re et mauvaise gestion des droits sur mobile
        886     [Home page] - MEA free HTML et mauvaise gestion des droits sur mobile
        885     [Home page] - MEA vignette et mauvaise gestion des droits sur mobile
        884     [Home page] - MEA liste de liens et mauvaise gestion des droits sur mobile
        882     [Home page] - Le bouton d'une slide d'une MEA banni�re ne doit pas �tre affich� sur mobile
        877     [Home page] - Menu lat�ral : Il manque le lien vers la liste d'achats dans le menu lat�ral
        893     [Article] - Le visuel mobile d'un paragraphe n'est jamais affich�
        874     [Home page] - Menu lateral : Lien vers la section Lapeyre pro
        879     [Fiche magasin] - Il manque un s�parateur horizontal au dessus du titre de la zone le mot du directeur
        880     [Fiche magasin] - Il y a trop d'espaces entre chaque zone
        876     [Header] - Il manque le libell� "PANIER" en dessous du picto du panier du header
        477     [Famille] - Manque l'affichage du type dans le carrousel de contenus (cross-content)
        834     [Home page] - Le visuel small n'est jamais affich� sur une MEA banni�re
        397     [Store locator] - Ordre d'affichage des num�ros de t�l�phones secondaires
        809     [Fiche magasin] - Les services ne sont jamais affich�s
        779     [Store locator] - Zone de recherches anomalies graphiques
        784     [Store locator] - Le message d'erreur est coup� sur une recherche infructueuse
        739     [Fiche produit] Le zoom sur le visuel non disponible ne devrait pas �tre possible
        
Int�gration:
        792     [CMS] Imossible de r�cup�rer les horaires Drive sur un magasin
        869     [MOBIL] Header et fil ariane KO sur page identification
        868     [MOBILE] Page panier : disponibilit� illisible
        870     [MOBILE] Recap Panier Coup� dans le tunnel
        855     Export commande : champs manquants
        871     [MOBILE] Adresse de livraison non affich�e en page de paiement si retrait magasin

version v0.1.10
--------------
	231	[zone de tri] Dans les pages familles affichant des produits, la liste d�roulante ne dispose pas des bons libell�s de crit�re
	240	[Produit standard] les produits standards en vue liste et en vue grille ne disposent pas des m�mes informations
	406	[Store locator] - Graphisme pin d'un magasin
	422	[Store locator] - Zone de magasins tri�s par code postal
	438	[Fiche magasin] - Horaires Drive
	552	[Comparateur] Le produit topp� PROMO perd le bandeau quand il est ajout� au navigateur
	553	[Comparateur] Le titre des produits ajout�s au comparateur de produit doivent �tre en gras
	554	[Liste d'achat] Ajout� � la liste d'achat, les produits topp� PROMO n'ont plus le bandeau rouge
	560	[Fiche Produit] [Vue Grille] Griser le bouton d'ajout au panier si pas de prix
	567	[Catalogue] - Probl�me d'alignement de 3 MEA banni�res de 33%
	609	[Home du mag] - La home est devenue inaccesible suite � des modifications
	733	[Home du mag] - Plus rien ne s'affiche sur la home du mag
	774	[Store locator] - Le titre de la page n'est pas affich�
	776	[Store locator] - 2 pins sont affich�s pour un seul magasin
	782	[Store locator] - Probl�me d'affichage sur le r�sultat de recherche
	804	[Fiche magasin] - Le bouton epingler et la fleche blanche ne sont pas centr�s
	805	[Fiche magasin] - Le picto "epingler" sur l'image est affich� sur le type du magasin
	807	[Fiche magasin] - Affichage des num�ros de t�l�phones secondaires
	813	[Fiche magasin] - Affichage des ouvertures exceptionnelles
	814	[Fiche magasin] - Anomalies graphiques sur la zone du mot du directeur
	817	[Store locator] - S�parateurs en trop
	832	[Page de liste des meubles] La page de liste des meubles en vue liste met plus de 40 secondes � s'afficher
	843	[Home page] - MEA vignette et champ accroche MEA
	851	[BO CMS] - Affichage d'un caract�re sp�cial dans la zone auteur
	854	[Univers] Le visuel au niveau de l'univers ne s'affiche pas sous IE11
	857	[Fiche produit] Les pictogrammes ne s'affichent pas au niveau de l'ent�te de la fiche produitet au niveau du corps


version v0.1.9
--------------
	212	[Header] - Zone de recherche
	213	[Header] - Zone magasin
	215	[Header] - Zone panier
	248	[Header] - Texte par d�faut zone magasin
	250	[Header] - Magasin affich� dans le header sans num�ro de t�l�phone
	254	[Header] - Lien vers l'espace "Mon compte"
	255	[Header] - Lien "Se d�connecter" pour un client particulier
	257	[Header] - Affichage du pr�nom et du nom d'un client professionnel
	298	[Liste d'achat] Impossible de creer une liste d'achat avec un nom poss�dant une apostrophe
	326	[Contenu dossier] - Perte du sur-titre sur un dossier en vue liste
	365	[Home du mag] - Images dans le push produit
	377	[BO CMS] - Tri sur l'id m�tier dans la recherche magasin
	402	[BO CMS] - Modification du titre d'un magasin
	403	[Store locator] - Mauvais calcul de la distance
	405	[Store locator] - Croix de fermeture dans info bulle
	426	[Fiche magasin] - Picto QR code non conforme
	430	[Fiche magasin] - T�l�chargement des coordonn�es GPS invalide
	531	[Store Locator] Dans la fiche magasin, lors du clic sur le bouton itin�raire, le champ arriv� n'est pas rempli
	532	[Fiche Magasin] le clic sur le picto "y aller" ne fonctionne pas
	538	[Search] - La MEA banni�re ne s'affiche pas en top
	539	[Search] - La MEA banni�re ne s'affiche pas en bas de l'onglet produit
	540	[Search] - La MEA banni�re ne s'affiche pas en bas de l'onglet contenu
	542	[Search contenus] - R�gression importante sur la recherche des contenus �ditoriaux
	564	[Contenu article] - Probl�me de visuel dans les produits li�s
	565	[Liste de meubles] - Probl�me d'affichage des MEA banni�res
	571	[Home page] - MEA banni�re sans visuel desktop
	574	[Univers] - Affichage d'une MEA carrousel dans la partie top
	575	[Univers] - Affichage d'une MEA carrousel dans la partie bottom
	576	[Famille] - Affichage d'une MEA carrousel
	592	[Search] - La MEA carrousel ne s'affiche pas en top
	593	[Search] - La MEA carrousel ne s'affiche pas en bottom de l'onglet produit
	594	[Search] - La MEA carrousel ne s'affiche pas en bottom de l'onglet contenu
	595	[Liste des meubles] - La MEA carrousel ne s'affiche pas en top
	596	[Liste des meubles] - La MEA carrousel ne s'affiche pas en bottom
	597	[Home page] - MEA carrousel avec 2 contenus
	601	[Home page] - MEA vignette anomalies graphiques
	602	[Home page] - MEA vignette mauvais champ accroche affich�
	603	[Home page] - MEA vignette mauvais champ titre d'un article affich�
	619	[Espot de produit] Le libell�s des boutons doit �tre sur une m�me ligne
	627	[Univers] - Affichage d'une MEA vignette dans la partie top
	628	[Search] - La MEA vignette ne s'affiche pas en bottom de l'onglet contenu
	629	[Search] - La MEA vignette ne s'affiche pas en bottom de l'onglet produit
	630	[Search] - La MEA vignette ne s'affiche pas en top
	631	[Liste des meubles] - La MEA vignette ne s'affiche pas en top
	632	Emplacement des MEA mal sett� si MEA multipositionn�
	633	[Home page] - MEA vignette sans pictos
	635	[Home page] - MEA vignette avec 8 articles
	636	[Home page] - MEA vignette avec 3 articles
	637	[Home page] - MEA vignette de 50%
	638	[Home page] - MEA vignette de 33%
	649	[Univers] - Affichage d'une MEA liens dans la partie top
	650	[Univers] - Affichage d'une MEA liens dans la partie bottom
	651	[Famille] - Affichage d'une MEA liens
	652	[Search] - La MEA liens ne s'affiche pas en bas de l'onglet produit
	653	[Search] - La MEA liens ne s'affiche pas en bas de l'onglet contenu
	654	[Search] - La MEA liens ne s'affiche pas en top
	655	[Liste des meubles] - La MEA liens ne s'affiche pas en bottom
	656	[Liste des meubles] - La MEA liens ne s'affiche pas en top
	657	[Home page] - MEA liste de liens sur 2 lignes
	674	[Home page] - MEA liens de 50%
	675	[Home page] - MEA liens de 33% avec des boutons non conformes
	678	[Home page] - Le titre de la MEA free HTML ne s'affiche pas
	679	[Search] - La MEA free HTML ne s'affiche pas en top
	680	[Search] - La MEA free HTML ne s'affiche pas en bas de l'onglet contenu
	681	[Search] - La MEA free HTML ne s'affiche pas en bas de l'onglet produit
	682	[Univers] - La MEA free HTML ne s'affiche pas en zone top
	683	[Univers] - La MEA free HTML ne s'affiche pas en zone bottom
	684	[Home page] - Probl�me d'affichage de 3 MEA free HTML de taille 33%
	685	[Famille] - La MEA free HTML ne s'affiche pas
	689	[Fiche produit] Le  long description sup�rieur � 150 caract�res est affich� � la place du b�n�fice client
	693	[Recherche Produit] Le libell� "Promotion" appara�t � tort dans la zone de faceting apr�s une recherche
	702	[Store locator] - Un magasin ne doit pas afficher plus de 2 num�ros de t�l�phones secondaires
	703	[Fiche magasin] - Mentions l�gales d'un num�ro de t�l�phone
	705	[Fiche magasin] - Le champ "Ouverture exceptionnel" ne g�re pas les retours chariots
	708	[Fiche produit sur mesure] - Probl�me sur le num�ro de t�l�phone par d�faut d'un magasin
	718	[Fiche Produit-Onglet Accessoires] les produits pr�sent�s dans le caroussel de produits sont coup�s lorsqu'on utilise les fl�che
	719	[Liste d'achat] La popin d'ajout � la liste d'achat ne se ferme pas quand l'utilisateur clic  en dehors de la zone de popin
	720	[Fiche Produit-Onglet produits compl�mentaires] les produits pr�sent�s dans le carrousel de produits sont coup�s
	722	[Home page] - Taille d'un bloc produit dans un widget
	723	[Home page] - Navigation dans le carrousel d'un widget
	735	[Ajout Comparateur] La popin d'ajout au comparateur ne se ferme pas quand on clic en dehors de la popin
	736	[ajout magasin pr�f�r�] La popin d'ajout de magasins pr�f�r�s ne se ferme pas quand on clic en dehors de la popin
	737	[QuickView] La quickView ne se ferme pas quand on clique en dehors de la popin
	738	[Fiche Produit] la fen�tre de zoom sur le visuel principale ne se ferme pas quand on clique en dehors de la fen�tre
	740	[Fiche produit collection] Le titre de la popin de zoom du visuel secondaire d'une collection n'est pas bon
	746	[Home du mag] - Non affichage de certaines MEA
	749	[Liste de meubles] - La MEA free html ne s'affiche pas en zone top
	750	[Liste de meubles] - La MEA free html ne s'affiche pas en zone bottom
	752	[BO CMS] - Taille du champ accroche d'une MEA carrousel
	753	[Header] - Chevauchement entre la zone de recherche et la zone magasin
	762	[Fiche produit] Les visuels secondaires de la fiche produits sont limit�s � 5
	763	[Fiche Produit] Le produit de remplacement qui a �t� configur� pour un produit d�publi� ne s'affiche pas
	764	[Fiche Produit] Le produit de substitution qui a �t� configur� pour un produit d�publi� ne s'affiche pas
	767	[DOSSIER] Mod�le Dossier obligatoire
	768	[Page Famille] Les visuels produits ne s'affichent pas sous IE11
	771	[menu] Les s�parateurs ne sont pas homog�nes
	772	[Selection de Facette] En cliquant sur la croix du bloc "Ma selection" l'attribut n'est pas retir� du bloc
	773	[Popin ajout liste d'achat] Popup d'ajout � la liste d'achat non conforme au maquette
	777	[Store locator] - Le bouton "-" du zoom est inutilisable
	780	[Store locator] - Itin�raire non utilisable sur mobile
	785	[zone de facette] La page ne se recharge pas quand une facette est retir�e de la zone du bloc "Ma selection"
	798	[Fiche produit collection] probl�me sur les visuels secondaires qui affichent une croix

	2	[ASSET PUSH] Nom des processeurs contient un -approved
	3	[ASSET PUSH] Nom des images contient des caract�res sp�ciaux
	27	[CRM] WS d�tail client pro ne contient pas le plafond autoris�
	35	Un produit a 2 items diff�rents qui ont les m�mes valeurs d'attributs de d�finition
	42	Flux relations - test integration
	47	Evolution XSD flux produit
	48	Int�gration Tarifs- Discount prices
	50	[CRM][DetailDevis] Quantit� n�gative sur ligne de devis
	63	Produits "colisage"
	65	Image par d�faut non utilis�e sur la page univers
	67	Ordre des cat�gories non renseign�
	74	[flux Categorie] - Update impossible
	79	Produit avec 2 items qui ont les m�mes valeurs d'att de definition
	81	Libell� tri
	147	[Import JMS] - Modification des attributs de d�finition d'un produit
	204	[Fiche Produit] - ITEM par defaut non affich� (ref et prix)
	217	[Lot 2] Page panier trop d'inclusions de jsp
	494	Page d'accueil formulaires de contact
	496	R�ception mail de confirmation de cr�ation de compte KO
	499	Dans espace client, recherche  de magasin par CP ou ville KO
	501	Affichage liste des produits pr�sents dans la liste d'achat KO
	557	Mauvaise redirection au clic sur picto "horloge" page retrait en magasin
	558	Page de retrait en magasin: Changer de magasin par un CP KO
	559	Cr�ation adresse principale � l'�tranger KO
	570	Modification d'une adresse KO
	663	Nombre d'articles dans le panier persistant quand changement d"identifiant ou deconnexion


version v0.1.8
--------------
	387	[Fiche Produit] La vue liste pour les produits standard en promo n'est pas conforme aux maquettes.
	478	[Famille] La page du comparateur indique aucun produit � comparer � tord
	585	[Produit collection] Pour les collections ayant un prix, il manque la mention � � partir de � qui n'appara�t jamais.
	586	[Produit sur mesure] Le prix doit �tre pr�c�d� de la mention � � partir de � qui n'appara�t jamais
	666	[Fiche Produit] Le libell� � Prix pour la dimension � n'apparait pas sur la fiche produit vignette en mode grille
	716	[Fiche Produit ] Logu� en tant que Pro, lorsque l'item n'a pas de prix, un libell� est affich� avec en plus la mention HT
	729	[Header] - Libell� univers sur 2 lignes


version v0.1.7
--------------
	lot3 : gestion des rewrite d'url

	330	[Search] Mauvais message lors d'une recherche ne renvoyant aucun r�sultat
	348	[Contenu article] - Description sans les retours chariots
	394	[Dispo stock fiche produit standard] - La dispo stock ne fonctionne plus
	396	[Store locator] - T�l�phone par d�faut bloc magasin
	399	[Store locator] - Champ "Chemin d'acc�s"
	401	[Store locator] - Bloc magasin graphisme
	406	[Store locator] - Graphisme pin d'un magasin
	408	[Store locator] - Pin absence des adresses compl�mentaires
	410	[Store locator] - Nombre de num�ros de tels secondaires affich�s sur un bloc magasin
	417	[Store locator] - Libell� t�l�phone principal dans popin de confirmation d'�pinglage
	418	[Store locator] - Popin de confirmation d'�pinglage anomalies graphiques
	421	[Fiche Produit] Certain acc�s � des Fiches produits donne lieu � un chargement assez long
	422	[Store locator] - Zone de magasins tri�s par code postal
	423	[Fiche magasin] - Anomalies graphiques zone haute
	424	[Fiche magasin] - Anomalies graphiques fil d'ariane
	425	[Fiche magasin] - Anomalies graphiques zone d'informations
	427	[Fiche magasin] - Popin pour t�l�charger les coordonn�es GPS trop haute
	429	[Fiche magasin] - Popin de t�l�chargement des coordonn�es GPS anomalies graphiques
	430 [Fiche magasin] - T�l�chargement des coordonn�es GPS invalide
	431	[Fiche magasin] - Zone de services anomalie graphique
	433	[Fiche magasin] - Anomalies graphiques fil d'ariane zone horaires
	434	[Fiche magasin] - Anomalies graphiques bouton itin�raire Google Map
	435	[Fiche magasin] - Dimanche ferm� syst�matique
	436	[Fiche magasin] - Ouvertures exceptionnelles Magasin jamais affich�e
	438	[Fiche magasin] - Horaires Drive
	465	[Search contenus] - Facette "pi�ce de l'habitation" ne fonctionne pas
	466	[Search contenus] - Valeurs de facette "produit" - Les totaux des valeurs s'effacent
	468	[Store locator] - Popin GPS avec 4 fichiers anomalie graphique
	471	[Fiche magasin] - Magasin sans services
	472	[Fiche magasin] - Anomalie graphique magasin avec 9 services
	478	[Famille] La page du comparateur indique aucun produit � comparer � tord
	484	[Contenu �ditorial] - Dossier visuel absent
	488	[Search contenus] - La recherche d'un contenu via un tag ne fonctionne pas
	489	[Search contenus] - Recherche de contenus par le champ "Type"
	509	[Fiche magasin] - Anomalies graphiques sur les avis clients
	510	[Search contenus] - Probl�me sur la recherche par titre d'un contenu
	511	[Contenu dossier] - Accroche d'un dossier masqu�e
	512 [BO CMS] - Impossible de re-proposer un contenu refus�
	517	[Contenu article] - Article sans visuel desktop
	522	[Comparateur] Dans le comparateur, le bouton acheter vos meubles n'a pas le bon style.
	528	[Store Locator] Dans la zone des magasins Lapeyre, les codes postaux ne sont pas align�s entre eux
	533 [Contenu article] - R�gression importante constat�e sur le cross content par les tags
	534 [BO CMS] - Le dashboard d'un valideur se rafra�chit mal
	543	[Fiche magasin] - Anomalie graphique sur les horaires
	546	[Comparateur] Le retrait d'un produit du comparateur ne met pas � jour la page du comparateur
	551	[Catalogue] La r�f�rence qui est affich� sur la fiche produit est la r�f�rence du product et non de l'item
	566	[Catalogue] - Probl�me d'alignement de 2 MEA banni�res de 50%
	567	[Catalogue] - Probl�me d'alignement de 3 MEA banni�res de 33%
	573 [BO CMS] - la publication � date d'une MEA Carrousel ne fonctionne pas
	584	[Fiche produit catalogue] Le bouton d'ajout � la liste d'achat ne doit pas �tre pr�sent pour les fiches produit catalogue
	585	[Produit collection] Pour les collections ayant un prix, il manque la mention � � partir de � qui n'appara�t jamais.
	586	[Produit sur mesure] Le prix doit �tre pr�c�d� de la mention � � partir de � qui n'appara�t jamais
	587	[Fiche magasin] probl�me d'encodage au niveau du layer pour les champs d�part et arriv�e
	618	[Produit sur mesure]. La somme des ecopart est � 0.Dans ce cas l�, elle ne devrait pas s'afficher
	621	[disponibilit� magasin] La date de disponibilit� magasin doit �tre au format dd/mm/yyyy
	639	[Contenu article] - Titre article dans la pagination ne doit pas �tre Titre MEA
	665	[Search contenus] - R�gression importante sur les facettes de contenus
	669	[Espot de produit] Le libell� "Prix pour la dimension" est tronqu� � tort

	92	[FICHE PRODUIT] Liste des pictos limit� � 6
	99	[FICHE MAGASIN] �pingler un magasin en mode non logg�
	226	Carrelage: affichage si prix a 0E
	455	Fiche produit: affichage de la conversion de quantit� carrelage
	520	Logs WS getDetaiLCoupon
	550	Affichage des swatchs KO [Vue page et vue liste]
	591	Fiche Produit Standard - reference de l'article par d�faut erron�e
	625	[Cross-Content] Appel erron�



version v0.1.6
--------------
	Feature suivi de commande

	206	[Lot 2] Page non centr�e et header mal affich�
	208	[Header] - Sticky header
	209	[Header] - Taille de la typo sur la premi�re ligne du header part
	210	[Header] - Lien Lapeyre pro du menu de navigation
	211	[Header] - Logo diff�rent de la maquette
	214	[Ordre d'affichage des familles] Ordre des familles de l'univers différents
	216	[Header] - Menu navigation
	218	[page univers]Diff�rence entre familles de la page centrale et celle du menu de gauche
	230	[page famille - zone de tri] le lib�ll� "Trier par" n'est pas pr�sent
	231	[zone de tri] Dans les pages familles affichant des produits; la liste d�roulante ne dispose pas des bons libell�s de critère
	234	[Header] - Menu de navigation client PRO
	235 [Produit collection] les produits collectrion en vue liste et en vue grille ne disposent pas des m�mes informations
	238	[zone de pagination] La zone de pagination ne s'affiche que sur la partie supérieur et non sur la partie du bas
	243	[Header] - Sticky header pour la partie "Le mag"
	244	[Header] - Sticky header partie "institutionnelle"
	245	[Header] - Lien pour le suivi de devis et de commandes
	252	[Header] - Num�ro de t�l�phone non format�
	262	[BO CMS] - Arborescence catalogue non conforme
	271	[famille]lorsque le titre d'une famille est assez long, celui-ci s'affiche sur 2 lignes dans le menu de gauche mais
	278	[Footer] - Affichage des univers
	280	[Home page] - Affichage d'une MEA banni�re
	281	[Home page] - Rotation d'une MEA banni�re
	288	[QuickView] Probl�mes graphique sur le QuickView
	289	[QuickView] La r�f�rence de l'article  n'ets pas affich� dans la quickView pour certain produits
	291	[QuickView] Probl�mes graphique sur le QuickView
	298	[Liste d'achat] Impossible de creer une liste d'achat avec un nom poss�dant une apostrophe
	299		[QuickView] Le clic sur les pictogrammes de r�seaux sociaux ont pour effet de fermer la popin
	302	[BO CMS] - Droits du responsable magasin
	312	[BO CMS] - Tags non accessibles
	317	[Contenu dossier] - Construction du fil d'Ariane
	318	[Contenu dossier] - Titre du dossier non conforme
	322	[Contenu dossier] - Article d'un dossier probl�me de titre
	334	[Contenu dossier] - Modification d'un visuel non synchrone
	335	[Search] Dans la page de r�sultat de recherche, la pagination ne s'affiche que sur la partie sup�rieur mais pas sur le bas
	336	[Famille] Pour les produits collections en vue  liste, le bouton d'ajout � la liste d'achat ne s'affiche pas
	345	[Contenu article] - Mauvais champ titre affich�
	351	[Contenu article] - Lien vers le site de l'auteur
	357	[Contenu article] - Partage par email
	372	[selection de facette] Facette range de prix non mise � jour apr�s une premi�re selection de facette
	377	[BO CMS] - Tri sur l'id m�tier dans la recherche magasin
	386	[Famille] Le bouton comparateur qui doit �tre situ� � c�t� de la zone de tri n'est pas visible
	392	[Store locator] - Les magasins ne remontent pas dans le store locator
	398	[Store locator] - Ascenseur vertical sur bloc magasin
	400	[Store locator] - Bouton epingler gris�
	404	[Store locator] - Titre long d'un magasin non tronqu�
	407	[Store locator] - Titre long non tronqu� sur une pin
	409	[Store locator] - Absences des champs adresses complementaires sur un bloc magasin
	413	[fiche produit Collection] La fiche produit collection ne correspond pas � la maquette
	416	[Store locator] - Popin de confirmation d'�pinglage
	420	[Store locator] - Bouton non fonctionnel dans popin de confirmation d'�pinglage
	437	[Fiche magasin] - Comptoir pro qui ne g�re pas les retours chariots
	441	[Fiche magasin] - Zone actualit�s
	443	[HEADER] Le lien "Changer de magasin" disparait du header quand le nom d'un magasin est sur 2 lignes
	445	[Fiche produit sur mesure] - Zone magasin anomalies graphiques
	459	[BO CMS] - Un tag avec une apostrophe n'est pas ajoutable � un dossier �ditorial
	461	[Cross-content] - Tags avec plusieurs mots ne fonctionne pas et emp�che la mise en relation famille-CMS
	473	[Search contenus] - Il manque la barre de pagination en bas de page
		
	15	[FLUX PRODUIT] caract�res + doit �tre non autoris� dans les urlKeywords
	16	Ecran freeze
	46	Interrogation de stock
	94	L'image zoom d�passe l'�cran
	95	[SEARCH contenu] Bouton de choix de vue ne fonctionne pas
	96	[LOT2: Carrelage] Conversion unit� de vente carrelage
	113	Message inexistant quand  r�sultat de recherche vide
	115	Liste des attributs comparables incomplète
	116	ALT et TITLE des thumbnails
	144	[mes options] sont vides
	177	inscription newsletter ne fonctionne pas
	179	le filtre de prix ne se met pas � jour lors de la s�lection des promos
	186	[Import JMS] [PPR] - Import Arbo
	222	[Error JMS: export client]
	223	Schedulers se lancent sur VM3 et VM4
	227	[Lot2] Page panier: gestion du retour du ws dispo stock
	283	Changement de magasin KO sur page collection
	332	Erreur JS sur l'ajout au panier d'un catalogue papier
	448	Fiche produit: calcul dispo stock
	458	Affichage de la dispo stock: fiche produit + quickview
	500	Disponibilit� des produits dans le panier KO
	DE139	[MOBILE] Affichage liste d�roulante
	DE148	[BREADCRUMB] Fil d'ariane edito
	DE151	[ARTICLE][ARTICLE LIE] Ne pas afficher l'article courant
	DE237	[ARTICLE] Affichage du titre d'article dans la pagination non conforme
	DE279	Alerte conversation d'un devis KO
	DE295	Affichage jours d'ouvertures exceptionnels KO
	DE297	Bouton de validation popin d'info moyen de paiement
	Fix Google TagManager & Shopping


version v0.1.5
--------------
	Delivered on 2015-03-18
	
	SiteMap et Google Shopping
	R�servation Drive
	Gestion fiche client Back-office
	
	DE305 :  la taille maximum pour une m�thode Java d�pass�e
	DE303 : Store Loc erreur de calcul itin�raire
	DE301 : [LOT2] Inscription KO
	DE300 : Impossible d'aller sur Mercanet avec un coupon
	DE299 : Remises perdues au retour du paiement
	DE298 : Montant TVA incorrect
	DE296 : Bouton de validation de la page paiement
	DE293 : Page de recherche quand CMS KO
	DE289 : Bouton "pagination pr�c�dent" grille de Drive KO
	DE288 : Date de d�marrage affichage planning Drive
	DE285 : R�gle d'affichage gestion du DRive
	DE280 : Fonctionnement zone de r�serve d'un cr�neau Drive
	DE278 : Bouton "Continuer mes achats" KO
	DE277 : Bouton "-" KO dans le panier
	DE276 : Affichage prix HT inexistant
	DE271 : [Login] Login dans Management Center
	DE269 : [MOBILE] Boutons sticky d'ajout au panier et wishlist
	DE268 : Changement d'adresse principale modifie l'adresse self
	DE240 : [MEA BANNIERE] Affichage sous-titre non conforme
	DE151 : [ARTICLE][ARTICLE LIE] Ne pas afficher l'article courant
	DE148 :[BREADCRUMB] Fil d'ariane edito
	DE127 : [MOBILE] Popin ajout au panier

	0000286 : [BO CMS] - Cr�ation d'article �ditorial impossible avec un profil contributeur
	0000224 - FLUX: Import Produits: controle sur les attributs definissants
	0000221 - Tag manager not defined (liste de meubles et promos)
	0000219 - Erreur JS: Page de r�sultat de recherche
	0000178 - ajout � la wishlist - s�lection article incorrecte
	0000114 - Passage Grid/list KO sur contenu
	0000106 : Category published=false affich�e
	F0000235 : [Produit collection] les produits collectrion en vue liste et en vue grille ne disposent pas des m�mes informations
	

version v0.1.4
--------------
	Delivered on 2015-03-11
	
	Dataload de reprise de donn�es des comptes existants
	lapeyre3D
	tagManager

	exportOrder : url page contact, date Drive
	DE304 : Dispo Stock ne fonctionne pas 
	DE294 : Case � cocher "Adresse de facturation est l'adresse de livraison" manquante
	DE291 : Rappel adresse livraison KO
	DE287 : [Dispo stock] raffraichissement dispo stock KO 
	DE284 : Bouton "Valider mes choix" KO 
	DE283 : [MOBILE] Ajout de quantit� dans le panier KO 
	DE282 :  Page panier KO si order empty 
	DE281 : bug page confirmation de commande 
	DE275 : Cr�ation d'une nouvelle adresse �ligibilit� d'un code postale 
	
	
version v0.1.3
--------------
	Delivered on 2015-03-04
	
	Fin du tunnel d'achat
	Gestion catalogue papier
	Gestion carrelage
	Compl�tion d'export de commande + message ARC
	Mise � jour du flux produit entrant
	Fix du mode preview
	
	DE273 [Emplacement des MEA] Emplacement non retourn� par le CMS 
	DE270 - [Pagination] La pagination n'est pas complete + popin facette
	DE267  [CMS][SEARCH][CONTENU] : Nombre de r�sultat incorrecte en preview 
	DE266 - [MOBILE] Zone de prix mal positionn�e sur Fiche produit standard
	DE265 - [WISHLIST] Prix barr� KO
	DE264 [CMS] Flush du cache ne fonctionne pas correctement. 
	DE263 - Facette prix KO
	DE262 - [Panier] Bouton "continuer mes achats" non align�
	DE261 - [MOBILE] [WISHLIST] Mauvais affichage du d�tail des wishlist sur mobile
	DE260 - [FICHE MAGASIN] Disparition du bloc magasin dans le header
	DE254 - [SEARCH] Encodage des suggestions
	DE250 - [SEARCH] Affichage des suggestion au survol
	DE236 - [WISHLIST] Marketing spot manquant sur le d�tail d'une wishlist
	DE234 - [ARTICLE] Affichage du s�parateur si section vide
	DE228  [FAMILLE] Image par d�faut non affich�e sur page famille modifi�
	DE225 - [COMPTE CLIENT] : Acc�s Sans Login
	DE224 - [ADRESSES] Blocage RNVP - champ "Batiment"
	DE222 - [COMPTE CLIENT] Liste d�roulante : la fleche n'est pas cliquable
	DE204 - [CARNET ADRESSE] Caract�re ajout� sur bloc adresse
	DE202 - [COMPTE] Page mes magasin - mauvais title
	DE199 - [MOBILE] Loader js non centr�
	DE192 - [MAGASIN] Ajout Email responsable installation
	DE190 - [MOBILE][WISHLIST] nombre de produits tjs au pluriel
	DE189 - [MOBILE] [WISHLIST] Affichage du nom et de la date KO
	DE83 - [STORELOC] Affichage des n� de t�l�phone
	DE82 - [STORELOC] Fiche magasin - fermeture exceptionnelle non masqu�e si vide
	DE75 - [ARTICLE] Texte � masquer si pas de tags
	DE71 - [MAGASIN] Bloc avis client � masquer si vide
	DE62 - [STORELOC] Couleur de l'itin�raire

	0000139 gestion des urls des images QRcode
	0000109 Faute orthographe "fiche d�taill�"
	0000118 Fonctionnement menu d�roulant KO
	DE00097 - [MOBILE] Gestion de l'ajout au panier et affichage du prix sur page produit
	DE00090 - Bandeau cookie non responsive
	DE00078 - Affichage mention "dispo en magasin" KO dans la vue grille pour les sur mesure
	DE00070 - Bouton ajouter au panier indispo
	DE00069 - Calcul dispo stock sur la fiche item

	Le probl�me d'affichage avec la class sticky sous Firefox et Chrome (Page Edito)
	AssetpushUrl : ne pas ajouter le pr�fix pour les urls absolus
	Ajouter le message "Adresse non �ligible" pour les adresses dont le code postal est exclu
	Gestion des tris de content


version v0.1.2
--------------
	Delivered on 2015-02-25
	
	Page livraison
	Gestion des anciennes URL SEO
	
	DE266 - [MOBILE] Zone de prix mal positionn�e sur Fiche produit standard
	DE262 - [Panier] Bouton "continuer mes achats" non align�
	DE225 - [COMPTE CLIENT] : Acc�s Sans Login
	DE222 - [COMPTE CLIENT] Liste d�roulante : la fl�che n'est pas cliquable
	DE192 - [MAGASIN] Ajout Email responsable installation
	DE82 - [STORELOC] Fiche magasin - fermeture exceptionnelle non masqu�e si vide
	DE71 - [MAGASIN] Bloc avis client � masquer si vide

version v0.1.1  
--------------
	Delivered on 2015-02-18  
	
	DE258 - [SEARCH][CONTENU] : Facettes non rafra�chies au bouton back
	DE257 - [PAGE PERTE CONNEXION] D�sactiver cette page
	DE256 - [SWATCHS] Comportement identique quand un seul item
	DE253 - [ARTICLE erreur js si pas d'auteur
	DE251 - [SEARCH] Suggestion - lien KO
	DE249 - [MEGAMENU] Amelioration graphique �tat actif
	DE248 - [COMPARATEUR] Fond gris sur bouton de suppresison
	DE247 - [IDENTIFICATION] Largeur de page trop grande
	DE246 - [COMPARATEUR] Nombre de produit KO si 1 produit
	DE245 - [COMPARATEUR] bloc produit - largeur fixe
	DE244 - [LOGS] Logger les appels et r�ponses aux WS
	DE243 - [SEARCH] Freeze sur resultat de recherche si back navigateur
	DE239 - [MEA BANNIERE] Titre bloc Non affich�
	DE238 - [FLUX PRODUIT] Caract�re interdit dans le seoUrlKeyword (DE00015)
	DE235 - [SEARCH] Zone de widget manquantes sur les pages liste meuble et liste promo
	DE233 - [HOME MAG] [PAROLE LAPEYRE] Masquer la zone si vide
	DE232 - [WS CMS] Erreur d'appel sur les clients guest
	DE229 - [SEO][FAMILLE] L'URL de la page  famille est canonique si appel depuis la page univers
	DE227 - [MEGAMENU] Liste des sous-familles limit� � 4
	DE221 - [EXPORT CLIENT] Champs mal export�s
	DE220 - [SYNCHRO CRM] Champs non affich�s
	DE219 - [MEA] Lorsque largeur &lt;100%, pb de marge
	DE217 - [PRODUIT] Libell� des magasins non cliquable
	DE213 - [WISHLIST] Affichage du prix barr� trop gros
	DE211 - [MOBILE] [SEARCH] Tri sur recherche contenu mal affich�
	DE209 - [PAGE ERREUR] Page De perte de connexion - ajout d'un bouton revenir � la page pr�c�dente
	DE202 - [COMPTE] Page mes magasin - mauvais title
	DE200 - [STORELOC] Affichage du magasin par d�faut
	DE198 - [MOBILE][MEA BANNIERE] Visuel � afficher
	DE197 - [MOBILE] Marge bouton "affiner sa recherche"
	DE195 - [MOBILE] facette Promo affich�e en bouton
	DE176 - [SEO][HOME MAG] Balise title non sett�
	DE171 - [MEA SubMenu] Les MEAs ne remontent pas sauf sur cuisine
	DE169 - [MOBILE] Barre de search � rendre fixe et sticky
	DE166 - [MOBILE][UNIVERS] Taille des image
	DE164 - [SEO] [ARTICLE] Mauvais H3 dans le surtitre
	DE161 - [PRODUIT] [vue GRILLE] Marge � droite sur les prix absente
	DE160 - [STORELOC] Liste magasins - orthographe
	DE154 - [TABLET][Portrait][HOME MAG] Carrousel produit mal affich�
	DE144 - [MEA][PART/PRO] Contextualisation non prise en compte
	DE143 - [MEA] [MOBILE/DESKTOP] Contexte non pris en compte
	DE138 - [MOBILE] Quick View � rendre inaccessible
	DE137 - [ARTICLE] [Section article li�] Titre incorrect sur page article
	DE133 - [UNIVERS] La largeur des bloc de famille n'est pas bonne
	DE132 - [MOBILE][SEARCH] popin facette inutilisable en mode paysage
	DE131 - [MOBILE][SEARCH] Popin facette ne prend pas toute la largeur
	DE130 - [MOBILE][SEARCH] Bouton "tri" sur contenu
	DE127 - [MOBILE] Popin ajout au panier
	DE126 - [MOBILE] Affichage prix sur fiche produit
	DE125 - [MOBILE] Cross-content doit �tre en carrousel de 1 �l�ment
	DE118 - [HEADER] magasin par d�faut non connu
	DE114 - [UNIVERS] Marge entre les familles trop petite
	DE113 - [MEGAMENU] hauteur non fluide si pas de MEA
	DE99 - [FACET PRIX] cas des prix &lt1
	DE98 - [SEO][CATEGORY] Titre en vue grille
	DE96 - [SEO][HOME] Titre des sections dans un span au lieu d'un H2
	DE92 - [MEA Free HTML] Ne pas afficher le champ titre
	DE85 - [STORELOC] Fiche magasin - bouton GPS
	DE78 - [CONTACT] Image de fond � mettre � jour
	DE73 - [MAGASIN] ne pas afficher la colonne "horaire Drive" si vide
	DE70 - [MAGASIN] Les zones free HTML mal affich�
	DE69 - [MAGASIN] Popin GPS non centr�e
	DE66 - [MAGASIN] Affichage adresse erron�
	DE60 - [STORELOC] bouton itin�raire mal affich�
	DE58 - [MEGA MENU Catalogue] erreur d'affichage
	DE55 - [HOME MAG] Espace affich� si section vide
	DE54 - [FICHE PRODUIT vue EDITO] L'image de l'asset GRID_IMAGES est retaill�e
	DE51 - [ARTICLE] liens des tags vers la recherche
	DE47 - [PRODUITS VUE LISTE] Liens vers les CGV ko
	DE41 - [PRIX] Affichage des prix pro: mention HT
	DE40 - [MENU MOBILE] Barre de recherche
	DE36 - [PREVIEW A DATE] Le contenu �ditorial n'est pas affich� en front
	DE30 - [MOBILE] Carousel selection du mois : 1 �lement
	DE27 - [PAGE UNIVERS] widget arbo catalogue
	DE22 - [WIDGET] Utilisre l'asset GRID_IMAGES et non l'image Full
	DE5 - [DESKTOP] Vue grille des produits - hauteur fixe
	DE3 - [DESKTOP] FP COLLECTION - Caract�ristique de la gamme , affichage du texte
	DE054 - changement processeur DesktopZoom en zoom1
	DE008 - Flux "Attributs"
	Fix chemins JS incorrects en PPR
	Ajout descriptions niveau Item � l'import
	Gestion d'arrondi carrelage




version v0.1.0
--------------

	Delivered on 2015-02-11

	</pre>
</body>
</html>