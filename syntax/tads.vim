" Vim syntax file
" Language:	TADS 3
" Maintainer:	Carlos Augusto Marcicano <caugmar@gmail.com>
" $Date: 2024/08/22 14:19 $
" $Revision: 1.0 $
" Stolen from: Amir Karger <karger@post.harvard.edu> TADS syntax file

" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" A bunch of useful keywords
syn keyword tadsStatement	goto break return continue pass try finally
syn keyword tadsLabel		case default
syn keyword tadsConditional	if else end switch
syn keyword tadsRepeat		while for do foreach
syn keyword tadsStorageClass	local compoundWord formatstring specialWords
syn keyword tadsBoolean		nil true

" TADS keywords
syn keyword tadsKeyword		class replace modify
syn keyword tadsKeyword		global self inherited
" builtin functions
syn keyword tadsKeyword		cvtstr cvtnum caps lower upper substr
syn keyword tadsKeyword		say length
syn keyword tadsKeyword		setit setscore
syn keyword tadsKeyword		datatype proptype
syn keyword tadsKeyword		car cdr
syn keyword tadsKeyword		defined isclass
syn keyword tadsKeyword		find firstobj nextobj
syn keyword tadsKeyword		getarg argcount
syn keyword tadsKeyword		input yorn askfile
syn keyword tadsKeyword		rand randomize
syn keyword tadsKeyword		restart restore quit save undo
syn keyword tadsException	abort exit exitobj

syn keyword tadsTodo contained	TODO FIXME XXX

" String and Character constants
" Highlight special characters (those which have a backslash) differently
syn match tadsSpecial contained	"\\."
syn region tadsDoubleString		start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=tadsSpecial,tadsEmbedded
syn region tadsSingleString		start=+'+ skip=+\\\\\|\\'+ end=+'+ contains=tadsSpecial
" Embedded expressions in strings
syn region tadsEmbedded contained       start="<<" end=">>" contains=tadsKeyword

" TADS doesn't have \xxx, right?
"syn match cSpecial contained	"\\[0-7][0-7][0-7]\=\|\\."
"syn match cSpecialCharacter	"'\\[0-7][0-7]'"
"syn match cSpecialCharacter	"'\\[0-7][0-7][0-7]'"

"catch errors caused by wrong parenthesis
"syn region cParen		transparent start='(' end=')' contains=ALLBUT,cParenError,cIncluded,cSpecial,cTodo,cUserCont,cUserLabel
"syn match cParenError		")"
"syn match cInParen contained	"[{}]"
syn region tadsBrace		transparent start='{' end='}' contains=ALLBUT,tadsBraceError,tadsIncluded,tadsSpecial,tadsTodo
syn match tadsBraceError		"}"

"integer number (TADS has no floating point numbers)
syn case ignore
syn match tadsNumber		"\<[0-9]\+\>"
"hex number
syn match tadsNumber		"\<0x[0-9a-f]\+\>"
syn match tadsIdentifier	"\<[a-z][a-z0-9_$]*\>"
syn case match
" flag an octal number with wrong digits
syn match tadsOctalError		"\<0[0-7]*[89]"

" Removed complicated c_comment_strings
syn region tadsComment		start="/\*" end="\*/" contains=tadsTodo
syn match tadsComment		"//.*" contains=tadsTodo
syntax match tadsCommentError	"\*/"

syn region tadsPreCondit	start="^\s*#\s*\(if\>\|ifdef\>\|ifndef\>\|elif\>\|else\>\|endif\>\)" skip="\\$" end="$" contains=tadsComment,tadsString,tadsNumber,tadsCommentError
syn region tadsIncluded contained start=+"+ skip=+\\\\\|\\"+ end=+"+
syn match tadsIncluded contained "<[^>]*>"
syn match tadsInclude		"^\s*#\s*include\>\s*["<]" contains=tadsIncluded
syn region tadsDefine		start="^\s*#\s*\(define\>\|undef\>\)" skip="\\$" end="$" contains=ALLBUT,tadsPreCondit,tadsIncluded,tadsInclude,tadsDefine,tadsInBrace,tadsIdentifier

