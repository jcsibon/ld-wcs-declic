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
	HISTORY:"Хронология",
	//AutoSuggestion Headings
	ARTICLES: "Товары",
	BRAND: "Торговая марка",
	CATEGORY: "Категория",
	//Product Description
	ERR_RESOLVING_SKU : "Информация указана не полностью или выбранных товаров нет в наличии. Укажите значение для каждого атрибута или другое сочетание значений.",
	QUANTITY_INPUT_ERROR : "Недопустимое значение в поле Количество. Укажите положительное целое число и повторите попытку.",
	WISHLIST_ADDED : "Товар успешно добавлен в список предпочтений",
	
	SHOPCART_ADDED : "Товар успешно добавлен в корзину.",
	PRICE : "Цена:",
	SKU : "Артикул:",
	PQ_PURCHASE : "Заказ:",
	PQ_PRICE_X : "${0} -",
	PQ_PRICE_X_TO_Y : "от ${0} до ${1} -",
	PQ_PRICE_X_OR_MORE : "от ${0} -",
	
	COMPARE_ITEM_EXISTS : "Товар, выбранный для добавления в область сравнения, уже добавлен.",
	COMPATE_MAX_ITEMS : "Одновременно можно сравнивать не более четырех товаров.",
	COMPAREZONE_ADDED : "Товар успешно добавлено в область сравнения.",
	
	GENERICERR_MAINTEXT : "При обработке последнего запроса в магазине возникла неполадка. Повторите попытку. Если неполадка возникнет снова, ${0} для получения помощи.",
	GENERICERR_CONTACT_US : "связаться с нами",
	
	MSC_ITEMS : "${0} товаров",
	
	// Shopping List Messages
	DEFAULT_WISH_LIST_NAME : "Список предпочтений",
	LIST_CREATED : "Список предпочтений успешно создан.",
	LIST_EDITED : "Список предпочтений успешно изменен.",
	LIST_DELETED : "Список предпочтений успешно удален.",
	ITEM_ADDED : "Товар добавлен в список предпочтений.",
	ITEM_REMOVED : "Товар удален из списка предпочтений.",
	ERR_NAME_EMPTY : "Введите имя списка предпочтений.",
	ERR_NAME_TOOLONG : "Слишком длинное имя списка предпочтений.",
	ERR_NAME_SHOPPING_LIST : "Имя Список предпочтений зарезервировано для списка предпочтений по умолчанию. Выберите другое имя.",
	ERR_NAME_DUPLICATE : "Список предпочтений с выбранным вами именем уже существует. Выберите другое имя.",
	INVALID_NAME_SHOPPING_LIST : "Имя списка предпочтений содержит недопустимые символы. Выберите другое имя.",
	WISHLIST_EMAIL_SENT : "Электронное сообщение отправлено.",
	WISHLIST_MISSINGNAME : "Не заполнено поле Имя. Введите свое имя и повторите попытку.",
	WISHLIST_MISSINGEMAIL : "Не заполнено поле Адрес электронной почты. Введите адрес электронной почты получателя списка предпочтений и повторите попытку.",
	WISHLIST_INVALIDEMAILFORMAT : "Недопустимый формат адреса электронной почты.",
	WISHLIST_EMPTY : "Создайте список предпочтений перед отправкой электронного сообщения.",
	WISHLIST_INVALIDSENDERNAME : "Поле Имя содержит недопустимые символы. Введите свое имя и повторите попытку.",
		
	// Inventory Status Messages
	INV_STATUS_RETRIEVAL_ERROR : "Ошибка при получении состояния запасов. Повторите попытку позже. Если ошибка возникнет снова, обратитесь к администратору сайта.",
	INV_ATTR_UNAVAILABLE: "${0} - нет доступа",
	
	// Product Tab
	CONFIGURATION: "Конфигурация",
	
	// My Account Page Messages
	QC_UPDATE_SUCCESS : "Профайл быстрого оформления заказа успешно обновлен.",
	
	// This line defines the Quantity {0} and the component name {1} of a dynamic kit.  If a kit has a component with quantity 3, it will show as: 3 x Harddrive.
	// To show the string "Harddrive : 3", simply change this line to:  {1} : {0}.
	ITEM_COMPONENT_QUANTITY_NAME: "${0} x ${1}",
	
	//Sterling Order Line Status
	ORDER_LINE_STATUS_S : "Заказ отправлен",
	ORDER_LINE_STATUS_G : "Обработка заказа",
	ORDER_LINE_STATUS_K : "Возвращен связанным",
	ORDER_LINE_STATUS_V : "Частично отправлен",
	ORDER_LINE_STATUS_X : "Заказ отменен"
})
