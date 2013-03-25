<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
<xsl:output method = "html" />
    
<xsl:template match="/">
     <h1>Выбрать людей, у которых есть телефон.</h1>
     <xsl:apply-templates select="persons/person[phone]" />
            
     <h1>Выбрать людей, у которых есть мобильный телефон.</h1>
     <xsl:apply-templates select="/persons/person[phone/@type='mobile']"/>
     
     <h1>Выбрать людей, у которых есть и рабочий и мобильный телефон.</h1>
     <xsl:apply-templates select="persons/person[phone/@type='work' and phone/@type='mobile']" />
     
     <h1> Выбрать людей, у которых email начинается с `login@`.</h1>
     <xsl:apply-templates select="persons/person[starts-with(email/text(),concat(login/text(),'@'))]"/>
      
     <h1> Выбрать людей, принадлежащих к группе html.</h1>
     <xsl:apply-templates select="persons/person[group/text()='html']" />
      
     <h1>Выбрать людей, у которых "длинный" логин (длиннее трех символов).</h1>
     <xsl:apply-templates select="persons/person[string-length(login/text()) &gt; 3]" />
     
     <h1>Выбрать для каждого человека по одному его контакту -
    мобильный телефон, рабочий телефон или email (что-нибудь одно, все равно что).</h1>
     <xsl:apply-templates select="persons/person[phone/@type='mobile' or phone/@type='work' or email]" mode="a"/> 
      
     <h1>Выбрать для каждого контакта его рабочий телефон, если нет рабочего, то мобильный,
    если нет никакого телефона, то email.</h1>
     <xsl:apply-templates select="persons/person[(phone/@type='mobile' or phone/@type='work') or email]" mode="b" />
     
</xsl:template>

<xsl:template match="persons/person[phone]" >
   <xsl:value-of select="login"/>
   <xsl:if test="not(position()=last())">, </xsl:if>
</xsl:template>
 
<xsl:template match="persons/person[phone/@type='mobile']" >
    <xsl:value-of select="login"/>
    <xsl:if test="not(position()=last())">, </xsl:if>
</xsl:template>       

<xsl:template match="persons/person[phone/@type='work' and phone/@type='mobile']"> 
   <xsl:value-of select="login"/>
   <xsl:if test="not(position()=last())">, </xsl:if>
</xsl:template>

<xsl:template match="persons/person[starts-with(email/text(),concat(login/text(),'@'))]"> 
   <xsl:value-of select="login"/>
   <xsl:if test="not(position()=last())">, </xsl:if>
</xsl:template> 

<xsl:template match="persons/person[group/text()='html']"> 
   <xsl:value-of select="login"/>
   <xsl:if test="not(position()=last())">, </xsl:if>
</xsl:template>

<xsl:template match="persons/person[string-length(login/text()) &gt; 3]"> 
   <xsl:value-of select="login"/>
   <xsl:if test="not(position()=last())">, </xsl:if>
</xsl:template>    
   
<xsl:template match="persons/person[phone/@type='mobile' or phone/@type='work' or email]" mode="a" > 
   <xsl:value-of select="login"/> - <xsl:value-of select="email"/>
   <xsl:if test="not(position()=last())">, </xsl:if>
</xsl:template>

<xsl:template match="persons/person[phone/@type='mobile' or phone/@type='work' or email]" mode="b"> 
   <xsl:value-of select="login"/> -
   
   <xsl:choose>
     <xsl:when test="phone/@type='work'">
          <xsl:value-of select="phone"/>
     </xsl:when>
     <xsl:when test="phone/@type='mobile'">
          <xsl:value-of select="phone"/>
     </xsl:when>
      <xsl:otherwise>
          <xsl:value-of select="email"/>
     </xsl:otherwise>
   </xsl:choose>

   <xsl:if test="not(position()=last())">, </xsl:if>
</xsl:template>  
   
</xsl:stylesheet>    