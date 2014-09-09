<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
<!-- Variables for important values like colors, spaces/margins, height/width -->
	<!-- Colors -->
	<xsl:variable name="Green" select="'rgb(124,176,13)'"/>
	<xsl:variable name="Black" select="'rgb(153,204,255)'"/>
	<xsl:variable name="Grey" select="'rgb(153,204,255)'"/>
	<!-- Font sizes -->
	<xsl:variable name="baseFontSize" select="10"/>
	<xsl:variable name="titleFontSize" select="$baseFontSize + 2"/>
	<xsl:variable name="marginFontSize" select="$baseFontSize - 2"/>
	<!-- XSLT has no styling functionality like CSS. We only use the attributes provided by FO. But we can define attribute sets (which can even cascade) and which are called using xsl:use-attribute-sets="set1 set2", typically in fo:block -->
	<!-- Paragraph styles -->
	<xsl:attribute-set name="standard">
		<xsl:attribute name="font-size"><xsl:value-of select="concat($baseFontSize,'pt')"/></xsl:attribute>
		<xsl:attribute name="font-family">sans-serif</xsl:attribute>
		<xsl:attribute name="text-align">justify</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="marginalia">
		<xsl:attribute name="font-size"><xsl:value-of select="concat($marginFontSize,'pt')"/></xsl:attribute>
		<xsl:attribute name="font-family">sans-serif</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="title1">
		<xsl:attribute name="font-size"><xsl:value-of select="concat($titleFontSize+2, 'pt')"/></xsl:attribute>
		<xsl:attribute name="font-family">Times</xsl:attribute>
		<xsl:attribute name="text-align">center</xsl:attribute>
		<xsl:attribute name="font-variant">small-caps</xsl:attribute>
		<xsl:attribute name="color"><xsl:value-of select="$Green"/></xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="title2">
		<xsl:attribute name="font-size"><xsl:value-of select="concat($titleFontSize,'pt')"/></xsl:attribute>
		<xsl:attribute name="color"><xsl:value-of select="$Green"/></xsl:attribute>
		<xsl:attribute name="font-variant">small-caps</xsl:attribute>
		<xsl:attribute name="font-family">Times</xsl:attribute>
		<xsl:attribute name="text-align">center</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="title3">
		<xsl:attribute name="font-size"><xsl:value-of select="concat($titleFontSize,'pt')"/></xsl:attribute>
		<xsl:attribute name="font-family">sans-serif</xsl:attribute>
		<xsl:attribute name="color"><xsl:value-of select="$Grey"/></xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="title4">
		<xsl:attribute name="font-size"><xsl:value-of select="concat($titleFontSize,'pt')"/></xsl:attribute>
		<xsl:attribute name="font-family">sans-serif</xsl:attribute>
		<xsl:attribute name="font-style">italic</xsl:attribute>
	</xsl:attribute-set>
</xsl:stylesheet>
