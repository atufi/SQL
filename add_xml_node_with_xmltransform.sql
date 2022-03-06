SELECT
  XMLtransform(
    s.xml_content, 
    XMLType ('<?xml version="1.0"?> 
             <xsl:stylesheet version="1.0"     
                             xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                             xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:VM="http://thrita.behdasht.gov.ir/VM/" xmlns:a="http://thrita.behdasht.gov.ir/ClinicalClass/"
                             >
              
               <xsl:template match="VM:ServiceDetailsVO">
                 <xsl:copy>
                   <xsl:attribute name="ID">
                    <xsl:value-of select="position()"/>
                   </xsl:attribute>            
                   <xsl:apply-templates select="@*|node()">       
                   </xsl:apply-templates>
                 </xsl:copy>
               </xsl:template>
               <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
             </xsl:stylesheet>' )
    )
  FROM   s 
