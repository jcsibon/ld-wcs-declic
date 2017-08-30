				<!-- searchTab.jsp -->
				<c:set var="t2sPId" value="<%= com.ecocea.commerce.marketing.commands.elements.Target2SellRecommendationHelper.PAGE_SEARCH %>" scope="request" />
				<div role="tabpanel" class="tab" data-slot-id="${tabSlotId}" id="tab${statusCount}Widget" aria-labelledby="tab${statusCount}" ${tabStyle}>
					<div class="content">
						<c:choose>
							<c:when test="${(statusCount == '1' && totalCount > 0) || (statusCount == '2' && totalContentCount > 0)}">
								<div class="col s12 l3" id="searchFacetContainer">
									<c:choose>
										<c:when test="${empty noLayoutFolderEdito}">
											<wcpgl:widgetImport slotId="Facet${tabSlotId}" />
										</c:when>
										<c:otherwise>
											<ecocea:widgetPath var="FacetContentWidgetPath" identifier="FacetContentWidget" />
											<%out.flush(); %>
											<c:import url="${FacetContentWidgetPath}"></c:import>
											<%out.flush(); %>
										</c:otherwise>
									</c:choose>
								</div>			
								<div class="col s12 l9" id="searchResultContainer">
									<c:choose>
										<c:when test="${empty noLayoutFolderEdito}">
											<wcpgl:widgetImport slotId="${tabSlotId}" />
										</c:when>
										<c:otherwise>
											<ecocea:widgetPath var="CrossContentWidgetPath" identifier="CrossContentListWidget" />
											<%out.flush(); %>
											<c:import url="${CrossContentWidgetPath}">
												<c:param name="contentSearchTerm" value="${contentSearchTerm}"/>
												<c:param name="searchMethod" value="${searchMethod}"/>
												<c:param name="searchTerm" value="${searchTerm}"/>
											</c:import>
											<%out.flush(); %>
										</c:otherwise>
									</c:choose>
								</div>
							</c:when>
							<c:when test="${(statusCount == '1' && totalCount == 0) || (statusCount == '2' && totalContentCount == 0)}">
							<c:set var="t2sPId" value="<%= com.ecocea.commerce.marketing.commands.elements.Target2SellRecommendationHelper.PAGE_SEARCH_NORESULT %>" scope="request" />
								<div class="row">
									<div class="col s12">
										<div class="searchNoResultMessage">
											<fmt:message key="searchNoResultMessage" bundle="${widgetText}"/><br>
											<c:if test="${statusCount == '1' && !(empty spellcheck && empty contentspellcheck)}">
												<wcf:url var="SpellCheckSearchDisplayViewURL" value="SearchDisplay" type="Ajax">
														<wcf:param name="langId" value="${langId}"/>
														<wcf:param name="storeId" value="${storeId}"/>
														<wcf:param name="catalogId" value="${catalogId}"/>		
														<wcf:param name="pageView" value="${pageView}"/>
														<wcf:param name="beginIndex" value="0"/>
														<wcf:param name="pageSize" value="${WCParam.pageSize}"/>
														<wcf:param name="sType" value="${WCParam.sType}"/>						
														<wcf:param name="manufacturer" value="${WCParam.manufacturer}" />
														<wcf:param name="minPrice" value="${WCParam.minPrice}" />
														<wcf:param name="maxPrice" value="${WCParam.maxPrice}" />
														<wcf:param name="resultCatEntryType" value="${WCParam.resultCatEntryType}"/>						
														<wcf:param name="showResultsPage" value="true"/>				  
														<wcf:param name="orderBy" value="${WCParam.orderBy}"/>
														<wcf:param name="searchSource" value="Q"/>
														<wcf:param name="searchTermScope" value="${WCParam.searchTermScope}"/>
														<wcf:param name="advancedSearch" value="${WCParam.advancedSearch}" />
												</wcf:url>
												<%-- Search keyword didnt return any results --%>
												<div class="widget_search_results_position">
													<div class="widget_search_results">
														<flow:ifEnabled feature="Analytics">
															<div id="catalog_search_result_information" style="visibility:hidden">
																{	searchResult: {
																	pageSize: <c:out value="${pageSize}"/>, 
																	searchTerms: '<c:out value="${analyticsEscapedSearchTerm}"/>', 
																 	totalPageNumber: <c:out value="0"/>, 
																  	totalResultCount: <c:out value="0"/>, 
																  	currentPageNumber:<c:out value="0"/>,
																	attributes: "<c:out value="${analyticsEscapedFacetAttributes}"/>"
																	}
																}
															</div>
														</flow:ifEnabled>
															
														<c:if test="${!(empty spellcheck && empty contentspellcheck)}">
															<br/>
															<%-- Help shopper with some suggestions --%>
															<span class="black"><fmt:message key="DID_YOU_MEAN" bundle="${widgetText}"/>&#58;&nbsp;&nbsp;</span>
															<br/>
															<%-- Merge spellcheck and contentspellcheck suggestions and remove duplicates, while maintaining the order --%>
															<c:forEach items="${spellcheck}" varStatus="aStatus">
																<span><a href="${SpellCheckSearchDisplayViewURL}&searchTerm=<c:out value='${aStatus.current}'/>" class="result"><c:out value="${aStatus.current}"/></a></span>
																<span>&nbsp;&nbsp;</span>
															</c:forEach>
														</c:if>
														
														<%-- We did some search ourselves on the first suggested term.. Show the summary --%>
														
														<div class="clear_float"></div>
													</div>
												</div>
											</c:if>
										</div>
									</div>
									<div class="col s12">
										<%-- Target2Sell BEGIN --%>
										<%out.flush();%>
										<c:catch var="exc">
											<ecocea:widgetPath var="emspotpath" identifier="EMarketingSpot" />
											<c:import url="${emspotpath}">
												<c:param name="storeId" value="${storeId}" />
												<c:param name="catalogId" value="${catalogId}" />
												<c:param name="emsName" value="SearchNoResultMarketingSpot_RecoProduits" />
												<c:param name="t2sWidgetSuffix" value="SearchNoResultMarketingSpot_RecoProduits${statusCount}" />
												<c:param name="pageSize" value="4"/>
												<c:param name="displayPreference" value="1"/>
											</c:import>
										</c:catch>
										<%out.flush();%>
										<%-- Target2Sell END --%>
									</div>
									<div class="clear_float"></div>
								</div>
								
							</c:when>
						</c:choose>
						<div class="row mobile-hidden">
							<div class="col s12"><wcpgl:widgetImport slotId="Mea${tabSlotId}"/></div>
						</div>
					</div>
				</div>