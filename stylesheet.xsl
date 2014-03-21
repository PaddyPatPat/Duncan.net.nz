<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" version="4.0"/>

<!--
<xsl:template match="node()|@*">
	<xsl:copy>
		<xsl:apply-templates select="node()|@*"/>
	</xsl:copy>
</xsl:template>
-->

<xsl:template match="text()"/>

<xsl:template match="/">
	<html>
		<head>
			<meta http-equiv="content-type" content="text/html;charset=utf-8" />
			<xsl:call-template name="metaTitle" />
			<xsl:call-template name="metaDescription" />
			<link rel="stylesheet" href="http://duncan.net.nz/stylesheets/stylesheet.css" type="text/css"/>
			<link rel="stylesheet" type="text/css" href="http://duncan.net.nz/tsi-inlineDisqussions-baccbdb/inlineDisqussions.css"/>
			<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
			<script type="text/javascript" src="http://duncan.net.nz/references.js"></script>
			<script type="text/javascript" src="http://duncan.net.nz/tsi-inlineDisqussions-baccbdb/inlineDisqussions.js"></script>
			<!-- <script type="text/javascript" src="jQuery-1.4.1-min.js"></script> -->
			<!-- <script type="text/javascript" src="jquery-1.11.0.js"></script> -->
		</head>
		<body onscroll="scrollingFunctions()" onload="onloadFunctions()">
			<script type="text/javascript">
				disqus_shortname = 'duncannetnz';
				jQuery(document).ready(function() {
					jQuery("p").inlineDisqussions();
				});
			</script>
			<xsl:call-template name="pageTitle" />
			<div id="page">
				<div id="contentsBox">
					<xsl:call-template name="contents" />
				</div>
				<div id="documentBox">
					<div id="document">
						<xsl:apply-templates />
					</div>
				</div>
				<div id="referencesListBox">
					<xsl:call-template name="referencesList" />
				</div>
			</div>
		</body>
	</html>
</xsl:template>



<xsl:template name="pageTitle">
	<div id="pageTitle">
		<img src="{/page/pageImage/attribution/link}" alt="{/page/pageImage/attribution/alt}" id="pageImage"/>
		<h1>
			<xsl:value-of select="page/title/attribution/content" />
		</h1>
	</div>
</xsl:template>

<xsl:template match="page/section/title">
	<h2>
		<a name="{attribution/content}">
			<xsl:value-of select="attribution/content" />
		</a>
	</h2>
</xsl:template>

<xsl:template match="page/section/section/title">
	<h4>
		<a name="{attribution/content}">
			<xsl:value-of select="attribution/content" />
		</a>
	</h4>
</xsl:template>

<!--
<xsl:template match="/page/section/section/section/title">
	<h4>
		<xsl:value-of select="attribution/content"/>
	</h4>
</xsl:template>
-->

<xsl:template match="step/title">
	<h4>
		<xsl:value-of select="attribution/content"/>
	</h4>
</xsl:template>

<xsl:template name="contentAndReference">
	<xsl:for-each select="attribution">
		<xsl:choose>
			<xsl:when test="reference and not(contributor)">
				<span class="piece refID" refID="{reference/refID}" onmouseover='refHover(this);' onmouseout='refUnhover(this);' >
					<xsl:value-of select="content/node()"/>
				</span>
			</xsl:when>
			<xsl:when test="contributor and not(reference)">
				<span class="piece conID" conID="{contributor/conID}" onmouseover='conHover(this);' onmouseout='conUnhover(this);' >
					<xsl:value-of select="content/node()"/>
				</span>
			</xsl:when>
			<xsl:when test="(contributor) and (reference)">
				<span class="piece conID refID" conID="{contributor/conID}" refID="{reference/refID}" onmouseover='refHover(this); conHover(this);' onmouseout='refUnhover(this); conUnhover(this);' >
					<xsl:value-of select="content/node()"/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span class="piece">				
					<xsl:value-of select="content/node()"/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:for-each>
	<xsl:apply-templates />
</xsl:template>

<xsl:template match="p">
	<p>
		<xsl:call-template name="contentAndReference" />
	</p>
</xsl:template>

<!-- Examples -->
<xsl:template match="examples">
	<div id="examples">
		<h3>
			<xsl:text>Examples: </xsl:text>
			<xsl:for-each select="title">		
				<xsl:value-of select="attribution/content"/>
			</xsl:for-each>
		</h3>
		<xsl:apply-templates />
	</div>
</xsl:template>

<xsl:template match="description">
	<p>
		<xsl:call-template name="contentAndReference" />
	</p>
	<xsl:apply-templates />
</xsl:template>

<xsl:template match="example/title">
	<h4>
		<xsl:call-template name="contentAndReference" />
	</h4>
	<xsl:apply-templates />
</xsl:template>

<!-- Method -->

<xsl:template match="method">
	<div id="method">
		<h3>
			<xsl:text>Method: </xsl:text>
			<xsl:for-each select="title">	
				<xsl:call-template name="contentAndReference" />
			</xsl:for-each>	
		</h3>
		<ol>
			<xsl:apply-templates />
		</ol>
	</div>
</xsl:template>


<xsl:template match="step">
	<li>
		<xsl:apply-templates />
	</li>
</xsl:template>


<xsl:template match="step/section" >
	<h4>
		<xsl:for-each select="title">	
			<xsl:call-template name="contentAndReference" />
		</xsl:for-each>	
	</h4>
	<xsl:apply-templates />
</xsl:template>



