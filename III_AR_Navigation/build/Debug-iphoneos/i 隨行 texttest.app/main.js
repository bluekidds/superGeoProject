/* main.js */

/*
Copyright (c) 2008-2010 wayne a. lee

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
*/

var rotY = 0;
var rotX = 0;

var activeTouchId = 0;
var lastX;
var lastY;

function init()
{
    hideUrlBar();
    //  touch events!
    if (hasTouchEvent()) {
        var e = document.getElementById("controller");
        e.addEventListener("touchstart", startTouch, false);
        e.addEventListener("touchmove", moveTouch, false);
        e.addEventListener("touchend", endTouch, false);
        e.addEventListener("touchcancel", cancelTouch, false);
        document.addEventListener("touchstart", startTouch, false);
        document.addEventListener("touchmove", moveTouch, false);
        document.addEventListener("touchend", endTouch, false);
        document.addEventListener("touchcancel", cancelTouch, false);

        e.addEventListener("gesturestart", stubOut, false);
        e.addEventListener("gesturechanged", stubOut, false);
        document.addEventListener("gesturestart", stubOut, false);
        document.addEventListener("gesturechanged", stubOut, false);
    }
    
    var loadingE = document.getElementById("loading");
    loadingE.parentNode.removeChild(loadingE);
}


function startTouch(e)
{
    e.preventDefault();
    //  take the first touch
    activeTouchId = e.changedTouches[0].identifier;
    lastX = e.changedTouches[0].pageX;
    lastY = e.changedTouches[0].pageY;
}


function moveTouch(e)
{
    e.preventDefault();

    if (activeTouchId) {
        //  see if the tracked finger was actually moved
        for (var i=0; i<e.changedTouches.length; i++) {
            if (e.changedTouches[i].identifier == activeTouchId) {
                //  it did move!
                var t = e.changedTouches[i];
                rotateByTouch(lastX, lastY, t.pageX, t.pageY);
                lastX = t.pageX;
                lastY = t.pageY;
                break;  //  stop searching
            }
        }
    }
}


function endTouch(e)
{
    e.preventDefault();

    if (activeTouchId) {
        //  see if the tracked finger was actually lifted
        for (var i=0; i<e.changedTouches.length; i++) {
            if (e.changedTouches[i].identifier == activeTouchId) {
                //  yup
                activeTouchId = 0;  //  stop following it
                break;  //  stop searching
            }
        }
    }    
}


function cancelTouch(e)
{
    activeTouchId = 0;
}


function rotateByTouch(lastX, lastY, curX, curY)
{
    var e = document.getElementById('cube');
    if ( ! e)
        return;

    rotY -= (curX - lastX) * 0.25;
    rotX += (curY - lastY) * 0.25;
    rotX = Math.max(-88, Math.min(88, rotX));

    e.style.webkitTransform = 'translateZ(200px) rotateX(' + rotX + 'deg) rotateY(' + rotY + 'deg)';
}

function stubOut(e)
{
    e.preventDefault();
}

function hasTouchEvent()
{
    if (document && document.createEvent) {
        try {
            document.createEvent('TouchEvent');
            return true;
        }
        catch (e) {
            //  silently fail
        }
    }
    return false;
}


function hideUrlBar()
{
    setTimeout(function () { window.scrollTo(0, 1) }, 100);
}