syn region tadsPreProc start="^\s*#\s*\(pragma\>\|line\>\|warning\>\|warn\>\|error\>\)" skip="\\$" end="$" contains=ALLBUT,tadsPreCondit,tadsIncluded,tadsInclude,tadsDefine,tadsInParen,tadsIdentifier

" Highlight User Labels
" TODO labels for gotos?
"syn region	cMulti		transparent start='?' end=':' contains=ALLBUT,cIncluded,cSpecial,cTodo,cUserCont,cUserLabel,cBitField
" Avoid matching foo::bar() in C++ by requiring that the next char is not ':'
"syn match	cUserCont	"^\s*\I\i*\s*:$" contains=cUserLabel
"syn match	cUserCont	";\s*\I\i*\s*:$" contains=cUserLabel
"syn match	cUserCont	"^\s*\I\i*\s*:[^:]" contains=cUserLabel
"syn match	cUserCont	";\s*\I\i*\s*:[^:]" contains=cUserLabel

"syn match	cUserLabel	"\I\i*" contained

" identifier: class-name [, class-name [...]] [property-list] ;
" Don't highlight comment in class def
syn match tadsClassDef		"\<class\>[^/]*" contains=tadsObjectDef,tadsClass
syn match tadsClass contained   "\<class\>"
syn match tadsObjectDef "\<[a-zA-Z][a-zA-Z0-9_$]*\s*:\s*[a-zA-Z0-9_$]\+\(\s*,\s*[a-zA-Z][a-zA-Z0-9_$]*\)*\(\s*;\)\="
syn keyword tadsFunction contained function
syn match tadsFunctionDef	 "\<[a-zA-Z][a-zA-Z0-9_$]*\s*:\s*function[^{]*" contains=tadsFunction
"syn region tadsObject		  transparent start = '[a-zA-Z][\i$]\s*:\s*' end=";" contains=tadsBrace,tadsObjectDef

" How far back do we go to find matching groups
if !exists("tads_minlines")
  let tads_minlines = 15
endif
exec "syn sync ccomment tadsComment minlines=" . tads_minlines
if !exists("tads_sync_dist")
  let tads_sync_dist = 100
endif
execute "syn sync maxlines=" . tads_sync_dist

" Define the default highlighting.
" Only when an item doesn't have highlighting yet

" The default methods for highlighting.  Can be overridden later
hi def link tadsFunctionDef Function
hi def link tadsFunction  Structure
hi def link tadsClass     Structure
hi def link tadsClassDef  Identifier
hi def link tadsObjectDef Identifier
" no highlight for tadsEmbedded, so it prints as normal text w/in the string

hi def link tadsOperator	Operator
hi def link tadsStructure	Structure
hi def link tadsTodo	Todo
hi def link tadsLabel	Label
hi def link tadsConditional	Conditional
hi def link tadsRepeat	Repeat
hi def link tadsException	Exception
hi def link tadsStatement	Statement
hi def link tadsStorageClass	StorageClass
hi def link tadsKeyWord   Keyword
hi def link tadsSpecial	SpecialChar
hi def link tadsNumber	Number
hi def link tadsBoolean	Boolean
hi def link tadsDoubleString	tadsString
hi def link tadsSingleString	tadsString

hi def link tadsOctalError	tadsError
hi def link tadsCommentError	tadsError
hi def link tadsBraceError	tadsError
hi def link tadsInBrace	tadsError
hi def link tadsError	Error

hi def link tadsInclude	Include
hi def link tadsPreProc	PreProc
hi def link tadsDefine	Macro
hi def link tadsIncluded	tadsString
hi def link tadsPreCondit	PreCondit

hi def link tadsString	String
hi def link tadsComment	Comment

