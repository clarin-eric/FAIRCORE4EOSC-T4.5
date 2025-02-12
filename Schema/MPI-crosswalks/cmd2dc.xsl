<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:cmd="http://www.clarin.eu/cmd/"
    xmlns:lat="http://lat.mpi.nl/"
    xmlns:iso="http://www.iso.org/"
    xmlns:sil="http://www.sil.org/"
    exclude-result-prefixes="cmd lat iso sil">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>

    <!-- DUBLIN CORE -->
    <xsl:template match="cmd:CMD">
        <oai_dc:dc xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
            xmlns:dc="http://purl.org/dc/elements/1.1/"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.openarchives.org/OAI/2.0/oai_dc/ http://www.openarchives.org/OAI/2.0/oai_dc.xsd">
            <xsl:variable name="dc0">
                <dc:identifier>
                    <xsl:value-of select="replace(./cmd:Header/cmd:MdSelfLink, 'hdl:', 'https://hdl.handle.net/')"/>
                </dc:identifier>
                <xsl:apply-templates select="cmd:Components/*/cmd:Name" mode="dc"/>
                <xsl:apply-templates select="cmd:Components/*/cmd:Title" mode="dc"/>
                <xsl:apply-templates select="cmd:Components/*/cmd:Date" mode="dc"/>
                <xsl:apply-templates select="cmd:Components/*/cmd:Description/cmd:*" mode="dc"/>
                <xsl:apply-templates select="cmd:Components/*/cmd:Actors/cmd:*" mode="dc"/>
                <xsl:apply-templates select="cmd:Components/*/cmd:Contributor/cmd:*" mode="dc"/>
                <dc:publisher>The Language Archive, Max Planck Institute for Psycholinguistics</dc:publisher>
                <xsl:apply-templates select="cmd:Components/*/cmd:Location/cmd:*" mode="dc"/>
                <xsl:apply-templates select="cmd:Components/*/cmd:Content/cmd:*" mode="dc"/>
                <xsl:apply-templates select="cmd:Components/*/cmd:ResearchField" mode="dc"/>
                <xsl:apply-templates select="cmd:Components/*/cmd:Content_Language" mode="dc"/>
                <xsl:apply-templates select="cmd:Components/*/cmd:Resources/cmd:MediaFile/cmd:*" mode="dc"/>
                <xsl:apply-templates select="cmd:Components/*/cmd:Resources/cmd:WrittenResource/cmd:*" mode="dc"/>
                <xsl:apply-templates select="cmd:Components/*/cmd:DataType" mode="dc"/>
                <xsl:apply-templates select="cmd:Components/*/cmd:References/cmd:*" mode="dc"/>
                <xsl:apply-templates select="cmd:Components/*/cmd:Project/cmd:Funder/cmd:fundingReferenceNumber" mode="dc"/>
                <xsl:apply-templates select="cmd:Components/*/cmd:License/cmd:*" mode="dc"/>
            </xsl:variable>
            <xsl:variable name="dcgrouped">
                <xsl:apply-templates select="$dc0" mode="sort"/>
            </xsl:variable>
            <xsl:variable name="dc">
                <xsl:apply-templates select="$dcgrouped" mode="strip"/>
            </xsl:variable>
            <!-- hard coded some fallbacks (created using the VLO-based mapping tool created for DASISH ;-) for non-IMDI-based CMDI profiles
				TODO: make this more generic -->
            <xsl:if test="empty($dc/dc:title[normalize-space() != ''])">
                <xsl:variable name="title" select="/cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1328259700928')]/cmd:Components/cmd:Soundbites-recording/cmd:SESSION/cmd:Name/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1328259700928')]/cmd:Components/cmd:Soundbites-recording/cmd:SESSION/cmd:SessionResources/cmd:WrittenResources/cmd:WrittenResource/cmd:Name/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1328259700937')]/cmd:Components/cmd:Soundbites/cmd:Collection/cmd:GeneralInfo/cmd:Name/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1328259700937')]/cmd:Components/cmd:Soundbites/cmd:Collection/cmd:GeneralInfo/cmd:Title/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1331113992512')]/cmd:Components/cmd:SL-IPROSLA/cmd:SL-Session/cmd:ResourceShortName/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1345561703620')]/cmd:Components/cmd:collection/cmd:CollectionInfo/cmd:Name/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1345561703620')]/cmd:Components/cmd:collection/cmd:CollectionInfo/cmd:Title/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1361876010653')]/cmd:Components/cmd:DiscAn_TextCorpus/cmd:GeneralInfo/cmd:ResourceName/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1361876010653')]/cmd:Components/cmd:DiscAn_TextCorpus/cmd:GeneralInfo/cmd:ResourceTitle/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1361876010653')]/cmd:Components/cmd:DiscAn_TextCorpus/cmd:Publications/cmd:Publication/cmd:PublicationTitle/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1366895758243')]/cmd:Components/cmd:DiscAn_Case/cmd:TextTitle/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1375880372947')]/cmd:Components/cmd:LESLLA/cmd:Session/cmd:Name/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1375880372947')]/cmd:Components/cmd:LESLLA/cmd:Session/cmd:Title/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1375880372947')]/cmd:Components/cmd:LESLLA/cmd:Session/cmd:Utterances/cmd:Utterance/cmd:Resources/cmd:MediaFile/cmd:ResourceID/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1375880372947')]/cmd:Components/cmd:LESLLA/cmd:Session/cmd:Utterances/cmd:Utterance/cmd:Resources/cmd:WrittenResource/cmd:ResourceId/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1396012485083')]/cmd:Components/cmd:VALID/cmd:Session/cmd:Name/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1396012485083')]/cmd:Components/cmd:VALID/cmd:Session/cmd:Title/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1396012485083')]/cmd:Components/cmd:VALID/cmd:Session/cmd:Resources/cmd:MediaFile/cmd:ResourceID/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1396012485083')]/cmd:Components/cmd:VALID/cmd:Session/cmd:Resources/cmd:WrittenResource/cmd:ResourceId/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1396012485083')]/cmd:Components/cmd:VALID/cmd:Session/cmd:Resources/cmd:TestScores/cmd:ResourceID/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1361876010525')]/cmd:Components/cmd:DiscAn_Project/cmd:Project/cmd:ProjectName/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1361876010525')]/cmd:Components/cmd:DiscAn_Project/cmd:Project/cmd:ProjectTitle/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1475136016242')]/cmd:Components/cmd:MPI_Bundle/cmd:Title/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1475136016239')]/cmd:Components/cmd:MPI_Collection/cmd:Title/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1475136016232')]/cmd:Components/cmd:talkbank-license-session/cmd:Session/cmd:Name/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1337778924955')]/cmd:Components/cmd:lucea/cmd:id/text()"/>
                <xsl:if test="exists($title[normalize-space() != ''][1])">
                    <dc:title>
                        <xsl:value-of select="$title[normalize-space() != ''][1]"/>
                    </dc:title>
                </xsl:if>
            </xsl:if>
            <xsl:if test="empty($dc/dc:description[normalize-space() != ''])">
                <xsl:variable name="descr" select="string-join(distinct-values(/cmd:CMD[exists(cmd:Header/cmd:MdProfile[contains(., 'clarin.eu:cr1:p_1328259700928')])]/cmd:Components/(cmd:Soundbites-recording/cmd:SESSION/cmd:Description/text(), cmd:Soundbites-recording/cmd:SESSION/cmd:Description/cmd:Description/text(), cmd:Soundbites-recording/cmd:SESSION/cmd:Content/cmd:Description/text(), cmd:Soundbites-recording/cmd:SESSION/cmd:Content/cmd:Description/cmd:Description/text())), ';'), string-join(distinct-values(/cmd:CMD[exists(cmd:Header/cmd:MdProfile[contains(., 'clarin.eu:cr1:p_1328259700937')])]/cmd:Components/(cmd:Soundbites/cmd:Description/cmd:Description/text(), cmd:Soundbites/cmd:Collection/cmd:GeneralInfo/cmd:Description/text(), cmd:Soundbites/cmd:Collection/cmd:GeneralInfo/cmd:Description/cmd:Description/text())), ';'), string-join(distinct-values(/cmd:CMD[exists(cmd:Header/cmd:MdProfile[contains(., 'clarin.eu:cr1:p_1331113992512')])]/cmd:Components/(cmd:SL-IPROSLA/cmd:SL-Session/cmd:Description/text(), cmd:SL-IPROSLA/cmd:SL-Session/cmd:Description/cmd:Description/text(), cmd:SL-IPROSLA/cmd:SL-Content/cmd:Description/text(), cmd:SL-IPROSLA/cmd:SL-Content/cmd:Description/cmd:Description/text())), ';'), string-join(distinct-values(/cmd:CMD[exists(cmd:Header/cmd:MdProfile[contains(., 'clarin.eu:cr1:p_1337778924955')])]/cmd:Components/(cmd:lucea/cmd:lucea-actors/cmd:facilitator/cmd:languages/cmd:language/cmd:language-usage/cmd:Description/text(), cmd:lucea/cmd:Description/text(), cmd:lucea/cmd:Description/cmd:Description/text())), ';'), string-join(distinct-values(/cmd:CMD[exists(cmd:Header/cmd:MdProfile[contains(., 'clarin.eu:cr1:p_1345561703620')])]/cmd:Components/(cmd:collection/cmd:CollectionInfo/cmd:Modality/cmd:Description/text(), cmd:collection/cmd:CollectionInfo/cmd:Description/text(), cmd:collection/cmd:CollectionInfo/cmd:Description/cmd:Description/text())), ';'), string-join(distinct-values(/cmd:CMD[exists(cmd:Header/cmd:MdProfile[contains(., 'clarin.eu:cr1:p_1361876010525')])]/cmd:Components/(cmd:DiscAn_Project/cmd:Project/cmd:Institution/cmd:Descriptions/cmd:Description/text(), cmd:DiscAn_Project/cmd:Documentations/cmd:Documentation/cmd:Descriptions/cmd:Description/text(), cmd:DiscAn_Project/cmd:Documentations/cmd:Descriptions/cmd:Description/text())), ';'), string-join(distinct-values(/cmd:CMD[exists(cmd:Header/cmd:MdProfile[contains(., 'clarin.eu:cr1:p_1361876010653')])]/cmd:Components/(cmd:DiscAn_TextCorpus/cmd:GeneralInfo/cmd:Descriptions/cmd:Description/text(), cmd:DiscAn_TextCorpus/cmd:Documentations/cmd:Descriptions/cmd:Description/text())), ';'), string-join(distinct-values(/cmd:CMD[exists(cmd:Header/cmd:MdProfile[contains(., 'clarin.eu:cr1:p_1375880372947')])]/cmd:Components/(cmd:LESLLA/cmd:Description/text(), cmd:LESLLA/cmd:Description/cmd:Description/text(), cmd:LESLLA/cmd:Session/cmd:Description/text(), cmd:LESLLA/cmd:Session/cmd:Description/cmd:Description/text(), cmd:LESLLA/cmd:Session/cmd:Content/cmd:Description/text(), cmd:LESLLA/cmd:Session/cmd:Content/cmd:Description/cmd:Description/text())), ';'), string-join(distinct-values(/cmd:CMD[exists(cmd:Header/cmd:MdProfile[contains(., 'clarin.eu:cr1:p_1396012485083')])]/cmd:Components/(cmd:VALID/cmd:Description/text(), cmd:VALID/cmd:Session/cmd:Description/text(), cmd:VALID/cmd:Session/cmd:Description/cmd:Description/text(), cmd:VALID/cmd:Session/cmd:Content/cmd:Description/text(), cmd:VALID/cmd:Session/cmd:Content/cmd:Description/cmd:Description/text(), cmd:VALID/cmd:Documentation/cmd:DocumentationLanguages/cmd:Descriptions/cmd:Description/text(), cmd:VALID/cmd:Documentation/cmd:Descriptions/cmd:Description/text())), ';'), cmd:MPI_Bundle/cmd:Description/text(), cmd:MPI_Collection/cmd:Description/text()"/>
                <xsl:if test="exists($descr[normalize-space() != ''][1])">
                    <dc:description>
                        <xsl:value-of select="$descr[normalize-space() != ''][1]"/>
                    </dc:description>
                </xsl:if>
            </xsl:if>
            <xsl:copy-of copy-namespaces="no" select="$dc"/>
            <!--
            <xsl:comment>extra dc:description to enable full text search of the CMD record</xsl:comment>
			<dc:description>
				<xsl:value-of select="string-join((cmd:Header,cmd:Components)/tokenize(.,'\s+')[normalize-space(.)!=''],' ')"/>
			</dc:description>-->
        </oai_dc:dc>
    </xsl:template>
    
    <xsl:template match="text()" mode="dc"/>
    <!-- Session|Corpus.Name -->
    <xsl:template match="cmd:Components/*/cmd:Name" mode="dc">
        <xsl:call-template name="create-dc-element">
            <xsl:with-param name="dc-name">dc:title</xsl:with-param>
            <xsl:with-param name="value-node" select="."/>
        </xsl:call-template>
    </xsl:template>
    <!-- Session|Corpus.Title -->
    <xsl:template match="cmd:Components/*/cmd:Title" mode="dc">
        <xsl:call-template name="create-dc-element">
            <xsl:with-param name="dc-name">dc:title</xsl:with-param>
            <xsl:with-param name="value-node" select="."/>
        </xsl:call-template>
    </xsl:template>
    <!-- Session.Date + MPI Date -->
    <xsl:template match="cmd:Components/*/cmd:Date" mode="dc">
        <xsl:call-template name="create-dc-element">
            <xsl:with-param name="dc-name">dc:date</xsl:with-param>
            <xsl:with-param name="value-node" select="."/>
        </xsl:call-template>
    </xsl:template>
    <!-- Session.Location.Country -->
    <xsl:template match="cmd:Components/*/cmd:Location/cmd:Country" mode="dc">
        <xsl:call-template name="create-dc-element">
            <xsl:with-param name="dc-name">dc:coverage</xsl:with-param>
            <xsl:with-param name="value-node" select="."/>
        </xsl:call-template>
    </xsl:template>
    <!-- Session.Location.Region -->
    <xsl:template match="cmd:Components/*/cmd:Location/cmd:Region" mode="dc">
        <xsl:call-template name="create-dc-element">
            <xsl:with-param name="dc-name">dc:coverage</xsl:with-param>
            <xsl:with-param name="value-node" select="."/>
        </xsl:call-template>
    </xsl:template>
    <!-- MPI location placename -->
    <xsl:template match="cmd:Components/*/cmd:Location/cmd:PlaceName" mode="dc">
        <xsl:call-template name="create-dc-element">
            <xsl:with-param name="dc-name">dc:coverage</xsl:with-param>
            <xsl:with-param name="value-node" select="."/>
        </xsl:call-template>
    </xsl:template>
    <!-- Session.Content.Genre -->
    <xsl:template match="cmd:Components/*/cmd:Content/cmd:Genre" mode="dc">
        <xsl:call-template name="create-dc-element">
            <xsl:with-param name="dc-name">dc:subject</xsl:with-param>
            <xsl:with-param name="value-node" select="."/>
        </xsl:call-template>
    </xsl:template>
    <!-- Session.Content.SubGenre -->
    <xsl:template match="cmd:Components/*/cmd:Content/cmd:SubGenre" mode="dc">
        <xsl:call-template name="create-dc-element">
            <xsl:with-param name="dc-name">dc:subject</xsl:with-param>
            <xsl:with-param name="value-node" select="."/>
        </xsl:call-template>
    </xsl:template>
    <!-- MPI ResearchField -->
    <xsl:template match="cmd:Components/*/cmd:ResearchField" mode="dc">
        <xsl:call-template name="create-dc-element">
            <xsl:with-param name="dc-name">dc:subject</xsl:with-param>
            <xsl:with-param name="value-node" select="."/>
        </xsl:call-template>
    </xsl:template>
    <!-- Session.Content.Languages.Language.* -->
    <xsl:template match="cmd:Components/*/cmd:Content/cmd:Content_Languages/cmd:Content_Language" mode="dc">
        <xsl:call-template name="create-dc-element">
            <xsl:with-param name="dc-name">dc:language</xsl:with-param>
            <xsl:with-param name="value-node" select="cmd:Name"/>
        </xsl:call-template>
    </xsl:template>
    <xsl:template match="cmd:Components/*/cmd:Content_Language" mode="dc">
        <xsl:call-template name="create-dc-element">
            <xsl:with-param name="dc-name">dc:language</xsl:with-param>
            <xsl:with-param name="value-node" select="cmd:Name"/>
        </xsl:call-template>
    </xsl:template>
    <!-- Session.Actors.Actor.Name -->
    <xsl:template match="cmd:Components/*/cmd:Actors/cmd:Actor/cmd:Name" mode="dc">
        <xsl:call-template name="create-dc-element">
            <xsl:with-param name="dc-name">dc:contributor</xsl:with-param>
            <xsl:with-param name="value-node" select="."/>
        </xsl:call-template>
    </xsl:template>
    <!-- MPI contributor -->
    <xsl:template match="cmd:Components/*/cmd:Contributor/cmd:Name" mode="dc">
        <xsl:call-template name="create-dc-element">
            <xsl:with-param name="dc-name">dc:contributor</xsl:with-param>
            <xsl:with-param name="value-node" select="."/>
        </xsl:call-template>
    </xsl:template>
    <!-- Session.Resources.MediaFile.Type -->
    <xsl:template match="cmd:Components/*/cmd:Resources/cmd:MediaFile/cmd:Type" mode="dc">
        <xsl:call-template name="create-dc-element">
            <xsl:with-param name="dc-name">dc:type</xsl:with-param>
            <xsl:with-param name="value-node" select="."/>
        </xsl:call-template>
    </xsl:template>
    <!-- MPI DataType -->
    <xsl:template match="cmd:Components/*/cmd:DataType" mode="dc">
        <xsl:variable name="type" select="."/>
        <xsl:call-template name="create-dc-element">
            <xsl:with-param name="dc-name">dc:type</xsl:with-param>
            <xsl:with-param name="value-node">
                <xsl:choose>
                    <xsl:when test="contains($type, 'Video')">MovingImage</xsl:when>
                    <xsl:when test="contains($type, 'Audio')">Sound</xsl:when>
                    <xsl:when test="contains($type, 'Images')">StillImage</xsl:when>
                    <xsl:when test="contains($type, 'Photographs')">StillImage</xsl:when>
                    <xsl:when test="contains($type, 'Dictionary')">Text</xsl:when>
                    <xsl:when test="contains($type, 'Field')">Text</xsl:when>
                    <xsl:when test="contains($type, 'description')">Text</xsl:when>
                    <xsl:when test="contains($type, 'annotations')">Text</xsl:when>
                    <xsl:when test="contains($type, 'Transcriptions')">Text</xsl:when>
                    <xsl:when test="contains($type, 'Word')">Text</xsl:when>
                    <xsl:otherwise>Dataset</xsl:otherwise>
                </xsl:choose>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    <!-- Session.Resources.MediaFile.Format -->
    <xsl:template match="cmd:Components/*/cmd:Resources/cmd:MediaFile/cmd:Format" mode="dc">
        <xsl:call-template name="create-dc-element">
            <xsl:with-param name="dc-name">dc:format</xsl:with-param>
            <xsl:with-param name="value-node" select="."/>
        </xsl:call-template>
    </xsl:template>
    <!-- Session.Resources.WrittenResource.Format -->
    <xsl:template match="cmd:Components/*/cmd:Resources/cmd:WrittenResource/cmd:Format" mode="dc">
        <xsl:variable name="format" select="."/>
        <xsl:call-template name="create-dc-element">
            <xsl:with-param name="dc-name">dc:format</xsl:with-param>
            <xsl:with-param name="value-node" select="."/>
        </xsl:call-template>
        <xsl:call-template name="create-dc-element">
            <xsl:with-param name="dc-name">dc:type</xsl:with-param>
            <xsl:with-param name="value-node">
                <xsl:choose>
                    <xsl:when test="$format = 'application/mediatagger'">text</xsl:when>
                    <xsl:when test="$format = 'application/pdf'">text</xsl:when>
                    <xsl:when test="$format = 'text/csv'">text</xsl:when>
                    <xsl:when test="$format = 'text/html'">text</xsl:when>
                    <xsl:when test="$format = 'text/plain'">text</xsl:when>
                    <xsl:when test="$format = 'text/praat-textgrid'">text</xsl:when>
                    <xsl:when test="$format = 'text/x-chat'">text</xsl:when>
                    <xsl:when test="$format = 'text/x-eaf+xml'">text</xsl:when>
                    <xsl:when test="$format = 'text/x-esf'">text</xsl:when>
                    <xsl:when test="$format = 'text/x-shoebox-text'">text</xsl:when>
                    <xsl:when test="$format = 'text/x-shoebox-type'">text</xsl:when>
                    <xsl:when test="$format = 'text/x-toolbox-text'">text</xsl:when>
                    <xsl:when test="$format = 'text/x-trs'">text</xsl:when>
                    <xsl:when test="$format = 'text/xml'">text</xsl:when>
                </xsl:choose>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    <!-- Description -->
    <xsl:template match="cmd:Components/*/cmd:Content/cmd:descriptions/cmd:Description" mode="dc">
        <xsl:if test="not(normalize-space(.) = '')">
            <dc:description xmlns:dc="http://purl.org/dc/elements/1.1/">
                <xsl:copy-of select="@xml:lang"/>
                <xsl:value-of select="text()"/>
                <xsl:if test="not(@Link = '')">
                    <xsl:value-of select="@Link"/>
                </xsl:if>
            </dc:description>
        </xsl:if>
    </xsl:template>
    <!-- Description (content) -->
    <xsl:template match="cmd:Components/*/cmd:descriptions/cmd:Description" mode="dc">
        <xsl:if test="not(normalize-space(.) = '')">
            <dc:description xmlns:dc="http://purl.org/dc/elements/1.1/">
                <xsl:copy-of select="@xml:lang"/>
                <xsl:value-of select="text()"/>
                <xsl:if test="not(@Link = '')">
                    <xsl:value-of select="@Link"/>
                </xsl:if>
            </dc:description>
        </xsl:if>
    </xsl:template>
    <!-- MPI Description -->
    <xsl:template match="cmd:Components/*/cmd:Description/cmd:Description" mode="dc">
        <xsl:if test="not(normalize-space(.) = '')">
            <dc:description xmlns:dc="http://purl.org/dc/elements/1.1/">
                <xsl:copy-of select="@xml:lang"/>
                <xsl:value-of select="text()"/>
            </dc:description>
        </xsl:if>
    </xsl:template>
    <!-- Funding Reference Number as Project Identifier suggested by OpenAIRE (e.g. for use in NARCIS) -->
    <xsl:template match="cmd:Components/*/cmd:Project/cmd:Funder/cmd:fundingReferenceNumber" mode="dc">
        <xsl:call-template name="create-dc-element">
            <xsl:with-param name="dc-name">dc:relation</xsl:with-param>
            <xsl:with-param name="value-node" select="."/>
        </xsl:call-template>
    </xsl:template>
    <!-- MPI License -->
    <xsl:template match="cmd:Components/*/cmd:License/cmd:License" mode="dc">
        <xsl:call-template name="create-dc-element">
            <xsl:with-param name="dc-name">dc:rights</xsl:with-param>
            <xsl:with-param name="value-node" select="."/>
        </xsl:call-template>
    </xsl:template>
    <!-- MPI License URL -->
    <xsl:template match="cmd:Components/*/cmd:License/cmd:LicenseURL" mode="dc">
        <xsl:call-template name="create-dc-element">
            <xsl:with-param name="dc-name">dc:rights</xsl:with-param>
            <xsl:with-param name="value-node" select="."/>
        </xsl:call-template>
    </xsl:template>
    <!-- create dublin core element -->
    <xsl:template name="create-dc-element">
        <xsl:param name="dc-name"/>
        <xsl:param name="value-node"/>
        <xsl:if test="not(normalize-space($value-node) = '') and (normalize-space($value-node) != 'Unspecified')">
            <xsl:element name="{$dc-name}"
                xmlns:dc="http://purl.org/dc/elements/1.1/"
                xmlns:dcterms="http://purl.org/dc/terms/"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
                <xsl:value-of select="normalize-space($value-node)"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <!-- mode to undouble DC fields -->
    <xsl:template match="node() | @*" mode="strip">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="dc:*" mode="strip"
        xmlns:dc="http://purl.org/dc/elements/1.1/">
        <xsl:if test="empty(preceding-sibling::dc:*[local-name()=local-name(current())][.=current()])">
            <xsl:copy>
                <xsl:apply-templates select="node() | @*" mode="#current"/>
            </xsl:copy>
        </xsl:if>
    </xsl:template>
    
    <!-- mode to group DC fields -->
    <xsl:template match="/" mode="sort"
        xmlns:dc="http://purl.org/dc/elements/1.1/">
        <xsl:for-each-group select="dc:*" group-by="name()">
            <xsl:for-each select="current-group()">
                <xsl:copy>
                    <xsl:apply-templates select="node() | @*" mode="#current"/>
                </xsl:copy>
            </xsl:for-each>
        </xsl:for-each-group>
    </xsl:template>
    
    <xsl:template match="@*" mode="sort">
        <xsl:copy/>
    </xsl:template>

</xsl:stylesheet>