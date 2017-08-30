
<div id="infosPratiquesContainer">
	
	<%-- Infos pratiques --%>
	<span class="titleBlock">
		<fmt:message bundle="${widgetText}" key="magasinsHorairesTitle" />
	</span>
	
	<div class="row centered" id="horairesContainer">
		
		<%-- 2 colonnes --%>
		<c:set var="col1Class" value="col12 bcol12" />
		<c:set var="col2Class" value="col12 bcol12" />
		<%-- 1 colonne --%>
		<c:if test="${empty mag.horairesDriveSemaine && empty mag.horairesDriveExceptionnels}">
			<c:set var="col1Class" value="col12 singleCol" />
		</c:if>
	
		<%-- Horaires magasin --%>
		<c:if test="${!empty mag.horairesMagasin}">
			<div class="" id="horairesMagasin">
				<%--Ouvertures semaine --%>
				<c:if test="${!empty mag.horairesMagasin}">
					<div class="content">
						<span class="alignLeft hourTitle" id="ouvertureMagasinLabel"><fmt:message bundle="${widgetText}" key="STORE_HOURS_PRIVATE" /></span>
						<table class="horaires">
							
							<c:forEach var="ouvertureMagasin" items="${mag.horairesMagasin}">
								<tr>
									<td class="jour"><c:out value="${ouvertureMagasin.jour}" /></td>
									<td><c:out value="${ouvertureMagasin.horaires}"></c:out></td>
								</tr>
								
								<c:if test="${!empty ouvertureMagasin.ouverture_matin }">
									<span itemprop="openingHoursSpecification" itemscope itemtype="${MICRO_DATA_OPENINGHOURS}">
										<c:set var="microDataStoreOpeningDay" value=""/>
										<meta itemprop="dayOfWeek" content="${MICRO_DATA_DAYS[fn:toUpperCase(ouvertureMagasin.jour)]}" />
										<c:if test="${!empty ouvertureMagasin.ouverture_matin }"><meta itemprop="opens" content="${ouvertureMagasin.ouverture_matin}" /></c:if>
										<c:if test="${!empty ouvertureMagasin.fermeture_matin }"><meta itemprop="closes" content="${ouvertureMagasin.fermeture_matin}" /></c:if>
										<c:if test="${!empty ouvertureMagasin.ouverture_apresmidi }"><meta itemprop="opens" content="${ouvertureMagasin.ouverture_apresmidi}" /></c:if>
										<c:if test="${!empty ouvertureMagasin.fermeture_apresmidi }"><meta itemprop="closes" content="${ouvertureMagasin.fermeture_apresmidi}" /></c:if>
									</span>
								</c:if>
								
							</c:forEach>
						</table>
					</div>
				</c:if>
				
				<!-- Ouverture exceptionnelle magasin -->
				<c:if test="${isOnMobileDevice}">
					<c:if test="${!empty mag.ouvertureExceptionnelle}">
						<div class="centered content">
							<span class="hourTitle"><fmt:message bundle="${widgetText}" key="ouvertureExcepMagasinLabel" /></span>
							<c:out value="${ecocea:replaceCarriageReturn(mag.ouvertureExceptionnelle)}" escapeXml="false"/>
						</div>
					</c:if>
					<c:if test="${!empty mag.fermetureExceptionnelleMag}">
						<div class="centered content">
							<span class="hourTitle"><fmt:message bundle="${widgetText}" key="fermetureExcepMagasinLabel" /></span>
							<c:out value="${ecocea:replaceCarriageReturn(mag.fermetureExceptionnelleMag)}" escapeXml="false"/>
						</div>
					</c:if>
				</c:if>
			</div>
		</c:if>
		<%-- Horaires drive --%>
		<c:if test="${mag.modeLivraison.retraitDrive && !empty mag.horairesDriveSemaine }">
			<hr class="bHorizontalDivider" />
			<div class="" id="horairesDrive">
				<%-- Ouvertures semaine --%>
				<c:if test="${!empty mag.horairesDriveSemaine }">
					<div class="content">
						<span class="alignLeft hourTitle"><fmt:message bundle="${widgetText}" key="STORE_HOURS_DRIVE" />&nbsp;<img src="${jspStoreImgDir}images/logoDrive.png"></span>
						<table class="horaires">
							<c:forEach var="ouvertureDrive" items="${mag.horairesDriveSemaine}">
								<tr>
									<td class="jour"><c:out value="${ouvertureDrive.jour}" /></td>
									<td><c:out value="${ouvertureDrive.horaires}"></c:out></td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</c:if>
				
				
				<c:if test="${isOnMobileDevice}">
					<%-- Ouvertures exceptionnelles drive --%>
					<c:if test="${mag.modeLivraison.retraitDrive && !empty mag.horairesDriveExceptionnels}">
						<div class="centered content">
							<span class="centered hourTitle"><fmt:message bundle="${widgetText}" key="ouvertureExcepDriveLabel" /></span>
							<c:choose>
								<c:when test="${fn:length(mag.horairesDriveExceptionnels) > 1}">
									<fmt:message bundle="${widgetText}" key="ouvertureExcepDriveTextMult" />
								</c:when>
								<c:otherwise>
									<fmt:message bundle="${widgetText}" key="ouvertureExcepDriveText" />
								</c:otherwise>
							</c:choose>
							<c:set var="link" value=" " />
							<c:forEach items="${mag.horairesDriveExceptionnels}" var="ouvertureExcepDrive" varStatus="iter">
								<%-- Choix du mot de liaison : "," ou "et" ou vide --%>
								<c:if test="${iter.count > 1}">
									<c:set var="link" value=", " />
									<c:if test="${iter.count == fn:length(mag.horairesDriveExceptionnels)}">
										<c:set var="link" value=" et " />
									</c:if>
								</c:if>
								<c:out value="${link}" />
								<fmt:parseDate value="${ouvertureExcepDrive['date']}" pattern="yyyy-MM-dd" var="dateOuvertureExcepDrive" />
								<fmt:formatDate value="${dateOuvertureExcepDrive}" pattern="EEEE d MMMM yyyy" />
								(<c:out value="${ouvertureExcepDrive.horaires}" />)
							</c:forEach>.
						</div>
					</c:if>
				</c:if>
			</div>
		</c:if>
	</div>
	
	<%-- Ouverture exceptionnelle DESKTOP --%>
	<c:if test="${!isOnMobileDevice}">
		<!-- Ouverture exceptionnelle magasin -->
		<c:if test="${!empty mag.ouvertureExceptionnelle}">
			<hr class="bHorizontalDivider" />
			<div class="row">
			<div class="col12">
			<div class="centered content">
				<span class="hourTitle"><fmt:message bundle="${widgetText}" key="ouvertureExcepMagasinLabel" /></span>
				<c:out value="${ecocea:replaceCarriageReturn(mag.ouvertureExceptionnelle)}" escapeXml="false"/>
			</div>
			</div>
			</div>
		</c:if>
		<!-- Fermeture exceptionnelle magasin -->
		<c:if test="${!empty mag.fermetureExceptionnelleMag}">
			<hr class="bHorizontalDivider" />
			<div class="row">
			<div class="col12">
			<div class="centered content">
				<span class="hourTitle"><fmt:message bundle="${widgetText}" key="fermetureExcepMagasinLabel" /></span>
				<c:out value="${ecocea:replaceCarriageReturn(mag.fermetureExceptionnelleMag)}" escapeXml="false"/>
			</div>
			</div>
			</div>
		</c:if>
				
		<%-- Ouvertures exceptionnelles drive --%>		
		<c:if test="${mag.modeLivraison.retraitDrive && !empty mag.horairesDriveExceptionnels}">
			<hr class="bHorizontalDivider" />
			<div class="row">
			<div class="col12">
			<div class="centered content">
				<span class="hourTitle"><fmt:message bundle="${widgetText}" key="ouvertureExcepDriveLabel" /></span>
				<c:choose>
					<c:when test="${fn:length(mag.horairesDriveExceptionnels) > 1}">
						<fmt:message bundle="${widgetText}" key="ouvertureExcepDriveTextMult" />
					</c:when>
					<c:otherwise>
						<fmt:message bundle="${widgetText}" key="ouvertureExcepDriveText" />
					</c:otherwise>
				</c:choose>
				<c:set var="link" value=" " />
				<c:forEach items="${mag.horairesDriveExceptionnels}" var="ouvertureExcepDrive" varStatus="iter">
					<%-- Choix du mot de liaison : "," ou "et" ou vide --%>
					<c:if test="${iter.count > 1}">
						<c:set var="link" value=", " />
						<c:if test="${iter.count == fn:length(mag.horairesDriveExceptionnels)}">
							<c:set var="link" value=" et " />
						</c:if>
					</c:if>
					<c:out value="${link}" />
					<fmt:parseDate value="${ouvertureExcepDrive['date']}" pattern="yyyy-MM-dd" var="dateOuvertureExcepDrive" />
					<fmt:formatDate value="${dateOuvertureExcepDrive}" pattern="EEEE d MMMM yyyy" />
					(<c:out value="${ouvertureExcepDrive.horaires}" />)
				</c:forEach>.
			</div>
			</div>
			</div>
		</c:if>
	</c:if>
	
	<%-- Liste Fermetures exceptionnelles drive --%>
	<c:if test="${!empty mag.fermeturesExceptionnelles}">
		<hr class="bHorizontalDivider" />
		<div class="row">
			<div class="col12">
				<div class="centered content">
					<span class="hourTitle"><fmt:message bundle="${widgetText}" key="fermetureExcepLabel" /></span>
					<c:choose>
						<c:when test="${fn:length(mag.fermeturesExceptionnelles) > 1}">
							<fmt:message bundle="${widgetText}" key="fermetureExcepTextMult" />
						</c:when>
						<c:otherwise>
							<fmt:message bundle="${widgetText}" key="fermetureExcepText" />
						</c:otherwise>
					</c:choose>
					<c:set var="link" value=" " />
					<c:forEach items="${mag.fermeturesExceptionnelles}" var="fermeturesExcepDrive" varStatus="iter">
						<%-- Choix du mot de liaison : "," ou "et" ou vide --%>
						<c:if test="${iter.count > 1}">
							<c:set var="link" value=", " />
							<c:if test="${iter.count == fn:length(mag.fermeturesExceptionnelles)}">
								<c:set var="link" value=" et " />
							</c:if>
						</c:if>
						<c:out value="${link}" escapeXml="false" />
						<fmt:parseDate value="${fermeturesExcepDrive['date']}" pattern="yyyy-MM-dd" var="dateFermetureExcepDrive" />
						<fmt:formatDate value="${dateFermetureExcepDrive}" pattern="EEEE d MMMM yyyy" /> 
					</c:forEach>.
				</div>
			</div>
		</div>
	</c:if>
	
	<%-- Comptoir pro --%>
	<c:if test="${!empty mag.comptoirPro}">
		<hr class="bHorizontalDivider" />
		<div class="row">
			<div class="col12">
				<div class="centered content">
					<span class="hourTitle"><fmt:message bundle="${widgetText}" key="ouvertureProExcepLabel" /></span>
					<c:out value="${ecocea:replaceCarriageReturn(mag.comptoirPro)}" escapeXml="false"/>
				</div>
			</div>
		</div>
	</c:if>
	
</div>