" Minhas alterações
syn keyword tadsClassName Achievement Actor AltTopic AskForTopic
syn keyword tadsClassName AskTellTopic AskTopic Board ByeTopic Climb
syn keyword tadsClassName ComplexComponent Component ConvNode
syn keyword tadsClassName CustomRoomLister Daemon Decoration Default
syn keyword tadsClassName DefaultAskTellTopic DefaultGiveShowTopic
syn keyword tadsClassName DefineTAction DigWith Distant Eat Enter Enterable
syn keyword tadsClassName Examine FakeConnector Fixture Fuse GiveShowTopic
syn keyword tadsClassName HelloTopic Immovable ImpByeTopic
syn keyword tadsClassName InstructionsAction Intangible Look LookIn
syn keyword tadsClassName LookListPortables LookListSpecials LookThrough
syn keyword tadsClassName MoveWith MultiInstance MultiLoc Noise NoTopic
syn keyword tadsClassName NoTravelMessage Odor OneWayRoomConnector Open
syn keyword tadsClassName Openable OpenableContainer Push PutIn Readable Row
syn keyword tadsClassName Search SenseConnector SenseDaemon
syn keyword tadsClassName ShuffledEventList Smell SpecialTopic StopEventList
syn keyword tadsClassName SuggestedAskTopic Surface Take Thing TravelMessage
syn keyword tadsClassName TravelVia TurnOn Up Vector VerbRule YesTopic
syn keyword tadsClassName DeadEndConnector

syn keyword tadsConstant adventium defaultCeiling defaultEastWall
syn keyword tadsConstant defaultFloor defaultNorthWall defaultSky
syn keyword tadsConstant defaultSouthWall defaultWestWall
syn keyword tadsConstant finishOptionFullScore finishOptionUndo ftVictory
syn keyword tadsConstant glass objVisible paper standing touchObj

