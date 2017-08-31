<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
   <ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>
   <pattern>
      <rule context="tei:fvLib/tei:fs/@type">
         <assert test=". = ('arcaico','inova','inova-gl', 'inova-pt')">Either arcaich or innovation</assert>
      </rule>
      <rule context="tei:fvLib/tei:fs">
         <assert test="tei:f[@name = ('description', 'taxonomy')]">
                        One of the following features is required: 
                        'description, taxonomy'</assert>
         <assert test="@xml:id">ID required</assert>
      </rule>
                
                    <rule context="tei:f[@name eq 'description'][parent::fs[@type eq 'variants.taxonomy']]">
         <assert test="tei:string/text()">This cannot be an empty element</assert>
      </rule>
                    <rule context="tei:f[@name eq 'taxonomy'][parent::fs[@type eq 'variants.taxonomy']]">
         <assert test="tei:fs[@type = ('linguistic', 'error', 'material', 'equipolent', 'graphic')]"> Incorrect @type value. Possible values are:
                                'linguistic, error, material, equipolent, graphic'</assert>
      </rule>
                
                <rule context="tei:fs[@type eq 'linguistic'][ancestor::tei:fvLib]">
         <assert test="tei:f[@name = ('category')]">
                    One of the following features is required: 
                    'category'</assert>
      </rule>
      <rule context="tei:f[@name eq 'category'][parent::fs[@type eq 'linguistic']]">
         <assert test="tei:fs[@type = ('phonetic', 'morphosyntactic', 'lexical', 'language', 'transfer')]"> Incorrect @type value. Possible values are:
                                'phonetic, morphosyntactic, lexical, language-transfer'</assert>
      </rule>
                <rule context="tei:fs[@type eq 'phonetic'][ancestor::tei:fvLib]">
         <assert test="tei:f[@name = ('process', 'position', 'constriction')]">
                    One of the following features is required: 
                    'process, position, constriction'</assert>
      </rule>
      <rule context="tei:f[@name eq 'process'][parent::fs[@type eq 'phonetic']]">
         <assert test="tei:symbol[@value = ('addition', 'reduction', 'parallel-evolution')] or tei:fs[@type = ('alteration')]"> Incorrect value. Possible values are: a fs element with one of the following @type attributes
                        'alteration'
                        or a symbol element with one of the following @value attributes
                        'addition, reduction, parallel-evolution'</assert>
      </rule>
      <rule context="tei:f[@name eq 'position'][parent::fs[@type eq 'phonetic']]">
         <assert test="tei:symbol[@value = ('start', 'end', 'intern', 'intervocalic', 'interconsonantic')]"> Incorrect @type value. Possible values are:
                                    'start, end, intern, intervocalic, interconsonantic'</assert>
      </rule>
      <rule context="tei:f[@name eq 'constriction'][parent::fs[@type eq 'phonetic']]">
         <assert test="tei:binary">
                                Binary feature.
                            </assert>
      </rule>
                <rule context="tei:fs[@type eq 'alteration'][ancestor::tei:fvLib]">
         <assert test="tei:f[@name = ('mode')]">
                    One of the following features is required: 
                    'mode'</assert>
      </rule>
      <rule context="tei:f[@name eq 'mode'][parent::fs[@type eq 'alteration']]">
         <assert test="tei:symbol[@value = ('dissimilation', 'metathesis', 'lenition', 'fortition', 'analogy', 'sound-loss')] or tei:fs[@type = ('assimilation')]"> Incorrect value. Possible values are: a fs element with one of the following @type attributes
                        'assimilation'
                        or a symbol element with one of the following @value attributes
                        'dissimilation, metathesis, lenition, fortition, analogy, sound-loss'</assert>
      </rule>
                <rule context="tei:fs[@type eq 'assimilation'][ancestor::tei:fvLib]">
         <assert test="tei:f[@name = ('direction')]">
                    One of the following features is required: 
                    'direction'</assert>
      </rule>
      <rule context="tei:f[@name eq 'direction'][parent::fs[@type eq 'assimilation']]"/>
                <rule context="tei:fs[@type eq 'morphosyntatic'][ancestor::tei:fvLib]">
         <assert test="tei:f[@name = ('POS', 'process')]">
                    One of the following features is required: 
                    'POS, process'</assert>
      </rule>
      <rule context="tei:f[@name eq 'POS'][parent::fs[@type eq 'morphosyntatic']]">
         <assert test="tei:symbol[@value = ('N', 'DET', 'CONJ', 'PREP', 'ADV')] or tei:fs[@type = ('VB', 'PR')]"> Incorrect value. Possible values are: a fs element with one of the following @type attributes
                        'VB, PR'
                        or a symbol element with one of the following @value attributes
                        'N, DET, CONJ, PREP, ADV'</assert>
      </rule>
      <rule context="tei:f[@name eq 'process'][parent::fs[@type eq 'morphosyntatic']]">
         <assert test="tei:symbol[@value = ('stem', 'inflection', 'analogy', 'addition', 'sound-change')] or tei:fs[@type = ('alternation')]"> Incorrect value. Possible values are: a fs element with one of the following @type attributes
                        'alternation'
                        or a symbol element with one of the following @value attributes
                        'stem, inflection, analogy, addition, sound-change'</assert>
      </rule>
                <rule context="tei:fs[@type eq 'alternation'][ancestor::tei:fvLib]">
         <assert test="tei:f[@name = ('lexeme')]">
                    One of the following features is required: 
                    'lexeme'</assert>
      </rule>
      <rule context="tei:f[@name eq 'lexeme'][parent::fs[@type eq 'alternation']]">
         <assert test="tei:vAlt/tei:string/text()">This cannot be an empty element</assert>
      </rule>
                <rule context="tei:fs[@type eq 'VB'][ancestor::tei:fvLib]">
         <assert test="tei:f[@name = ('stem-tense', 'agreement')]">
                    One of the following features is required: 
                    'stem-tense, agreement'</assert>
      </rule>
      <rule context="tei:f[@name eq 'stem-tense'][parent::fs[@type eq 'VB']]">
         <assert test="tei:symbol[@value = ('present', 'past')]"> Incorrect @type value. Possible values are:
                                    'present, past'</assert>
      </rule>
      <rule context="tei:f[@name eq 'agreement'][parent::fs[@type eq 'VB']]">
         <assert test="tei:fs[@name ='concord']">
                        Required fs of type concord</assert>
      </rule>
                <rule context="tei:fs[@type eq 'concord'][ancestor::tei:fvLib]">
         <assert test="tei:f[@name = ('PERS', 'NUM')]">
                    One of the following features is required: 
                    'PERS, NUM'</assert>
      </rule>
      <rule context="tei:f[@name eq 'PERS'][parent::fs[@type eq 'concord']]">
         <assert test="tei:symbol[@value = ('1', '2', '3')]"> Incorrect @type value. Possible values are:
                                    '1, 2, 3'</assert>
      </rule>
      <rule context="tei:f[@name eq 'NUM'][parent::fs[@type eq 'concord']]">
         <assert test="tei:symbol[@value = ('sg', 'pl')]"> Incorrect @type value. Possible values are:
                                    'sg, pl'</assert>
      </rule>
                <rule context="tei:fs[@type eq 'PR'][ancestor::tei:fvLib]">
         <assert test="tei:f[@name = ('agreement', 'case')]">
                    One of the following features is required: 
                    'agreement, case'</assert>
      </rule>
      <rule context="tei:f[@name eq 'agreement'][parent::fs[@type eq 'PR']]">
         <assert test="tei:fs[@name ='concord']">
                        Required fs of type concord</assert>
      </rule>
      <rule context="tei:f[@name eq 'case'][parent::fs[@type eq 'PR']]">
         <assert test="tei:symbol[@value = ('nominative', 'accusative', 'dative', 'genitive')]"> Incorrect @type value. Possible values are:
                                    'nominative, accusative, dative, genitive'</assert>
      </rule>
                <rule context="tei:fs[@type eq 'language-transfer'][ancestor::tei:fvLib]">
         <assert test="tei:f[@name = ('language')]">
                    One of the following features is required: 
                    'language'</assert>
      </rule>
      <rule context="tei:f[@name eq 'language'][parent::fs[@type eq 'language-transfer']]">
         <assert test="tei:symbol[@value = ('sp', 'it')]"> Incorrect @type value. Possible values are:
                                    'sp, it'</assert>
      </rule>
            </pattern>
</schema>
