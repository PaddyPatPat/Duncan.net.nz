// Declaring variables.
var totalSpanCharacters = 0;

// Load functions that update when the page is scrolled.
function scrollingFunctions()
{
	visibleReferences();
	visibleContributors();
}

// Functions and start when the page has loaded.
function onloadFunctions()
{
	totalSpanChars();
}

// Only show the references for the content that is currently visible.
function visibleReferences() 
{
	if(!document.getElementById || !document.createElement){return;}

	// Variables
	var referenceSpanElements = new Array();
	var referenceListArray = new Array();
	var referenceList = document.getElementById("references").children;
	
	// Make all the references disappear before I make the ones I want visible.
	for (var i = 0; i < referenceList.length; i++)
	{
		if (!referenceList[i].style) {alert("References style not working");}
		referenceList[i].style.display = "none";
	}
		
	// Find all the span elements that are referenced.
	interestingSpans("refid",referenceSpanElements);
	
	// Make the references show for their content that is currently in the screen's viewport. 
	currentlyVisible(referenceSpanElements,referenceList,"refid");	
}

// Only show the contributors for the content that is currently visible.
function visibleContributors()
{
	if(!document.getElementById || !document.createElement){return;}
	
	// Variables
	var contributorSpanElements = new Array();
	if (document.getElementById("referenceList").childNodes.item(1).nodeName == "UL") // Firefox
	{
		var contributorsList = document.getElementById("referenceList").childNodes.item(1).children;
	}
	else if (document.getElementById("referenceList").childNodes.item(3).nodeName == "UL") // Safari and Chrome
	{
		var contributorsList = document.getElementById("referenceList").childNodes.item(3).children;
	}

	// Make all the contributors disappear before I make the ones I want visible.
	for (var i = 0; i < contributorsList.length; i++)
	{
		if (!contributorsList[i].style) {alert("Contributor style not working");}
		contributorsList[i].style.display="none";
	}
	
	// Find all the span elements that have contributors.
	interestingSpans("conid",contributorSpanElements);
	
	// Make the contributors show for their content that is currently in the screen's viewport.
	currentlyVisible(contributorSpanElements,contributorsList,"conid");
}


// Calculate the number of characters in all the spans inside the "document" div.
function totalSpanChars()
{
	var allSpans = new Array();
	
	interestingSpans("class",allSpans);
	for (i=0;i<allSpans.length;i++)
	{
		totalSpanCharacters = totalSpanCharacters + allSpans[i].firstChild.length;
	}
}


// Find all the span elements that contain the attribute I'm interested in.
function interestingSpans(spanAttribute,theArrayOfSpans)
{
	var spans = document.getElementsByTagName("span"); 
	for (i=0;i<spans.length;i++)
	{
		if(spans[i].hasAttribute (spanAttribute))
		{
			theArrayOfSpans.push(spans[i]);
		}
	}
}


// Work out what objects are currently in the screen's viewport.
function currentlyVisible(spanObj,listObj,listObjID)
{
	for (i=0;i<spanObj.length;i++)
	{
		if (
			((findPos(spanObj[i]) < window.scrollY)
			&& 
			((findPos(spanObj[i])+spanObj[i].offsetHeight) > window.scrollY))
			||
			((findPos(spanObj[i]) > window.scrollY)
			&&
			(findPos(spanObj[i]) < (window.scrollY+document.documentElement.clientHeight)))
			)
		{
			for ( var k = 0; k < listObj.length; k++)
			{	
				if ( listObj.item(k).getAttribute(listObjID) == spanObj[i].getAttribute(listObjID))  // **** Added parentNode / listObj.item(k).getAttribute(listObjID)
				{
					listObj[k].style.display="";
				}
			}
		}
	}
}

	
// Working out distance of each object from the top of the page.
function findPos(obj)
{
	var curtop = 0;
	if (obj.offsetParent) 
	{
		do 
		{
			curtop += obj.offsetTop;
		}
		while (obj = obj.offsetParent);
	}
	else
	{
		alert("offsetParent not supported");
	}
	return curtop;
}


//keep element in view - jQuery - referenceList
(function($)
{
    $(document).ready( function()
    {
		var elementPos = document.getElementById('referenceList');
        var elementPosTop = findPos(elementPos); // $('#referenceList').position().top;
        $(window).scroll(function()
        {
            var wintop = $(window).scrollTop(), docheight = $(document).height(), winheight = $(window).height();
            //if top of element is in view
            if (wintop > elementPosTop)
            {
                //always in view
                $(elementPos).css({ "position":"fixed", "top":"-3em" });
            }
            else
            {
                //reset back to normal viewing
                $(elementPos).css({ "position":"inherit" });
            }
        });
    });
})(jQuery);


