<!-- Begin Page_ArticleFree.jsp-->
${content.page.body}

<div class="row">
		<div class="content">
			<%out.flush();%>
			<c:catch var="exc">
				<ecocea:widgetPath var="emspotpath" identifier="EMarketingSpot" />
				<c:import url="${emspotpath}">
					<c:param name="storeId" value="${storeId}" />
					<c:param name="catalogId" value="${catalogId}" />
					<c:param name="emsName" value="contentMarketingSpot_bestSeller" />
					<c:param name="pageSize" value="3"/>
					<c:param name="t2sWidgetSuffix" value="contentMarketingSpot_bestSeller"/>
					<c:param name="displayPreference" value="1"/>
				</c:import>
				<c:import url="${emspotpath}">
					<c:param name="storeId" value="${storeId}" />
					<c:param name="catalogId" value="${catalogId}" />
					<c:param name="emsName" value="contentMarketingSpot_RecoProduits" />
					<c:param name="pageSize" value="3"/>
					<%-- Target2Sell BEGIN --%>
					<c:param name="t2sWidgetSuffix" value="contentMarketingSpot_RecoProduits"/>
					<c:param name="displayPreference" value="1"/>
					<%-- Target2Sell END --%>
				</c:import>
				<c:import url="${emspotpath}">
					<c:param name="storeId" value="${storeId}" />
					<c:param name="catalogId" value="${catalogId}" />
					<c:param name="emsName" value="contentMarketingSpot_SelectionDuMois" />
					<c:param name="pageSize" value="3"/>
					<c:param name="t2sWidgetSuffix" value="contentMarketingSpot_SelectionDuMois"/>
					<c:param name="displayPreference" value="1"/>
				</c:import>
				<c:import url="${emspotpath}">
					<c:param name="storeId" value="${storeId}" />
					<c:param name="catalogId" value="${catalogId}" />
					<c:param name="emsName" value="contentMarketingSpot_ProduitsEtContenus" />
					<c:param name="pageSize" value="3"/>
					<c:param name="t2sWidgetSuffix" value="contentMarketingSpot_ProduitsEtContenus"/>
					<c:param name="displayPreference" value="1"/>
				</c:import>
			</c:catch>
			<%out.flush();%>
		
		</div>
	</div>

<!-- End Page_ArticleFree.jsp-->