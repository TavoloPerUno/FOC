<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" escape-uri-attributes="yes"/>	
	
	<xsl:attribute-set name="tableBorder">
		<xsl:attribute name="border">1pt black solid</xsl:attribute>		
	</xsl:attribute-set>

	<xsl:attribute-set name="cityHeader">
		<xsl:attribute name="background-color">#B2C675</xsl:attribute>
		<xsl:attribute name="color">black</xsl:attribute>	
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-size">10pt</xsl:attribute>
		<xsl:attribute name="padding">.2em</xsl:attribute>
		<xsl:attribute name="margin-top">2pt</xsl:attribute>		
	</xsl:attribute-set>
	
	<xsl:attribute-set name="dateCell">
	    <xsl:attribute name="font-family">Verdana, Geneva, sans-serif</xsl:attribute>
	    <xsl:attribute name="font-size">9pt</xsl:attribute>	
		<xsl:attribute name="border-color">#B2C675</xsl:attribute>			
		<xsl:attribute name="border-bottom-width">1pt</xsl:attribute>
		<xsl:attribute name="border-bottom-style">solid</xsl:attribute>
		<xsl:attribute name="border-bottom-color">#B2C675</xsl:attribute>
		<xsl:attribute name="border-left-width">1pt</xsl:attribute>
		<xsl:attribute name="border-left-style">solid</xsl:attribute>
		<xsl:attribute name="border-left-color">#B2C675</xsl:attribute>
		<xsl:attribute name="border-right-width">1pt</xsl:attribute>
		<xsl:attribute name="border-right-style">solid</xsl:attribute>
		<xsl:attribute name="border-right-color">#B2C675</xsl:attribute>
		<xsl:attribute name="text-align">center</xsl:attribute>
		<xsl:attribute name="margin-left">2pt</xsl:attribute>
		<xsl:attribute name="margin-right">2pt</xsl:attribute>
		<xsl:attribute name="width">auto</xsl:attribute>	
		<xsl:attribute name="padding">.1em</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:variable name="test">	
		<CATEGORY_LIST>
			<xsl:for-each select="//DATE"/>
		</CATEGORY_LIST>	
	</xsl:variable>	
	
	
	<!--xsl:template match="/">
		<xsl:for-each select="//COURSE">
			<fo:block>
				<xsl:value-of select="TITLE"/>
				<xsl:value-of select="SUBTITLE"/>
			</fo:block>
			<xsl:call-template name="OutputCalendar">
				<xsl:with-param name="pDateList" select="DATE-LIST"/>
			</xsl:call-template>
		</xsl:for-each>