//keep element in view - jQuery - contents
(function($)
{
    $(document).ready( function()
    {
		var elementPos = document.getElementById('contents');
        var elementPosTop = findPos(elementPos); // $('#referenceList').position().top;
        $(window).scroll(function()
        {
            var wintop = $(window).scrollTop(), docheight = $(document).height(), winheight = $(window).height();
            //if top of element is in view
            if (wintop > elementPosTop)
            {
                //always in view
                $(elementPos).css({ "position":"fixed", "top":"-6em", "width":"18%" });
            }
            else
            {
                //reset back to normal viewing
                $(elementPos).css({ "position":"inherit", "width":"" });
            }
        });
    });
})(jQuery);



// Highlight reference on mouseover of text.
// For References
function refHover(hoverSpan) 
{
	// Select the span's refID
	var hoverSpanRefID = hoverSpan.getAttribute("refid");
	
	// Find all of the references and deal with differing browsers.
	if (document.getElementById("referenceList").lastChild.previousSibling.nodeName == "DIV") // Safari and Chrome
	{
		var theList = document.getElementById("referenceList").lastChild.previousSibling.children;
	}
	else if (document.getElementById("referenceList").lastChild.nodeName == "DIV") // Firefox
	{
		var theList = document.getElementById("referenceList").lastChild.children;
	} 
	
	// Only apply the class to the reference element that has the same refID as the span.
	for (var i=0;i<theList.length;i++)
	{
		if ( hoverSpanRefID == theList[i].getAttribute("refid"))
		{
			theList[i].setAttribute("class", "refHover");
		}
	}
}

function refUnhover(hoverSpan)
{
	// Select the span's refID
	var hoverSpanRefID = hoverSpan.getAttribute("refid");
	var theList = new Array();
	// Find all of the references and deal with differing browsers.
	if (document.getElementById("referenceList").lastChild.previousSibling.nodeName == "DIV") // Safari and Chrome
	{
		var theList = document.getElementById("referenceList").lastChild.previousSibling.children;
	}
	else if (document.getElementById("referenceList").lastChild.nodeName == "DIV") // Firefox
	{
		var theList = document.getElementById("referenceList").lastChild.children;
	} 
	
	// Only apply the class to the reference element that has the same refID as the span.
	for (var i = 0; i < theList.length; i++)
	{
		if ( hoverSpanRefID == theList[i].getAttribute("refid"))
		{
			theList[i].removeAttribute("class", "refHover");
		}
	}
}


// For Contributors
function conHover(hoverSpan) 
{
	
	// Select the span's refID
	var hoverSpanConID = hoverSpan.getAttribute("conid");
	
	// Find all of the references and deal with differing browsers.
	if (document.getElementById("referenceList").childNodes.item(3).nodeName == "UL") //Safari and Chrome
	{
		var theList = document.getElementById("referenceList").childNodes.item(3).children;
	}
	else if (document.getElementById("referenceList").childNodes.item(1).nodeName == "UL") // Firefox
	{
		var theList = document.getElementById("referenceList").childNodes.item(1).children;
	}
	
	// Only apply the class to the reference element that has the same refID as the span.
	for (i=0;i<theList.length;i++)
	{
		if ( hoverSpanConID == theList[i].getAttribute("conid"))
		{
			theList[i].setAttribute("class", "conHover");
		}
	}
}

function conUnhover(hoverSpan)
{
	// Select the span's refID
	var hoverSpanConID = hoverSpan.getAttribute("conid");

	// Find all of the references and deal with differing browsers.
	if (document.getElementById("referenceList").childNodes.item(3).nodeName == "UL") //Safari and Chrome
	{
		var theList = document.getElementById("referenceList").childNodes.item(3).children;
	}
	else if (document.getElementById("referenceList").childNodes.item(1).nodeName == "UL") // Firefox
	{
		var theList = document.getElementById("referenceList").childNodes.item(1).children;
	}

	
	// Only apply the class to the reference element that has the same refID as the span.
	for (i=0;i<theList.length;i++)
	{
		if ( hoverSpanConID == theList[i].getAttribute("conid"))
		{
			theList[i].removeAttribute("class", "conHover");
		}
	}
}

