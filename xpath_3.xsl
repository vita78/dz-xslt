<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
<xsl:output method = "html" />

<xsl:template match="/">
    <h1> Выбрать `item`'ы, у которых `value` совпадает с порядковым номером в списке, умноженным на 10.</h1>
    <xsl:apply-templates select="items/item" />
    
    <h1> Выбрать `item`'ы, у которых `value` больше, чем у следующего за ним `item`'а..</h1>
    <xsl:apply-templates select="items/item"  mode="a"/>
    
    <h1>Выбрать все хорошие ноды</h1>
    <xsl:apply-templates select="/"  mode="good_nodes"/>
    
    <h1>Выбрать ноды, являющиеся и "хорошими", и "плохими"</h1>
    <xsl:apply-templates select="/"  mode="good_bad"/>
    
    <h1> Выбрать все ноды, не связанные с "плохими" нодами.</h1>
    <xsl:apply-templates select="/"  mode="not_bad"/>
</xsl:template>

<xsl:template match="item">
    <xsl:if test="position()*10 = number(./value/text())">
        <xsl:value-of select="@id"/>
        <xsl:text>  </xsl:text>
    </xsl:if>
</xsl:template>

<xsl:template match="item" mode="a">
    <xsl:if test=" number(./value/text()) &gt; following-sibling::*[1]/self::item">
        <xsl:value-of select="@id"/>
        <xsl:text>  </xsl:text>
    </xsl:if>
</xsl:template>

<xsl:template match="/" mode="good_nodes">
    <xsl:for-each select="items/item">
       <xsl:if test="contains(/items/good/text(), position()) ">
          <xsl:value-of select="@id"/>
          <xsl:text>  </xsl:text>
       </xsl:if>
    </xsl:for-each>
</xsl:template>

<xsl:template match="/" mode="good_bad">
    <xsl:for-each select="items/item">
       <xsl:if test="contains(/items/good/text(),position()) ">
         <xsl:if test="contains(/items/bad/text(),position()) ">
           <xsl:value-of select="@id"/>
           <xsl:text>  </xsl:text>
         </xsl:if>
       </xsl:if>
    </xsl:for-each>
  
</xsl:template>

<xsl:template match="/" mode="not_bad">
    <xsl:for-each select="items/item">
       <xsl:if test="contains(/items/good/text(),position()) ">
         <xsl:if test="not(contains(/items/bad/text(),position())) ">
           <xsl:value-of select="@id"/>
           <xsl:text>  </xsl:text>
         </xsl:if>
       </xsl:if>
    </xsl:for-each>
 </xsl:template>

</xsl:stylesheet>