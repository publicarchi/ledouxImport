<?xml version="1.0" encoding="UTF-8"?>
<!-- first transformation (after docxtotei)-->
<xsl:stylesheet
   xmlns="http://www.tei-c.org/ns/1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:tei="http://www.tei-c.org/ns/1.0"
   exclude-result-prefixes="xs tei"
   version="2.0">
   
   <xsl:output method="xml" indent="yes" encoding="UTF-8"></xsl:output>
   <xsl:strip-space elements="*"/>
   
   <xsl:template match="node() | @*">
      <xsl:copy>
         <xsl:apply-templates select="node() | @*"/>
      </xsl:copy>
   </xsl:template>
   
   <xsl:template match="tei:body">
      <xsl:copy-of select="tei:front"/>
      <listObject>
         <xsl:apply-templates select="tei:div"/>
      </listObject>
   </xsl:template>
   
   <xsl:template match="tei:div[not(tei:div)]">
      <object>
         <xsl:apply-templates/>
      </object>
   </xsl:template>
   
   <xsl:template match="tei:div[tei:div]">
      <object>
         <xsl:apply-templates select="node()[not(self::tei:div)]"/>
         <listObject>
            <xsl:apply-templates select="tei:div"/>
         </listObject>
      </object>
   </xsl:template>
   
   <xsl:template match="tei:div/tei:head">
      <!-- @todo xml:id ?-->
      <xsl:variable name="identifiant">
         <xsl:analyze-string select="normalize-space(.)" regex="\[(.*)\]">
            <xsl:matching-substring><xsl:value-of select="regex-group(1)"/></xsl:matching-substring>
         </xsl:analyze-string>
      </xsl:variable>
      <xsl:variable name="vedette">
         <xsl:analyze-string select="normalize-space(.)" regex="\[.*\]\.?\s–?\s?(.*)">
            <xsl:matching-substring><xsl:value-of select="normalize-space(regex-group(1))"/></xsl:matching-substring>
         </xsl:analyze-string>
      </xsl:variable>
      <objectIdentifier>
         <objectName><xsl:value-of select="$vedette"/></objectName>
         <idno><xsl:value-of select="$identifiant"/></idno>
      </objectIdentifier>
   </xsl:template>
   
   <xsl:template match="tei:p[normalize-space(.)=''][comment()='séparation']">
      <xsl:choose>
         <xsl:when test="following-sibling::*[1][self::tei:p[normalize-space(.)=''][comment()='séparation']]"/>
         <!--à maintenir seules les date et les descriptions sont collées au titre
            <xsl:when test="preceding-sibling::*[1][self::tei:head]"/>-->
         <xsl:when test="following-sibling::*[1][self::tei:div]"/>
         <xsl:when test="not(following-sibling::*)"/>
         <xsl:otherwise><xsl:copy-of select="."/></xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   
   <xsl:template match="tei:p[not(comment())][normalize-space(.)='']"/>
   
   <xsl:template match="tei:seg"><xsl:text> </xsl:text></xsl:template>
   
   <xsl:template match="tei:hi">
      <xsl:choose>
         <xsl:when test="not(@rend)"><xsl:apply-templates/></xsl:when>
         <xsl:otherwise>
            <xsl:copy>
               <xsl:apply-templates select="node() | @rend"/>
            </xsl:copy>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="@style"/>
   <xsl:template match="@xml:space"/>
</xsl:stylesheet>