syn keyword tadsMethod action actorInAName actorInName actorInPrep
syn keyword tadsMethod actorIntoName actorOutOfName actorOutOfPrep
syn keyword tadsMethod addToScore addToScoreOnce aDisambigName
syn keyword tadsMethod aDisambigName adjustLookAroundTable afterTravel
syn keyword tadsMethod allStates allSubLocations aName aName aNameObj
syn keyword tadsMethod append asDobjFor asExit authorEmail
syn keyword tadsMethod beforeRunsBeforeCheck bottomRoom brightness bulk
syn keyword tadsMethod bulk bulkCapacity byline cacheScopeList canBeHeard
syn keyword tadsMethod canBeSeen canBeSmelled canBeTouched canMatchHer
syn keyword tadsMethod canMatchHim canMatchIt canMatchThem cannotCrossMsg
syn keyword tadsMethod cannotReachFromOutsideMsg canObjReachContents
syn keyword tadsMethod canResolvePossessive canReturnItem canTalkTo
syn keyword tadsMethod canTravelerPass check circularlyInMessage
syn keyword tadsMethod collectiveGroup collectiveGroups connector
syn keyword tadsMethod connectorMaterial contents contentsListed
syn keyword tadsMethod contentsListedInExamine contentsListedSeparately
syn keyword tadsMethod contentsLister customVerbs daemon desc
syn keyword tadsMethod descContentsLister described descWithSource
syn keyword tadsMethod destination disambigEquivName disambigEquivName
syn keyword tadsMethod disambigName disambigName disambigPromptOrder
syn keyword tadsMethod displaySchedule distantDesc distantInitSpecialDesc
syn keyword tadsMethod distantSpecialDesc distinguishers dobjFor down
syn keyword tadsMethod dummyName east effectiveFollowLocation
syn keyword tadsMethod enteringRoom equivalenceKey equivalentGrouper
syn keyword tadsMethod equivalentGrouperClass equivalentGrouperTable
syn keyword tadsMethod esEndingPat eventPercent eventReduceAfter
syn keyword tadsMethod eventReduceTo explainTravelBarrier
syn keyword tadsMethod explicitVisualSenseInfo failCheck finishGameMsg
syn keyword tadsMethod firstObj gActor gDobj getActor getFacets
syn keyword tadsMethod getOutermostRoom getState gIobj globalParamName
syn keyword tadsMethod globalParamName gPlayerChar gSetKnown gTopicText
syn keyword tadsMethod handleTopic hasSeen hereWithSource holdingIndex
syn keyword tadsMethod htmlByline htmlDesc iesEndingPat IFID illogical
syn keyword tadsMethod illogicalAlready illogicalNow in initDesc
syn keyword tadsMethod initialLocationClass initialPlayerChar
syn keyword tadsMethod initiateConversation initNominalRoomPartLocation
syn keyword tadsMethod initSpecialDesc initSpecialDesc
syn keyword tadsMethod inlineContentsLister inRoomName iobjFor isActive
syn keyword tadsMethod isConversational isEquivalent isEquivalent
syn keyword tadsMethod isHeldBy isHer isHer isHer isHim isHim isHim isIn
syn keyword tadsMethod isInInitState isInitState isIt isKnown
syn keyword tadsMethod isLikelyCommandTarget isListedAboardVehicle
syn keyword tadsMethod isLocked isMassNoun isMassNoun isOn isOpen isOpen
syn keyword tadsMethod isPlural isPlural isPlural isProperName
syn keyword tadsMethod isProperName isQualifiedName isQualifiedName
syn keyword tadsMethod isThingConstructed isTopLevel isWornBy itIs
syn keyword tadsMethod itIsContraction itNom itObj itPossAdj itPossNoun
syn keyword tadsMethod itReflexive keyList listName listName listWith
syn keyword tadsMethod location location locationList lookAround
syn keyword tadsMethod lookInLister mainReport makeOn makeOpen matchObj
syn keyword tadsMethod matchTopic maxScore moved moved moveInto
syn keyword tadsMethod moveIntoForTravel myItemClass name name name
syn keyword tadsMethod nameDoes nameDoes nameIs nameIsnt nameSays
syn keyword tadsMethod nameSays nameSees nameSees nestedAction nextObj
syn keyword tadsMethod nextState north northeast northwest notifyRemove
syn keyword tadsMethod notifySoundEvent notTravelReadyMsg npcContinueMsg
syn keyword tadsMethod npcGreetingMsg objectNotifyList objInPrep
syn keyword tadsMethod obscuredInitSpecialDesc obscuredSpecialDesc ofKind
syn keyword tadsMethod out owner patUpperOrDigit patVowelY
syn keyword tadsMethod pluralDisambigName pluralName pluralName
syn keyword tadsMethod pluralOrder posture preCond pronounSelector
syn keyword tadsMethod readDesc remapTo remoteInitSpecialDesc
syn keyword tadsMethod remoteRoomContentsLister removeElement removeEvent
syn keyword tadsMethod replaceAction room1 room2 roomDarkName
syn keyword tadsMethod roomLocation roomName roomParts seen setCurState
syn keyword tadsMethod showAbout showCredit showGoodbye showIntro
syn keyword tadsMethod sightPresence sightSize smellPresence smellSize
syn keyword tadsMethod soundPresence soundSize sourceDesc south southeast
syn keyword tadsMethod southwest specialContentsLister specialDesc
syn keyword tadsMethod specialDesc specialDescBeforeContents
syn keyword tadsMethod specialDescListWith specialDescOrder
syn keyword tadsMethod specialNominalRoomPartLocation spellInt stateDesc
syn keyword tadsMethod subContainer subLocation subRear subSurface
syn keyword tadsMethod subUnderside suppressAutoSeen takeFromNotInMessage
syn keyword tadsMethod takeTurn targetObj tasteDesc thatIsContraction
syn keyword tadsMethod thatNom thatObj theDisambigName theDisambigName
syn keyword tadsMethod theName theName theNamePossNoun toList
syn keyword tadsMethod topicResponse touchPresence touchSize travelDesc
syn keyword tadsMethod triggerEvent up useSpecialDesc verbPhrase verify
syn keyword tadsMethod version vocabLikelihood vocabWords vocabWords
syn keyword tadsMethod weakTokens weight west
syn keyword tadsMethod setAboutBox showGoodBye

hi def link tadsClassName Identifier
hi def link tadsMethod Function
hi def link tadsConstant Constant

let b:current_syntax = "tads"