<xsl:copy-of select="$test"/>
	</xsl:template-->
	<xsl:template name="cityThumbnail">
		<xsl:param name="city"/>
		<xsl:param name="outputType"/>
		<xsl:choose>
			<xsl:when test="$outputType = 'PDF'">
			<fo:block>
				<fo:inline float="left"><fo:external-graphic width=".63in" height=".55in" content-width="scale-to-fit" content-height="scale-to-fit" scaling="non-uniform">
				
				
					<xsl:attribute name="src">
    			<xsl:value-of select="concat('../Images/Comelio_', $city, '.png')"/>
    		</xsl:attribute>
				</fo:external-graphic>
				</fo:inline>
				<fo:inline>
				<xsl:value-of select="$city"/>
				</fo:inline>
			</fo:block>
			
			</xsl:when>
			<xsl:when test="$outputType = 'HTML'">
			<div>
				<img display="inline" float="left" class="cityThumbnail">
				
				<xsl:attribute name="src">
    			<xsl:value-of select="concat('../Images/Comelio_', $city, '.png')"/>
    		</xsl:attribute>
				</img>
				<xsl:value-of select="$city"/>
				</div>
				
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="OutputCalendar">
	
		<xsl:param name="pDateList"/>	
		<xsl:param name="language"/>
		<xsl:param name="validCities"/>
		<xsl:param name="outputType"/>
		
		<xsl:choose>
			<xsl:when test="$outputType = 'PDF'">
		<xsl:variable name="firstCity" select="$pDateList/DATE[1]/CITY"/>	
		
		<xsl:for-each select="$pDateList">
			
			<xsl:variable name="unsortedCities" select="distinct-values(DATE[CITY = tokenize($validCities, ',')]/CITY)"/>
			<xsl:variable name="cities" as="xs:string *">
				<xsl:for-each select="$unsortedCities">
					<xsl:sort select="." data-type="text" order="ascending"/>
					<xsl:sequence select="."/>
				</xsl:for-each>
			</xsl:variable>	
			<xsl:variable name="tableMargin">
			<xsl:choose>
				<xsl:when test="count($cities) >= 3">
					<xsl:value-of select="'0%'"/>
				</xsl:when>
				<xsl:when test="count($cities) = 2">
					<xsl:value-of select="'32%'" />
				</xsl:when>				
				<xsl:otherwise>
					<xsl:value-of select="'66%'"/>
				</xsl:otherwise>
			</xsl:choose>
			</xsl:variable>
			<xsl:variable name="tableWidth">
			<xsl:choose>
				<xsl:when test="count($cities) >= 3">
					<xsl:value-of select="'100%'"/>
				</xsl:when>
				<xsl:when test="count($cities) = 2">
					<xsl:value-of select="'68%'" />
				</xsl:when>				
				<xsl:otherwise>
					<xsl:value-of select="'34%'"/>
				</xsl:otherwise>
			</xsl:choose>
			</xsl:variable>
			
			
				
				<fo:table table-layout="fixed" >
						<xsl:attribute name="width">
							<xsl:value-of select="$tableWidth"/>
						</xsl:attribute>
						<xsl:attribute name="margin-left">
						    <xsl:value-of select="$tableMargin"/>
						</xsl:attribute>
					<xsl:choose>
						<xsl:when test="count($cities) >= 3">
							<fo:table-column column-width="33.33%"/>
							<fo:table-column column-width="33.33%"/>
							<fo:table-column column-width="33.33%"/>
						</xsl:when>
						<xsl:when test="count($cities) = 2">
							<fo:table-column column-width="50%"/>
							<fo:table-column column-width="50%"/>							
						</xsl:when>
						<xsl:otherwise>
							<fo:table-column column-width="100%"/>							
						</xsl:otherwise>
					</xsl:choose>
					<fo:table-body start-indent="0pt">
						
						<xsl:for-each select="$cities">
							<xsl:sort select="." data-type="text" order="ascending"/>
							<xsl:if test="position() = 1 or ((position() - 1) mod 3 = 0) ">
								<xsl:variable name="citySet" as="xs:string *">
									<xsl:sequence select="."/>	
									<xsl:variable name="position" select="position()"/>
									
										<xsl:if test="$position != count($cities)">
											<xsl:choose>
												<xsl:when test="($position + 2) le count($cities)">
												<xsl:sequence select="$cities[$position+1]"/>
												<xsl:sequence select="$cities[$position+2]"/>
													
													
												</xsl:when>
												<xsl:otherwise>
													<xsl:sequence select="$cities[$position+1]"/>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:if>
																		
								</xsl:variable>
								
								<fo:table-row>
									<xsl:choose>
										<xsl:when test="count($citySet) = 1 and count($cities) != 1">												
											<fo:table-cell><fo:block xsl:use-attribute-sets="">
												<xsl:value-of select="count($citySet)"/>												
											</fo:block></fo:table-cell>
											<fo:table-cell><fo:block xsl:use-attribute-sets="">
												<xsl:value-of select="count($citySet)"/>												
											</fo:block></fo:table-cell>
										</xsl:when>
										<xsl:when test="count($citySet) = 2 and count($cities) != 2">
											<fo:table-cell><fo:block xsl:use-attribute-sets="">
																				
											</fo:block></fo:table-cell>
										</xsl:when>
									</xsl:choose>
									<xsl:for-each select="$citySet">
										<xsl:variable name="currentCity" select="."/>
									<fo:table-cell>
											<fo:block xsl:use-attribute-sets="dateCell cityHeader">
												<xsl:value-of select="."/>												
											</fo:block>
											<fo:block xsl:use-attribute-sets="dateCell">
												
												
													<xsl:value-of select="concat( ($pDateList/DATE[CITY =$currentCity][1])/PRICE, ' ', ($pDateList/DATE[CITY =  $currentCity])[1]/PRICE/@currencyCode)"/>					
												
											</fo:block>
											<fo:block xsl:use-attribute-sets="dateCell">
												<xsl:for-each select="$pDateList/DATE[CITY =$currentCity][position() le 4]">
													<fo:block>
													<xsl:choose>
														<xsl:when test="year-from-date(START_DATE) = year-from-date(END_DATE)">
															<xsl:choose>									
																<xsl:when test="month-from-date(START_DATE) = month-from-date(END_DATE)">
																	<xsl:value-of select="concat(format-date(START_DATE, '[D, 2-2]'), '-', format-date(END_DATE, '[D, 2-2] [MNn,1-1]', $language, (), ()))"/>								
																</xsl:when>
																<xsl:otherwise>
																	<xsl:value-of select="concat(format-date(START_DATE, '[D, 2-2] [MNn,1-1]', $language, (), ()), ' - ', format-date(END_DATE,'[D, 2-2] [MNn,1-1]', $language, (), ()))"/>	
																</xsl:otherwise>
															</xsl:choose>
														</xsl:when>
														<xsl:otherwise>
															<xsl:value-of select="concat(format-date(START_DATE, '[D, 2-2] [MNn,1-1]', $language, (), ()), ' - ', format-date(END_DATE,'[D, 2-2] [MNn,1-1]', $language, (), ()))"/>	
														</xsl:otherwise>								
													</xsl:choose>
													</fo:block>
												</xsl:for-each>
											</fo:block>
										</fo:table-cell>
									</xsl:for-each>
									
								</fo:table-row>
							</xsl:if>							
								
						</xsl:for-each>
					</fo:table-body>
				</fo:table>	
					
			
		</xsl:for-each>
		</xsl:when>
		<xsl:otherwise>
		
		<xsl:variable name="firstCity" select="$pDateList/DATE[1]/CITY"/>	
		
		<xsl:for-each select="$pDateList">
			
			<xsl:variable name="unsortedCities" select="distinct-values(DATE/CITY)"/>
			<xsl:variable name="cities" as="xs:string *">
				<xsl:for-each select="$unsortedCities">
					<xsl:sort select="." data-type="text" order="ascending"/>
					<xsl:sequence select="."/>
				</xsl:for-each>
			</xsl:variable>	
			<xsl:variable name="tableMargin">
			<xsl:choose>
				<xsl:when test="count($cities) >= 3">
					<xsl:value-of select="'0%'"/>
				</xsl:when>
				<xsl:when test="count($cities) = 2">
					<xsl:value-of select="'32%'" />
				</xsl:when>				
				<xsl:otherwise>
					<xsl:value-of select="'66%'"/>
				</xsl:otherwise>
			</xsl:choose>
			</xsl:variable>
			<xsl:variable name="tableWidth">
			<xsl:choose>
				<xsl:when test="count($cities) >= 3">
					<xsl:value-of select="'100%'"/>
				</xsl:when>
				<xsl:when test="count($cities) = 2">
					<xsl:value-of select="'68%'" />
				</xsl:when>				
				<xsl:otherwise>
					<xsl:value-of select="'34%'"/>
				</xsl:otherwise>
			</xsl:choose>
			</xsl:variable>		
				<div display="table" >
				<xsl:attribute name="width">
						    <xsl:value-of select="$tableWidth"/>
						</xsl:attribute>
				<table table-layout="fixed" class="htmlTable">
						
						<xsl:attribute name="margin-left">
						    <xsl:value-of select="$tableMargin"/>
						</xsl:attribute>
					
					
					
						
						<xsl:for-each select="$cities">
							<xsl:sort select="." data-type="text" order="ascending"/>
							<xsl:if test="position() = 1 or ((position() - 1) mod 3 = 0) ">
								<xsl:variable name="citySet" as="xs:string *">
									<xsl:sequence select="."/>	
									<xsl:variable name="position" select="position()"/>
									
										<xsl:if test="$position != count($cities)">
											<xsl:choose>
												<xsl:when test="($position + 2) le count($cities)">
												<xsl:sequence select="$cities[$position+1]"/>
												<xsl:sequence select="$cities[$position+2]"/>
													
													
												</xsl:when>
												<xsl:otherwise>
													<xsl:sequence select="$cities[$position+1]"/>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:if>
																		
								</xsl:variable>
								
								<tr valign="top">
									<xsl:choose>
										<xsl:when test="count($citySet) = 1 and count($cities) != 1">												
											<td><div >
												<xsl:value-of select="count($citySet)"/>												
											</div></td>
											<td><div xsl:use-attribute-sets="">
												<xsl:value-of select="count($citySet)"/>												
											</div></td>
										</xsl:when>
										<xsl:when test="count($citySet) = 2 and count($cities) != 2">
											<td><div >
																				
											</div></td>
										</xsl:when>
									</xsl:choose>
									<xsl:for-each select="$citySet">
										<xsl:variable name="currentCity" select="."/>
									<td>
											<div class="dateCell cityHeader">
												<xsl:value-of select="."/>												
											</div>
											<div class="dateCell">
												
												<div class="inline">
													<xsl:value-of select="concat(($pDateList/DATE[CITY =  $currentCity])[1]/PRICE/@currencySymbol, ($pDateList/DATE[CITY =$currentCity][1])/PRICE)"/>													
												</div>
												<div class="inline super">*</div>
											</div>
											<div class="dateCell">
												<xsl:for-each select="$pDateList/DATE[CITY =$currentCity][position() le 4]">
													<div>
													<xsl:choose>
														<xsl:when test="year-from-date(START_DATE) = year-from-date(END_DATE)">
															<xsl:choose>									
																<xsl:when test="month-from-date(START_DATE) = month-from-date(END_DATE)">
																	<xsl:value-of select="concat(format-date(START_DATE, '[D]'), '-', format-date(END_DATE, '[D] [MNn,1-1]', $language, (), ()))"/>								
																</xsl:when>
																<xsl:otherwise>
																	<xsl:value-of select="concat(format-date(START_DATE, '[D] [MNn,1-1]', $language, (), ()), ' - ', format-date(END_DATE,'[D] [MNn,1-1]', $language, (), ()))"/>	
																</xsl:otherwise>
															</xsl:choose>
														</xsl:when>
														<xsl:otherwise>
															<xsl:value-of select="concat(format-date(START_DATE, '[D] [MNn,1-1]', $language, (), ()), ' - ', format-date(END_DATE,'[D] [MNn,1-1]', $language, (), ()))"/>	
														</xsl:otherwise>								
													</xsl:choose>
													</div>
												</xsl:for-each>
											</div>
										</td>
									</xsl:for-each>
									
								</tr>
							</xsl:if>							
								
						</xsl:for-each>
					
				</table>	
				</div>
					
			
		</xsl:for-each>
		</xsl:otherwise>
		</xsl:choose>	
		
	
	</xsl:template>
</xsl:stylesheet>