<!-- Resources -->
<xsl:template match="resources">
	<div id="resource">
		<h3>
			<xsl:text>Resource: </xsl:text>
			<xsl:for-each select="title">	
				<xsl:call-template name="contentAndReference" />
			</xsl:for-each>	
		</h3>
		<xsl:apply-templates />
	</div>
</xsl:template>


<xsl:template match="resource">
	<h3>
		<a href="{link}">
			<xsl:value-of select="title/attribution/content"/>
		</a>
	</h3>
	<xsl:apply-templates />
</xsl:template>

<xsl:template match="resource/description">
	<p>
		<xsl:call-template name="contentAndReference" />
	</p>
</xsl:template>


<!-- System -->
<xsl:template match="system">
	<div id="system">
		<h3>
			<xsl:text>Guidelines: </xsl:text>
			<xsl:for-each select="title">	
				<xsl:call-template name="contentAndReference" />
			</xsl:for-each>	
		</h3>
		<xsl:apply-templates />
	</div>
</xsl:template>

<xsl:template match="guideline">
	<xsl:apply-templates />
</xsl:template>

<!-- Tips -->
<xsl:template match="tips">
	<div id="tips">
		<h3>
			<xsl:text>Tips: </xsl:text>
			<xsl:for-each select="title">	
				<xsl:call-template name="contentAndReference" />
			</xsl:for-each>	
		</h3>
		<xsl:apply-templates />
	</div>
</xsl:template>

<xsl:template match="tip">
	<xsl:apply-templates />
</xsl:template>


<!-- Questions & Answers -->
<xsl:template match="qa">
	<div id="qa">
		<xsl:for-each select="answerer">
			<p>
				<xsl:text>(Answers from </xsl:text>
				<xsl:call-template name="contentAndReference" />
				<xsl:text>)</xsl:text>
			</p>
		</xsl:for-each>
		<xsl:for-each select="qaSet">
			<div id="qaSet">
				<xsl:for-each select="question">
					<p>
						<strong>
							<xsl:text>Question: </xsl:text>
						</strong>
						<xsl:call-template name="contentAndReference" />
					</p>
				</xsl:for-each>
				<xsl:for-each select="answer">
					<p>
						<strong>
							<xsl:text>Answer: </xsl:text>
						</strong>
						<xsl:call-template name="contentAndReference" />
					</p>
				</xsl:for-each>
				<xsl:for-each select="comment">
					<p>
						<strong>
							<xsl:text>Comment: </xsl:text>
						</strong>
						<xsl:call-template name="contentAndReference" />
					</p>
				</xsl:for-each>
			</div>
		</xsl:for-each>
	</div>
</xsl:template>


<!-- Footer -->
<xsl:template match="footer">
	<hr />
	<p>
		<xsl:call-template name="contentAndReference" />
	</p>
	<hr />
</xsl:template>


<xsl:template match="ol">
	<ol>
		<xsl:for-each select="li">
			<li>
				<xsl:call-template name="contentAndReference" />
			</li>
		</xsl:for-each>
	</ol>
</xsl:template>

<xsl:template match="ul">
	<ul>
		<xsl:for-each select="li">
			<li>
				<xsl:call-template name="contentAndReference" />
			</li>
		</xsl:for-each>
	</ul>
</xsl:template>

<xsl:template match="a">
	<a href="{@href}">
		<xsl:value-of select="."/>
	</a>
	<xsl:apply-templates />
</xsl:template>

<xsl:template match="blockquote">
	<blockquote>
		<xsl:value-of select="node()"/>
		<xsl:apply-templates />
	</blockquote>
</xsl:template>


<xsl:template name="referencesList">
	<div id="referenceList">
		<h4>
			<xsl:text>Contributors</xsl:text>
		</h4>
		<ul>
			<xsl:for-each select="//contributor[not(.=preceding::contributor)]">			
				<li conID="{conID}">
					<a href="{homepage}">
						<xsl:value-of select="name" />
					</a>
				</li>
			</xsl:for-each>
		</ul>
		<h4>
			<xsl:text>References</xsl:text>
		</h4>
		<div id="references">
			<xsl:for-each select="//reference[not(.=preceding::reference)]">
				<div id="reference" refID="{refID}">
					<xsl:if test="amazon">				
						<span class="Amazon">
							<a href="{source}">
								<img src="{amazon/image}" />
							</a>
							<img src="{amazon/amazonImage}" />
						</span>
					</xsl:if>
					<a href="{source}">
						<xsl:value-of select="refTitle" />
					</a>
					<xsl:if test="author">
						<xsl:text> by </xsl:text>
						<xsl:value-of select="author" />
					</xsl:if>
					<div style="clear: both;"></div>
				</div>
			</xsl:for-each>
		</div>
	</div>
</xsl:template>



<xsl:template name="contents">
	<div id="contents">
		<h4>
			<xsl:text>
				Page contents
			</xsl:text>
		</h4>
		<ul>
			<xsl:for-each select="/page/section">
				<li>
					<a href="#{title/attribution/content}"> 
						<xsl:value-of select="title/attribution/content" />
					</a>
				</li>
			</xsl:for-each>
		</ul>
	</div>
</xsl:template>

<xsl:template name="metaTitle">
	<title>
		<xsl:value-of select="/page/title/attribution/content" />
	</title>
</xsl:template>

<xsl:template name="metaDescription">
	<meta name="description" content="{/page/metaDescription/attribution/content}" />
</xsl:template>


<!--
					<xsl:for-each select="section">
						<li>
							<a href="#{title/attribution/content}">
								<xsl:value-of select="title/attribution/content" />
							</a>
						</li>
					</xsl:for-each>
-->

</xsl:stylesheet>

