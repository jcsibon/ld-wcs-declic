//-----------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// WebSphere Commerce
//
// (C) Copyright IBM Corp. 2011, 2012 All Rights Reserved.
//
// US Government Users Restricted Rights - Use, duplication or
// disclosure restricted by GSA ADP Schedule Contract with
// IBM Corp.
//-----------------------------------------------------------------

// NLS_CHARSET=UTF-8
({
	HISTORY:"Protokoll",
	//AutoSuggestion Headings
	ARTICLES: "Artikel",
	BRAND: "Marke",
	CATEGORY: "Kategorie",
	//Product Description
	ERR_RESOLVING_SKU : "Ihre Auswahl ist entweder unvollständig oder nicht vorrätig. Stellen Sie sicher, dass Sie für jedes Attribut einen Wert angeben, oder geben Sie eine andere Kombination von Werten an.",
	QUANTITY_INPUT_ERROR : "Der Wert im Feld 'Menge' ist nicht gültig. Stellen Sie sicher, dass der Wert eine positive ganze Zahl ist und versuchen Sie es erneut.",
	WISHLIST_ADDED : "Der Artikel wurde der Wunschliste erfolgreich hinzugefügt.",
	
	SHOPCART_ADDED : "Der Artikel wurde Ihrem Einkaufskorb erfolgreich hinzugefügt.",
	PRICE : "Preis:",
	SKU : "Artikelnummer:",
	PQ_PURCHASE : "Einkauf:",
	PQ_PRICE_X : "${0} -",
	PQ_PRICE_X_TO_Y : "${0} bis ${1} -",
	PQ_PRICE_X_OR_MORE : "${0} oder mehr -",
	
	COMPARE_ITEM_EXISTS : "Das Produkt, das Sie der Vergleichszone hinzufügen möchten, ist bereits vorhanden.",
	COMPATE_MAX_ITEMS : "Sie können nur bis zu 4 Produkte vergleichen.",
	COMPAREZONE_ADDED : "Der Artikel wurde der Vergleichszone erfolgreich hinzugefügt.",
	
	GENERICERR_MAINTEXT : "Beim Verarbeiten der letzten Anforderung hat das Geschäft ein Problem festgestellt. Bitte wiederholen Sie den Versuch. Wenn das Problem bestehen bleibt, ${0} für Unterstützung.",
	GENERICERR_CONTACT_US : "Kontaktieren Sie uns!",
	
	MSC_ITEMS : "${0} Artikel",
	
	// Shopping List Messages
	DEFAULT_WISH_LIST_NAME : "Wunschliste",
	LIST_CREATED : "Die Wunschliste wurde erfolgreich erstellt.",
	LIST_EDITED : "Der Name der Wunschliste wurde erfolgreich geändert.",
	LIST_DELETED : "Die Wunschliste wurde erfolgreich gelöscht.",
	ITEM_ADDED : "Der Artikel wurde zu Ihrer Wunschliste hinzugefügt.",
	ITEM_REMOVED : "Der Artikel wurde aus Ihrer Wunschliste entfernt.",
	ERR_NAME_EMPTY : "Geben Sie einen Namen für Ihre Wunschliste ein.",
	ERR_NAME_TOOLONG : "Der Name der Wunschliste ist zu lang.",
	ERR_NAME_SHOPPING_LIST : "Der Name 'Wunschliste' ist für die Standardwunschliste reserviert. Wählen Sie einen anderen Namen aus.",
	ERR_NAME_DUPLICATE : "Es ist bereits eine Wunschliste mit dem von Ihnen gewählten Namen vorhanden. Wählen Sie einen anderen Namen aus.",
	INVALID_NAME_SHOPPING_LIST : "Der Name 'Wunschliste' enthält ungültige Zeichen. Wählen Sie einen anderen Namen aus.",
	WISHLIST_EMAIL_SENT : "Ihre E-Mail wurde gesendet.",
	WISHLIST_MISSINGNAME : "Das Feld für den Namen muss ausgefüllt werden. Geben Sie im Feld 'Name' Ihren Namen ein, und wiederholen Sie den Vorgang.",
	WISHLIST_MISSINGEMAIL : "Das Feld für die E-Mail-Adresse muss ausgefüllt werden. Geben Sie die E-Mail-Adresse der Person ein, an die die Wunschliste gesendet werden soll, und wiederholen Sie den Vorgang.",
	WISHLIST_INVALIDEMAILFORMAT : "Ungültiges Format für E-Mail-Adresse.",
	WISHLIST_EMPTY : "Erstellen Sie eine Wunschliste, bevor Sie eine E-Mail senden.",
	WISHLIST_INVALIDSENDERNAME : "Das Feld 'Name' enthält ungültige Zeichen. Geben Sie im Feld 'Name' Ihren Namen ein, und wiederholen Sie den Vorgang.",
		
	// Inventory Status Messages
	INV_STATUS_RETRIEVAL_ERROR : "Beim Abrufen des Lagerbestandsstatus ist ein Fehler aufgetreten. Versuchen Sie es zu einem späteren Zeitpunkt erneut. Wenden Sie sich an den Siteadministrator, wenn das Problem bestehen bleibt.",
	INV_ATTR_UNAVAILABLE: "${0} - nicht verfügbar",
	
	// Product Tab
	CONFIGURATION: "Konfiguration",
	
	// My Account Page Messages
	QC_UPDATE_SUCCESS : "Profil für Schnellkasse erfolgreich aktualisiert!",
	
	// This line defines the Quantity {0} and the component name {1} of a dynamic kit.  If a kit has a component with quantity 3, it will show as: 3 x Harddrive.
	// To show the string "Harddrive : 3", simply change this line to:  {1} : {0}.
	ITEM_COMPONENT_QUANTITY_NAME: "${0} x ${1}",
	
	//Sterling Order Line Status
	ORDER_LINE_STATUS_S : "Bestellung ausgeliefert",
	ORDER_LINE_STATUS_G : "Bestellbearbeitung",
	ORDER_LINE_STATUS_K : "Rückgabe zugeordnet",
	ORDER_LINE_STATUS_V : "Teilweise versendet",
	ORDER_LINE_STATUS_X : "Bestellung storniert"
})
