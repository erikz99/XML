<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
  <xsl:output method="xml" version="1.0" indent="yes"/>
  <xsl:template match="/">
    <fo:root>

      <fo:layout-master-set>
        <fo:simple-page-master page-height="297mm" page-width="210mm" margin="5mm 25mm 5mm 25mm" master-name="catalogueTemp">
          <fo:region-body margin="20mm 0mm 20mm 0mm"/>
        </fo:simple-page-master>
      </fo:layout-master-set>

      <fo:page-sequence master-reference="catalogueTemp">
        <fo:flow flow-name="xsl-region-body" >
          <fo:block>
              <fo:table>
                <fo:table-column column-width="50mm"/>
                <fo:table-column column-width="170mm"/>
                <fo:table-body>
                <xsl:apply-templates select="/catalogue/category"></xsl:apply-templates>
                </fo:table-body>
              </fo:table>
          </fo:block>
        </fo:flow>
      </fo:page-sequence>

    </fo:root>
  </xsl:template>
  <xsl:template match="/catalogue/category">
    <fo:table-row>
      <fo:table-cell number-columns-spanned="2">
        <fo:block font-size="18pt" font-weight="bold">
          <xsl:value-of select="@name"/></fo:block>
      </fo:table-cell>
    </fo:table-row>
    <xsl:for-each select="subcategory">
      <fo:table-row>
        <fo:table-cell number-columns-spanned="2">
          <fo:block font-size="16pt" font-weight="bold" margin-bottom="5mm">
      <xsl:value-of select="@name"/>
          </fo:block>
        </fo:table-cell>
      </fo:table-row>
      <xsl:for-each select="product">
        <xsl:call-template name="product">
          <xsl:with-param name="image_url">
            <xsl:value-of select="image/@url"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="product" match="product">
    <xsl:param name="image_url"/>
      <fo:table-row>
        <fo:table-cell number-rows-spanned="3">
          <fo:block margin-bottom="5mm">
            <fo:external-graphic content-height="scale-to-fit" content-width="150px" position="absolute" text-align="center">
              <xsl:attribute name="src">
                <xsl:value-of select="$image_url"/>
              </xsl:attribute>
            </fo:external-graphic>
          </fo:block>
        </fo:table-cell>
        <fo:table-cell number-columns-spanned="2">
          <fo:block font-size="14pt">
            <xsl:value-of select="name"/>
          </fo:block>
        </fo:table-cell>
      </fo:table-row>
    <fo:table-row>
      <fo:table-cell>
        <fo:block>
          <xsl:value-of select="price"/>лв.
          <xsl:if test="@discount != 'no'">
            <fo:inline font-weight="bold" color="red">Намалено на: <xsl:value-of select="discount_price"/>лв.</fo:inline>
          </xsl:if>
        </fo:block>
      </fo:table-cell>
    </fo:table-row>
    <fo:table-row>
      <fo:table-cell>
        <fo:block>
          <xsl:value-of select="weight"/>
          <xsl:value-of select="weight/@measurement"/>
        </fo:block>
      </fo:table-cell>
    </fo:table-row>
    <fo:table-row>
      <fo:table-cell number-columns-spanned="2">
        <fo:block>
          <fo:inline font-weight="bold">Описание: </fo:inline><xsl:value-of select="description"/>
        </fo:block>
      </fo:table-cell>
    </fo:table-row>
    <fo:table-row>
      <fo:table-cell number-columns-spanned="2">
        <fo:block>
          <fo:inline font-weight="bold">Най-добър до: </fo:inline><xsl:value-of select="due_date"/>
        </fo:block>
      </fo:table-cell>
    </fo:table-row>
    <fo:table-row>
      <fo:table-cell number-columns-spanned="2">
        <fo:block margin-bottom="10mm">
          <fo:inline font-weight="bold">Наличност: </fo:inline>
          <xsl:if test="@available != 'yes'">
            <fo:inline color="red">Изчерпан</fo:inline>
          </xsl:if>
        <xsl:if test="@available != 'no'">
          <fo:inline color="green">Наличен</fo:inline>
          </xsl:if>
          </fo:block>
      </fo:table-cell>
    </fo:table-row>
  </xsl:template>
</xsl:stylesheet>