<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:cmd="http://www.clarin.eu/cmd/"
    xmlns:lat="http://lat.mpi.nl/"
    xmlns:iso="http://www.iso.org/"
    xmlns:sil="http://www.sil.org/"
    exclude-result-prefixes="cmd lat">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>

    <!-- OLAC -->
    <xsl:template match="cmd:CMD">
        <olac:olac xmlns:olac="http://www.language-archives.org/OLAC/1.1/"
            xmlns:dc="http://purl.org/dc/elements/1.1/"
            xmlns:dcterms="http://purl.org/dc/terms/"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.language-archives.org/OLAC/1.1/ http://www.language-archives.org/OLAC/1.1/olac.xsd">
            <xsl:variable name="olac0">
                <dc:identifier xsi:type="dcterms:URI">
                    <xsl:value-of select="replace(./cmd:Header/cmd:MdSelfLink, 'hdl:', 'https://hdl.handle.net/')"/>
                </dc:identifier>
                <xsl:apply-templates select="cmd:Header/cmd:MdCollectionDisplayName" mode="olac"/>
                <xsl:apply-templates select="cmd:Components/*/cmd:Name" mode="olac"/>
                <xsl:apply-templates select="cmd:Components/*/cmd:Title" mode="olac"/>
                <xsl:apply-templates select="cmd:Components/*/cmd:Date" mode="olac"/>
                <xsl:apply-templates select="cmd:Components/*/cmd:Description/cmd:*" mode="olac"/>
                <xsl:apply-templates select="cmd:Components/*/cmd:Actors/cmd:*" mode="olac"/>
                <xsl:apply-templates select="cmd:Components/*/cmd:Contributor/cmd:*" mode="olac"/>
                <dc:publisher>The Language Archive, Max Planck Institute for Psycholinguistics</dc:publisher>
                <xsl:apply-templates select="cmd:Components/*/cmd:Location/cmd:*" mode="olac"/>
                <xsl:apply-templates select="cmd:Components/*/cmd:Content/cmd:*" mode="olac"/>
                <xsl:apply-templates select="cmd:Components/*/cmd:ResearchField" mode="olac"/>
                <xsl:apply-templates select="cmd:Components/*/cmd:Content_Language" mode="olac"/>
                <xsl:apply-templates select="cmd:Components/*/cmd:Resources/cmd:MediaFile/cmd:*" mode="olac"/>
                <xsl:apply-templates select="cmd:Components/*/cmd:Resources/cmd:WrittenResource/cmd:*" mode="olac"/>
                <xsl:apply-templates select="cmd:Components/*/cmd:DataType" mode="olac"/>
                <xsl:apply-templates select="cmd:Components/*/cmd:References/cmd:*" mode="olac"/>
                <xsl:apply-templates select="cmd:Components/*/cmd:Project/cmd:Funder/cmd:fundingReferenceNumber" mode="olac"/>
                <xsl:apply-templates select="cmd:Components/*/cmd:License/cmd:*" mode="olac"/>
            </xsl:variable>
            <xsl:variable name="olacsorted">
                <xsl:apply-templates select="$olac0" mode="sort"/>
            </xsl:variable>
            <xsl:variable name="olac">
                <xsl:apply-templates select="$olacsorted" mode="strip"/>
            </xsl:variable>
            <xsl:if test="empty($olac/dc:title[normalize-space() != ''])">
                <xsl:variable name="title" select="/cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1328259700928')]/cmd:Components/cmd:Soundbites-recording/cmd:SESSION/cmd:Name/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1328259700928')]/cmd:Components/cmd:Soundbites-recording/cmd:SESSION/cmd:SessionResources/cmd:WrittenResources/cmd:WrittenResource/cmd:Name/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1328259700937')]/cmd:Components/cmd:Soundbites/cmd:Collection/cmd:GeneralInfo/cmd:Name/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1328259700937')]/cmd:Components/cmd:Soundbites/cmd:Collection/cmd:GeneralInfo/cmd:Title/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1331113992512')]/cmd:Components/cmd:SL-IPROSLA/cmd:SL-Session/cmd:ResourceShortName/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1345561703620')]/cmd:Components/cmd:collection/cmd:CollectionInfo/cmd:Name/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1345561703620')]/cmd:Components/cmd:collection/cmd:CollectionInfo/cmd:Title/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1361876010653')]/cmd:Components/cmd:DiscAn_TextCorpus/cmd:GeneralInfo/cmd:ResourceName/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1361876010653')]/cmd:Components/cmd:DiscAn_TextCorpus/cmd:GeneralInfo/cmd:ResourceTitle/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1361876010653')]/cmd:Components/cmd:DiscAn_TextCorpus/cmd:Publications/cmd:Publication/cmd:PublicationTitle/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1366895758243')]/cmd:Components/cmd:DiscAn_Case/cmd:TextTitle/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1375880372947')]/cmd:Components/cmd:LESLLA/cmd:Session/cmd:Name/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1375880372947')]/cmd:Components/cmd:LESLLA/cmd:Session/cmd:Title/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1375880372947')]/cmd:Components/cmd:LESLLA/cmd:Session/cmd:Utterances/cmd:Utterance/cmd:Resources/cmd:MediaFile/cmd:ResourceID/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1375880372947')]/cmd:Components/cmd:LESLLA/cmd:Session/cmd:Utterances/cmd:Utterance/cmd:Resources/cmd:WrittenResource/cmd:ResourceId/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1396012485083')]/cmd:Components/cmd:VALID/cmd:Session/cmd:Name/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1396012485083')]/cmd:Components/cmd:VALID/cmd:Session/cmd:Title/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1396012485083')]/cmd:Components/cmd:VALID/cmd:Session/cmd:Resources/cmd:MediaFile/cmd:ResourceID/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1396012485083')]/cmd:Components/cmd:VALID/cmd:Session/cmd:Resources/cmd:WrittenResource/cmd:ResourceId/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1396012485083')]/cmd:Components/cmd:VALID/cmd:Session/cmd:Resources/cmd:TestScores/cmd:ResourceID/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1361876010525')]/cmd:Components/cmd:DiscAn_Project/cmd:Project/cmd:ProjectName/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1361876010525')]/cmd:Components/cmd:DiscAn_Project/cmd:Project/cmd:ProjectTitle/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1475136016242')]/cmd:Components/cmd:MPI_Bundle/cmd:Title/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1475136016239')]/cmd:Components/cmd:MPI_Collection/cmd:Title/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1475136016232')]/cmd:Components/cmd:talkbank-license-session/cmd:Session/cmd:Name/text(), /cmd:CMD[contains(cmd:Header/cmd:MdProfile, 'clarin.eu:cr1:p_1337778924955')]/cmd:Components/cmd:lucea/cmd:id/text()"/>
                <xsl:if test="exists($title[normalize-space() != ''][1])">
                    <dc:title>
                        <xsl:value-of select="$title[normalize-space() != ''][1]"/>
                    </dc:title>
                </xsl:if>
            </xsl:if>
            <xsl:if test="empty($olac/dc:description[normalize-space() != ''])">
                <xsl:variable name="descr" select="string-join(distinct-values(/cmd:CMD[exists(cmd:Header/cmd:MdProfile[contains(., 'clarin.eu:cr1:p_1328259700928')])]/cmd:Components/(cmd:Soundbites-recording/cmd:SESSION/cmd:Description/text(), cmd:Soundbites-recording/cmd:SESSION/cmd:Description/cmd:Description/text(), cmd:Soundbites-recording/cmd:SESSION/cmd:Content/cmd:Description/text(), cmd:Soundbites-recording/cmd:SESSION/cmd:Content/cmd:Description/cmd:Description/text())), ';'), string-join(distinct-values(/cmd:CMD[exists(cmd:Header/cmd:MdProfile[contains(., 'clarin.eu:cr1:p_1328259700937')])]/cmd:Components/(cmd:Soundbites/cmd:Description/cmd:Description/text(), cmd:Soundbites/cmd:Collection/cmd:GeneralInfo/cmd:Description/text(), cmd:Soundbites/cmd:Collection/cmd:GeneralInfo/cmd:Description/cmd:Description/text())), ';'), string-join(distinct-values(/cmd:CMD[exists(cmd:Header/cmd:MdProfile[contains(., 'clarin.eu:cr1:p_1331113992512')])]/cmd:Components/(cmd:SL-IPROSLA/cmd:SL-Session/cmd:Description/text(), cmd:SL-IPROSLA/cmd:SL-Session/cmd:Description/cmd:Description/text(), cmd:SL-IPROSLA/cmd:SL-Content/cmd:Description/text(), cmd:SL-IPROSLA/cmd:SL-Content/cmd:Description/cmd:Description/text())), ';'), string-join(distinct-values(/cmd:CMD[exists(cmd:Header/cmd:MdProfile[contains(., 'clarin.eu:cr1:p_1337778924955')])]/cmd:Components/(cmd:lucea/cmd:lucea-actors/cmd:facilitator/cmd:languages/cmd:language/cmd:language-usage/cmd:Description/text(), cmd:lucea/cmd:Description/text(), cmd:lucea/cmd:Description/cmd:Description/text())), ';'), string-join(distinct-values(/cmd:CMD[exists(cmd:Header/cmd:MdProfile[contains(., 'clarin.eu:cr1:p_1345561703620')])]/cmd:Components/(cmd:collection/cmd:CollectionInfo/cmd:Modality/cmd:Description/text(), cmd:collection/cmd:CollectionInfo/cmd:Description/text(), cmd:collection/cmd:CollectionInfo/cmd:Description/cmd:Description/text())), ';'), string-join(distinct-values(/cmd:CMD[exists(cmd:Header/cmd:MdProfile[contains(., 'clarin.eu:cr1:p_1361876010525')])]/cmd:Components/(cmd:DiscAn_Project/cmd:Project/cmd:Institution/cmd:Descriptions/cmd:Description/text(), cmd:DiscAn_Project/cmd:Documentations/cmd:Documentation/cmd:Descriptions/cmd:Description/text(), cmd:DiscAn_Project/cmd:Documentations/cmd:Descriptions/cmd:Description/text())), ';'), string-join(distinct-values(/cmd:CMD[exists(cmd:Header/cmd:MdProfile[contains(., 'clarin.eu:cr1:p_1361876010653')])]/cmd:Components/(cmd:DiscAn_TextCorpus/cmd:GeneralInfo/cmd:Descriptions/cmd:Description/text(), cmd:DiscAn_TextCorpus/cmd:Documentations/cmd:Descriptions/cmd:Description/text())), ';'), string-join(distinct-values(/cmd:CMD[exists(cmd:Header/cmd:MdProfile[contains(., 'clarin.eu:cr1:p_1375880372947')])]/cmd:Components/(cmd:LESLLA/cmd:Description/text(), cmd:LESLLA/cmd:Description/cmd:Description/text(), cmd:LESLLA/cmd:Session/cmd:Description/text(), cmd:LESLLA/cmd:Session/cmd:Description/cmd:Description/text(), cmd:LESLLA/cmd:Session/cmd:Content/cmd:Description/text(), cmd:LESLLA/cmd:Session/cmd:Content/cmd:Description/cmd:Description/text())), ';'), string-join(distinct-values(/cmd:CMD[exists(cmd:Header/cmd:MdProfile[contains(., 'clarin.eu:cr1:p_1396012485083')])]/cmd:Components/(cmd:VALID/cmd:Description/text(), cmd:VALID/cmd:Session/cmd:Description/text(), cmd:VALID/cmd:Session/cmd:Description/cmd:Description/text(), cmd:VALID/cmd:Session/cmd:Content/cmd:Description/text(), cmd:VALID/cmd:Session/cmd:Content/cmd:Description/cmd:Description/text(), cmd:VALID/cmd:Documentation/cmd:DocumentationLanguages/cmd:Descriptions/cmd:Description/text(), cmd:VALID/cmd:Documentation/cmd:Descriptions/cmd:Description/text())), ';'), cmd:MPI_Bundle/cmd:Description/text(), cmd:MPI_Collection/cmd:Description/text()"/>
                <xsl:if test="exists($descr[normalize-space() != ''][1])">
                    <dc:description>
                        <xsl:value-of select="$descr[normalize-space() != ''][1]"/>
                    </dc:description>
                </xsl:if>
            </xsl:if>
            <xsl:copy-of select="$olac"/>
        </olac:olac>
    </xsl:template>

    <!-- OTHER -->
    <xsl:variable name="sil-lang-top" select="document('sil_to_iso6393.xml')/sil:languages"/>
    <xsl:key name="sil-lookup" match="sil:lang" use="sil:sil"/>
    <xsl:variable name="iso-lang-uri" select="'iso2iso.xml'"/>
    <xsl:variable name="iso-lang-doc" select="document($iso-lang-uri)"/>
    <xsl:variable name="iso-lang-top" select="$iso-lang-doc/iso:m"/>
    <xsl:key name="iso639_1-lookup" match="iso:e" use="iso:o"/>
    <xsl:key name="iso639_2-lookup" match="iso:e" use="iso:b | iso:t"/>
    <xsl:key name="iso639_3-lookup" match="iso:e" use="iso:i"/>
    <xsl:key name="iso639-lookup" match="iso:e" use="iso:i | iso:o | iso:b | iso:t"/>

    <xsl:function name="lat:lang2iso">
        <xsl:param name="language"/>
        <xsl:variable name="codeset" select="replace(substring-before($language, ':'), ' ', '')"/>
        <xsl:variable name="codestr" select="substring-after($language, ':')"/>
        <xsl:variable name="code">
            <xsl:choose>
                <xsl:when test="$codeset = 'ISO639-1'">
                    <xsl:choose>
                        <xsl:when test="$codestr = 'xxx'">
                            <xsl:value-of select="'und'"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:variable name="iso" select="key('iso639_1-lookup', $codestr, $iso-lang-top)/iso:i"/>
                            <xsl:choose>
                                <xsl:when test="$iso != 'xxx'">
                                    <xsl:value-of select="$iso"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:message>WRN: [<xsl:value-of select="$codestr"/>
] is not a ISO 639-1 language code, falling back to und.</xsl:message>
                                    <xsl:value-of select="'und'"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="$codeset = 'ISO639-2'">
                    <xsl:choose>
                        <xsl:when test="$codestr = 'xxx'">
                            <xsl:value-of select="'und'"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:variable name="iso" select="key('iso639_2-lookup', $codestr, $iso-lang-top)/iso:i"/>
                            <xsl:choose>
                                <xsl:when test="$iso != 'xxx'">
                                    <xsl:value-of select="$iso"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:message>WRN: [<xsl:value-of select="$codestr"/>
] is not a ISO 639-2 language code, falling back to und.</xsl:message>
                                    <xsl:value-of select="'und'"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="$codeset = 'ISO639-3'">
                    <xsl:choose>
                        <xsl:when test="$codestr = 'xxx'">
                            <xsl:value-of select="'und'"/>
                        </xsl:when>
                        <xsl:when test="exists(key('iso639_3-lookup', $codestr, $iso-lang-top))">
                            <xsl:value-of select="$codestr"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:message>WRN: [<xsl:value-of select="$codestr"/>
] is not a ISO 639-3 language code, falling back to und.</xsl:message>
                            <xsl:value-of select="'und'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="$codeset = 'ISO639'">
                    <xsl:choose>
                        <xsl:when test="$codestr = 'xxx'">
                            <xsl:value-of select="'und'"/>
                        </xsl:when>
                        <xsl:when test="exists(key('iso639-lookup', $codestr, $iso-lang-top))">
                            <xsl:variable name="iso" select="key('iso639-lookup', $codestr, $iso-lang-top)/iso:i"/>
                            <xsl:choose>
                                <xsl:when test="$iso != 'xxx'">
                                    <xsl:value-of select="$iso"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:message>WRN: [<xsl:value-of select="$codestr"/>
] is not a ISO 639 language code, falling back to und.</xsl:message>
                                    <xsl:value-of select="'und'"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:message>WRN: [<xsl:value-of select="$codestr"/>
] is not a ISO 639 language code, falling back to und.</xsl:message>
                            <xsl:value-of select="'und'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="$codeset = 'RFC1766'">
                    <xsl:choose>
                        <xsl:when test="starts-with($codestr, 'x-sil-')">
                            <xsl:variable name="iso" select="key('sil-lookup', lower-case(replace($codestr, 'x-sil-', '')), $sil-lang-top)/sil:iso"/>
                            <xsl:choose>
                                <xsl:when test="$iso != 'xxx'">
                                    <xsl:value-of select="$iso"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:message>WRN: [<xsl:value-of select="$codestr"/>
] is SIL code (?) with an unknown mapping to ISO 639, falling back to und.</xsl:message>
                                    <xsl:value-of select="'und'"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:message>WRN: [<xsl:value-of select="$codestr"/>
] has no known mapping to ISO 639, falling back to und.</xsl:message>
                            <xsl:value-of select="'und'"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:message>WRN: [<xsl:value-of select="$codestr"/>
] has no known mapping to ISO 639, falling back to und.</xsl:message>
                    <xsl:value-of select="'und'"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:sequence select="$code"/>
    </xsl:function>
    
    <xsl:template match="text()" mode="olac"/>
    
    <!-- Session|Corpus.Name -->
    <xsl:template match="cmd:Components/*/cmd:Name" mode="olac">
        <xsl:call-template name="create-olac-element">
            <xsl:with-param name="dc-name">dc:title</xsl:with-param>
            <xsl:with-param name="value-node" select="."/>
        </xsl:call-template>
    </xsl:template>

    <!-- Session|Corpus.Title -->
    <xsl:template match="cmd:Components/*/cmd:Title" mode="olac">
        <xsl:call-template name="create-olac-element">
            <xsl:with-param name="dc-name">dc:title</xsl:with-param>
            <xsl:with-param name="value-node" select="."/>
        </xsl:call-template>
    </xsl:template>

    <!-- Session.Date + MPI Date -->
    <xsl:template match="cmd:Components/*/cmd:Date" mode="olac">
        <xsl:call-template name="create-olac-element">
            <xsl:with-param name="dc-name">dcterms:created </xsl:with-param>
            <xsl:with-param name="value-node" select="."/>
        </xsl:call-template>
    </xsl:template>

    <!-- Session.Location.Country -->
    <xsl:template match="cmd:Components/*/cmd:Location/cmd:Country" mode="olac">
        <xsl:call-template name="create-olac-element">
            <xsl:with-param name="dc-name">dc:coverage</xsl:with-param>
            <xsl:with-param name="value-node" select="."/>
        </xsl:call-template>
    </xsl:template>

    <!-- Session.Location.Region -->
    <xsl:template match="cmd:Components/*/cmd:Location/cmd:Region" mode="olac">
        <xsl:call-template name="create-olac-element">
            <xsl:with-param name="dc-name">dc:coverage</xsl:with-param>
            <xsl:with-param name="value-node" select="."/>
        </xsl:call-template>
    </xsl:template>

    <!-- MPI location placename -->
    <xsl:template match="cmd:Components/*/cmd:Location/cmd:PlaceName" mode="olac">
        <xsl:call-template name="create-olac-element">
            <xsl:with-param name="dc-name">dc:coverage</xsl:with-param>
            <xsl:with-param name="value-node" select="."/>
        </xsl:call-template>
    </xsl:template>

    <!-- Session.Content.Languages.Language.* . Creating both subject and language elements -->
    <xsl:template match="cmd:Components/*/cmd:Content/cmd:Content_Languages/cmd:Content_Language" mode="olac">
        <xsl:call-template name="create-olac-element">
            <xsl:with-param name="dc-name">dc:subject</xsl:with-param>
            <xsl:with-param name="olac-type">olac:language</xsl:with-param>
            <xsl:with-param name="olac-code" select="lat:lang2iso(cmd:Id)"/>
            <xsl:with-param name="value-node" select="cmd:Name"/>
        </xsl:call-template>
        <xsl:call-template name="create-olac-element">
            <xsl:with-param name="dc-name">dc:language</xsl:with-param>
            <xsl:with-param name="olac-type">olac:language</xsl:with-param>
            <xsl:with-param name="olac-code" select="lat:lang2iso(cmd:Id)"/>
            <xsl:with-param name="value-node" select="cmd:Name"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="cmd:Components/*/cmd:Content_Language" mode="olac">
        <xsl:call-template name="create-olac-element">
            <xsl:with-param name="dc-name">dc:subject</xsl:with-param>
            <xsl:with-param name="olac-type">olac:language</xsl:with-param>
            <xsl:with-param name="olac-code" select="lat:lang2iso(cmd:Id)"/>
            <xsl:with-param name="value-node" select="cmd:Name"/>
        </xsl:call-template>
        <xsl:call-template name="create-olac-element">
            <xsl:with-param name="dc-name">dc:language</xsl:with-param>
            <xsl:with-param name="olac-type">olac:language</xsl:with-param>
            <xsl:with-param name="olac-code" select="lat:lang2iso(cmd:Id)"/>
            <xsl:with-param name="value-node" select="cmd:Name"/>
        </xsl:call-template>
    </xsl:template>

    <!-- Session.Actors.Actor.Role . Creating contributor, mapping some IMDI roles to OLAC roles where possile-->
    <xsl:template match="cmd:Components/*/cmd:Actors/cmd:Actor/cmd:Name" mode="olac">
        <xsl:variable name="name" select="."/>
        <xsl:variable name="role-text" select="../cmd:Role/text()"/>
        <xsl:for-each select="tokenize(../cmd:Role, ',')">
            <xsl:variable name="role" select="normalize-space(.)"/>
            <xsl:choose>
                <xsl:when test="contains('Annotator, Author, Compiler, Collector, Consultant, Depositor, Developer, Editor, Illustrator, Interpreter, Interviewer, Participant, Performer, Photographer, Recorder, Researcher, Responder, Signer, Singer, Speaker/Signer, Speaker, Transcriber, Translator', $role)">
                    <xsl:call-template name="create-olac-element">
                        <xsl:with-param name="dc-name">dc:contributor</xsl:with-param>
                        <xsl:with-param name="olac-type">olac:role</xsl:with-param>
                        <xsl:with-param name="olac-code">
                            <xsl:choose>
                                <xsl:when test="$role = 'Annotator'">annotator</xsl:when>
                                <xsl:when test="$role = 'Author'">author</xsl:when>
                                <xsl:when test="$role = 'Compiler'">compiler</xsl:when>
                                <xsl:when test="$role = 'Collector'">compiler</xsl:when>
                                <xsl:when test="$role = 'Consultant'">consultant</xsl:when>
                                <xsl:when test="$role = 'Depositor'">depositor</xsl:when>
                                <xsl:when test="$role = 'Developer'">developer</xsl:when>
                                <xsl:when test="$role = 'Editor'">editor</xsl:when>
                                <xsl:when test="$role = 'Illustrator'">illustrator</xsl:when>
                                <xsl:when test="$role = 'Interpreter'">interpreter</xsl:when>
                                <xsl:when test="$role = 'Interviewer'">interviewer</xsl:when>
                                <xsl:when test="$role = 'Participant'">participant</xsl:when>
                                <xsl:when test="$role = 'Performer'">performer</xsl:when>
                                <xsl:when test="$role = 'Photographer'">photographer</xsl:when>
                                <xsl:when test="$role = 'Recorder'">recorder</xsl:when>
                                <xsl:when test="$role = 'Researcher'">researcher</xsl:when>
                                <xsl:when test="$role = 'Responder'">responder</xsl:when>
                                <xsl:when test="$role = 'Signer'">signer</xsl:when>
                                <xsl:when test="$role = 'Singer'">singer</xsl:when>
                                <xsl:when test="$role = 'Speaker/Signer'">speaker</xsl:when>
                                <xsl:when test="$role = 'Speaker'">speaker</xsl:when>
                                <xsl:when test="$role = 'Transcriber'">transcriber</xsl:when>
                                <xsl:when test="$role = 'Translator'">translator</xsl:when>
                            </xsl:choose>
                        </xsl:with-param>
                        <xsl:with-param name="value-node" select="$name"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="create-olac-element">
                        <xsl:with-param name="dc-name">dc:contributor</xsl:with-param>
                        <xsl:with-param name="value-node" select="$name"/>
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>

    <!-- MPI contributor role / name -->
    <xsl:template match="cmd:Components/*/cmd:Contributor/cmd:Role" mode="olac">
        <xsl:variable name="role" select="."/>
        <xsl:call-template name="create-olac-element">
            <xsl:with-param name="dc-name">dc:contributor</xsl:with-param>
            <xsl:with-param name="olac-type">olac:role</xsl:with-param>
            <xsl:with-param name="olac-code" select="$role"/>
            <xsl:with-param name="value-node" select="../cmd:Name/text()"/>
        </xsl:call-template>
    </xsl:template>

    <!-- Session.Resources.MediaFile.Type -->
    <xsl:template match="cmd:Components/*/cmd:Resources/cmd:MediaFile/cmd:Type" mode="olac">
        <xsl:variable name="type" select="."/>
        <xsl:call-template name="create-olac-element">
            <xsl:with-param name="dc-name">dc:type</xsl:with-param>
            <xsl:with-param name="xsi-type">dcterms:DCMIType</xsl:with-param>
            <xsl:with-param name="value-node">
                <xsl:choose>
                    <xsl:when test="$type = 'video'">MovingImage</xsl:when>
                    <xsl:when test="$type = 'audio'">Sound</xsl:when>
                    <xsl:when test="$type = 'image'">StillImage</xsl:when>
                </xsl:choose>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <!-- MPI DataType -->
    <xsl:template match="cmd:Components/*/cmd:DataType" mode="olac">
        <xsl:variable name="type" select="."/>
        <xsl:call-template name="create-olac-element">
            <xsl:with-param name="dc-name">dc:type</xsl:with-param>
            <xsl:with-param name="xsi-type">dcterms:DCMIType</xsl:with-param>
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
    <xsl:template match="cmd:Components/*/cmd:Resources/cmd:MediaFile/cmd:Format" mode="olac">
        <xsl:call-template name="create-olac-element">
            <xsl:with-param name="dc-name">dc:format</xsl:with-param>
            <xsl:with-param name="value-node" select="."/>
        </xsl:call-template>
    </xsl:template>

    <!-- Session.Resources.WrittenResource.Format -->
    <xsl:template match="cmd:Components/*/cmd:Resources/cmd:WrittenResource/cmd:Format" mode="olac">
        <xsl:variable name="format" select="."/>
        <xsl:call-template name="create-olac-element">
            <xsl:with-param name="dc-name">dc:format</xsl:with-param>
            <xsl:with-param name="value-node" select="$format"/>
        </xsl:call-template>
        <xsl:call-template name="create-olac-element">
            <xsl:with-param name="dc-name">dc:type</xsl:with-param>
            <xsl:with-param name="xsi-type">dcterms:DCMIType</xsl:with-param>
            <xsl:with-param name="value-node">
                <xsl:choose>
                    <xsl:when test="$format = 'application/mediatagger'">Text</xsl:when>
                    <xsl:when test="$format = 'application/pdf'">Text</xsl:when>
                    <xsl:when test="$format = 'text/csv'">Text</xsl:when>
                    <xsl:when test="$format = 'text/html'">Text</xsl:when>
                    <xsl:when test="$format = 'text/plain'">Text</xsl:when>
                    <xsl:when test="$format = 'text/praat-textgrid'">Text</xsl:when>
                    <xsl:when test="$format = 'text/x-chat'">Text</xsl:when>
                    <xsl:when test="$format = 'text/x-eaf+xml'">Text</xsl:when>
                    <xsl:when test="$format = 'text/x-esf'">Text</xsl:when>
                    <xsl:when test="$format = 'text/x-shoebox-text'">Text</xsl:when>
                    <xsl:when test="$format = 'text/x-shoebox-type'">Text</xsl:when>
                    <xsl:when test="$format = 'text/x-toolbox-text'">Text</xsl:when>
                    <xsl:when test="$format = 'text/x-trs'">Text</xsl:when>
                    <xsl:when test="$format = 'text/xml'">Text</xsl:when>
                </xsl:choose>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="cmd:Header/cmd:MdCollectionDisplayName" mode="olac">
        <xsl:if test="not(normalize-space(.) = '')">
            <xsl:call-template name="create-olac-element">
                <xsl:with-param name="dc-name">dcterms:isPartOf</xsl:with-param>
                <xsl:with-param name="value-node" select="."/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <!-- Description -->
    <xsl:template match="cmd:Components/*/cmd:Content/cmd:descriptions/cmd:Description" mode="olac">
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
    <xsl:template match="cmd:Components/*/cmd:descriptions/cmd:Description" mode="olac">
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

    <!-- Funding Reference Number as Project Identifier suggested by OpenAIRE (e.g. for use in NARCIS) -->
    <xsl:template match="cmd:Components/*/cmd:Project/cmd:Funder/cmd:fundingReferenceNumber" mode="olac">
        <xsl:call-template name="create-olac-element">
            <xsl:with-param name="dc-name">dc:relation</xsl:with-param>
            <xsl:with-param name="value-node" select="."/>
        </xsl:call-template>
    </xsl:template>

    <!-- MPI License -->
    <xsl:template match="cmd:Components/*/cmd:License/cmd:License" mode="olac">
        <xsl:call-template name="create-olac-element">
            <xsl:with-param name="dc-name">dcterms:license</xsl:with-param>
            <xsl:with-param name="value-node" select="."/>
        </xsl:call-template>
    </xsl:template>

    <!-- MPI License URL -->
    <xsl:template match="cmd:Components/*/cmd:License/cmd:LicenseURL" mode="olac">
        <xsl:call-template name="create-olac-element">
            <xsl:with-param name="dc-name">dcterms:license</xsl:with-param>
            <xsl:with-param name="value-node" select="."/>
        </xsl:call-template>
    </xsl:template>
    
    <!-- create olac element -->
    <xsl:template name="create-olac-element">
        <xsl:param name="dc-name"/>
        <xsl:param name="olac-type" select="()"/>
        <xsl:param name="xsi-type" select="()"/>
        <xsl:param name="olac-code" select="()"/>
        <xsl:param name="value-node" select="()"/>
        <xsl:if test="not(normalize-space($value-node) = '') and (normalize-space($value-node) != 'Unspecified')">
            <xsl:element name="{$dc-name}"
                xmlns:dc="http://purl.org/dc/elements/1.1/"
                xmlns:dcterms="http://purl.org/dc/terms/"
                xmlns:olac="http://www.language-archives.org/OLAC/1.1/"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
                <xsl:choose>
                    <xsl:when test="normalize-space($olac-type) != ''">
                        <xsl:attribute name="xsi:type" select="$olac-type"/>
                        <xsl:choose>
                            <xsl:when test="normalize-space($olac-code) != ''">
                                <xsl:attribute name="olac:code" select="normalize-space($olac-code)"/>
                                <xsl:if test="normalize-space($value-node) != ''">
                                    <xsl:value-of select="normalize-space($value-node)"/>
                                </xsl:if>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:attribute name="olac:code" select="normalize-space($value-node)"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="normalize-space($xsi-type) != ''">
                        <xsl:attribute name="xsi:type" select="$xsi-type"/>
                        <xsl:if test="normalize-space($value-node) != ''">
                            <xsl:value-of select="normalize-space($value-node)"/>
                        </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space($value-node)"/>
                    </xsl:otherwise>
                </xsl:choose>
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