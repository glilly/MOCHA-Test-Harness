KBAIT1 ;GPL -- tests for mocha
 ;;1.0;MOCHA;**2**;;
 ;
 ; Copyright George Lilly License Apache 2
 ;
 Q
 ;
GETXML(ZRTN,ZNAME) ; ZRTN passed by reference. Returns the XML named ZNAME
 ;
 N ZG S ZG=$NA(^KBAI("MOCHA")) ; root of xml storage
 N ZIEN S ZIEN=$O(@ZG@("TEST",ZNAME,"XML",""))
 I ZIEN="" Q  ; 
 M ZRTN=@ZG@(ZIEN,"XML")
 Q
 ;
GETXMLN(ZRTN,ZNUM) ; ZRTN passed by reference. Returns the XML number ZNUM
 ;
 N ZG S ZG=$NA(^KBAI("MOCHA")) ; root of xml storage
 M ZRTN=@ZG@(ZNUM,"XML")
 Q
 ;
PARSE(ZNUM) ; parse ien ZNUM and put the DOM in xml storage
 N KBAIDID
 W !,"Parsing file ",^KBAI("MOCHA",ZNUM,"NAME"),!
 N GN S GN=$NA(^KBAI("MOCHA",ZNUM,"XML"))
 N ZLAST S ZLAST=$O(@GN@(""),-1) ; end of xml array
 ;I @GN@(ZLAST)'["PEPS" S @GN@(ZLAST+1)="</PEPSResponse>"
 I @GN@(ZLAST)'["</drugInfoResponse" S @GN@(ZLAST+1)="</drugInfoResponse>"
 S KBAIDID=$$EN^MXMLDOM($NA(@GN@("XML")),"W")
 I KBAIDID=0 D  Q  ;
 . ZWRITE ^TMP("MXMLERR",$J,*)
 M ^KBAI("MOCHA",ZNUM,"DOM")=^TMP("MXMLDOM",$J,KBAIDID)
 Q
 ;
FIXXML ; fix xml errors due to reading the xml files into VistA
 N ZI S ZI=1
 N GN S GN=$NA(^KBAI("MOCHA",ZI,"XML"))
 S @GN@(3)=$TR(@GN@(3)," ","") ; remove blanks from attribute line
 Q
 ;
LOAD ; load mocha test xml files into ^KBAI("MOCHA") and index
 N DIRNAME S DIRNAME="/home/glilly/mochatest/" ; xml file directory
 N GR S GR=$NA(^KBAI("MOCHA")) ; global root for mocha tests
 K @GR
 N DONE S DONE=0
 N ZL S ZL=0
 F  D  Q:DONE ; do until done
 . S ZL=ZL+1
 . N ZT
 . N WHERE S WHERE="MOCHATXF+"_ZL_"^KBAIT1"
 . S ZT=$T(@WHERE)
 . I ZT["Q" S DONE=1 Q  ;
 . S ZT=$P(ZT,";;",2)
 . W !,ZT
 . S @GR@(ZL,"NAME")=ZT
 . S @GR@("B",ZT,ZL)=""
 . I ZT["Response" D  ;
 . . N ZTEST S ZTEST=$P(ZT,"Response",1)
 . . N ZMORE S ZMORE=$P(ZT,"Response",2)
 . . S ZMORE=$P(ZMORE,".xml",1)
 . . I ZMORE'="" S ZTEST=ZTEST_ZMORE
 . . S @GR@("TEST",ZTEST,"RESP",ZL)=""
 . E  D  ;
 . . N ZTEST S ZTEST=$P(ZT,".xml",1)
 . . S @GR@("TEST",ZTEST,"XML",ZL)=""
 . N FNAME S FNAME=ZT
 . ;N GN1 S GN1=$NA(@GR@(ZL,"XML",1,0))
 . N GN1 S GN1=$NA(@GR@(ZL,"XML",1))
 . Q:$$FTG^%ZISH(DIRNAME,FNAME,GN1,4)=""
 Q
 ;
MOCHATXF ; mocha test xml files
 ;;1001Response.xml
 ;;1001.xml
 ;;1002Response.xml
 ;;1002.xml
 ;;1004Response.xml
 ;;1004.xml
 ;;1006Response.xml
 ;;1006.xml
 ;;1007Response.xml
 ;;1007.xml
 ;;1009Response.xml
 ;;1009.xml
 ;;1010Response.xml
 ;;1010.xml
 ;;1011Response.xml
 ;;1011.xml
 ;;1012Response.xml
 ;;1012.xml
 ;;1013Response.xml
 ;;1013.xml
 ;;1014Response.xml
 ;;1014.xml
 ;;2101Response.xml
 ;;2101.xml
 ;;2102Response.xml
 ;;2102.xml
 ;;5101Response.xml
 ;;5101.xml
 ;;drugCheckInputMissingAttributeResponse.xml
 ;;drugCheckInputMissingAttribute.xml
 ;;drugCheckInputMissingElementResponse.xml
 ;;drugCheckInputMissingElement.xml
 ;;drugCheckInputWrongEnumerationResponse.xml
 ;;drugCheckInputWrongEnumeration.xml
 ;;drugInfoMultipleResponse.xml
 ;;drugInfoMultiple.xml
 ;;drugInfoSingleResponse.xml
 ;;drugInfoSingle.xml
 ;;drugInfoUnknownGcnResponse.xml
 ;;drugInfoUnknownGcn.xml
 ;;duplicateDrugsResponse.xml
 ;;duplicateDrugs.xml
 ;;duplicateGcnResponse.xml
 ;;duplicateGcn.xml
 ;;duplicateTherapyBugResponse.xml
 ;;duplicateTherapyBug.xml
 ;;noBodyResponse.xml
 ;;noBody.xml
 ;;noChecksResponse.xml
 ;;noChecks.xml
 ;;noDrugsResponse.xml
 ;;noDrugs.xml
 ;;noProspectivesResponse.xml
 ;;noProspectives.xml
 ;;orderCheck1.xml
 ;;orderCheck2.xml
 ;;orderCheck4.xml
 ;;orderCheck7.xml
 ;;orderCheckBigResponse.xml
 ;;orderCheckBig.xml
 ;;orderCheckCustomTables.xml
 ;;orderCheckResponse1.xml
 ;;orderCheckResponse2.xml
 ;;orderCheckResponse4.xml
 ;;orderCheckResponse7.xml
 ;;pingResponse.xml
 ;;ping.xml
 ;;profileOnlyResponse.xml
 ;;profileOnly.xml
 ;;sup01Response.xml
 ;;sup01.xml
 ;;typicalOrderCheckResponse.xml
 ;;typicalOrderCheck.xml
 Q
 ;